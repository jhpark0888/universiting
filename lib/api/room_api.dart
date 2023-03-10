import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:universiting/api/status_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/app_controller.dart';
import 'package:universiting/controllers/check_people_controller.dart';
import 'package:universiting/controllers/management_controller.dart';
import 'package:universiting/controllers/room_info_controller.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/controllers/participate_controller.dart';
import 'package:universiting/controllers/room_detail_controller.dart';
import 'package:universiting/controllers/select_member_controller.dart';
import 'package:universiting/controllers/status_controller.dart';
import 'package:universiting/controllers/status_room_tab_controller.dart';
import 'package:universiting/models/host_model.dart';
import 'package:universiting/models/httpresponse_model.dart';
import 'package:universiting/models/my_room_model.dart';
import 'package:universiting/models/myroom_request_model.dart';
import 'package:universiting/models/profile_model.dart';
import 'package:universiting/models/room_model.dart';
import 'package:universiting/models/select_member_model.dart';
import 'package:universiting/models/send_request_model.dart';
import 'package:universiting/utils/global_variable.dart';
import 'package:http/http.dart' as http;
import 'package:universiting/widgets/myroom_widget.dart';
import 'package:universiting/models/environment_model.dart';

Future<HTTPResponse> getMyRoom(int last) async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  var url = Uri.parse(
      '${Environment.apiUrl}/room_api/my_room?type=all&last=${last.toString()}');
  var headers = {'Authorization': 'Token $token'};
  print(token);
  if (result == ConnectivityResult.none) {
    return HTTPResponse.networkError();
  } else {
    try {
      var response = await http.get(url, headers: headers);
      print('?????? ???????????? : ${response.statusCode}');
      String responsebody = utf8.decode(response.bodyBytes);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return HTTPResponse.success(MyRoom.fromJson(jsonDecode(responsebody)));
      } else {
        return HTTPResponse.apiError('', response.statusCode);
      }
    } on SocketException {
      return HTTPResponse.serverError();
    } catch (e) {
      print(e);
      return HTTPResponse.unexpectedError(e);
    }
  }
}

Future<HTTPResponse> getSendlist(String type, int last) async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  var url = Uri.parse(
      '${Environment.apiUrl}/room_api/send_list?type=${type}&last=${last.toString()}');
  var headers = {'Authorization': 'Token $token'};
  if (result == ConnectivityResult.none) {
    return HTTPResponse.networkError();
  } else {
    try {
      var response = await http.get(url, headers: headers);
      print('???????????? ???????????? : ${response.statusCode}');
      String responsebody = utf8.decode(response.bodyBytes);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // selectMemberController.seletedMember.value =
        //     SelectMember.fromJson(jsonDecode(responsebody));
        return HTTPResponse.success((jsonDecode(responsebody) as List)
            .map((joinrequest) => SendRequest.fromJson(joinrequest))
            .toList());
      } else {
        return HTTPResponse.apiError('', response.statusCode);
      }
    } on SocketException {
      return HTTPResponse.serverError();
    } catch (e) {
      print(e);
      return HTTPResponse.unexpectedError(e);
    }
  }
}

Future<HTTPResponse> getMyRoomRequestlist(String type, int last, int id) async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  var url = Uri.parse(
      '${Environment.apiUrl}/room_api/request_list?type=${type}&last=${last.toString()}&room_id=${id.toString()}');
  var headers = {'Authorization': 'Token $token'};
  if (result == ConnectivityResult.none) {
    showCustomDialog('??????????????? ??????????????????', 1400);
    return HTTPResponse.networkError();
  } else {
    // try {
    var response = await http.get(url, headers: headers);
    print('??? ??? ?????? ???????????? : ${response.statusCode}');
    String responsebody = utf8.decode(response.bodyBytes);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      // selectMemberController.seletedMember.value =
      //     SelectMember.fromJson(jsonDecode(responsebody));
      return HTTPResponse.success((jsonDecode(responsebody) as List)
          .map((myRoomRequest) => MyRoomRequest.fromJson(myRoomRequest))
          .toList());
    } else {
      return HTTPResponse.apiError('', response.statusCode);
    }
    // } on SocketException {
    //   return HTTPResponse.serverError();
    // } catch (e) {
    //   print(e);
    //   return HTTPResponse.unexpectedError(e);
    // }
  }
}

Future<void> SearchMember() async {
  SelectMemberController selectMemberController = Get.find();
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  var url = Uri.parse(
      '${Environment.apiUrl}/user_api/search_member?nickname=${selectMemberController.nickName}');
  var headers = {'Authorization': 'Token $token'};
  if (result == ConnectivityResult.none) {
    showCustomDialog('??????????????? ??????????????????', 1400);
  } else {
    try {
      selectMemberController.searchtype(SearchType.loading);
      var response = await http.get(url, headers: headers);
      print('?????? ?????? : ${response.statusCode}');
      String responsebody = utf8.decode(response.bodyBytes);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        selectMemberController.searchtype(SearchType.success);
        selectMemberController.seletedMember.value =
            Profile.fromJson(jsonDecode(responsebody));
      } else if (response.statusCode == 404) {
        selectMemberController.searchtype(SearchType.empty);
      } else {}
    } on SocketException {
      selectMemberController.searchtype(SearchType.error);
      showCustomDialog('?????? ??????????????????.', 1200);
    } catch (e) {
      selectMemberController.searchtype(SearchType.error);
      showCustomDialog('?????? ??????????????????.', 1200);
    }
  }
}

Future<HTTPResponse> makeRoom() async {
  RoomInfoController createRoomController = Get.find();
  // CheckPeopleController checkPeopleController = Get.find();
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  var url = Uri.parse('${Environment.apiUrl}/room_api/room');

  var body = {
    'title': createRoomController.roomTitleController.text.trim(),
    'totalmember': (createRoomController.members.length + 1).toString(),
    'introduction': createRoomController.introController.text.trim(),
    'member_id': createRoomController.members.toString()
  };
  var headers = {
    'Authorization': 'Token $token',
  };
  if (result == ConnectivityResult.none) {
    return HTTPResponse.networkError();
  } else {
    try {
      var response = await http.post(url, headers: headers, body: body);
      print('??? ?????????: ${response.statusCode}');
      String responsebody = utf8.decode(response.bodyBytes);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return HTTPResponse.success('success');
      } else {
        print(response.statusCode);
        return HTTPResponse.apiError('', response.statusCode);
      }
    } on SocketException {
      showCustomDialog('?????? ??????????????????.', 1200);
      return HTTPResponse.serverError();
    } catch (e) {
      print(e);
      showCustomDialog('?????? ??????????????????.', 1200);
      return HTTPResponse.unexpectedError(e);
    }
  }
}

Future<HTTPResponse> getDetailRoom(String id) async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  var url =
      Uri.parse('${Environment.apiUrl}/room_api/room?type=room&room_id=${id}');
  var headers = {'Authorization': 'Token $token'};
  if (result == ConnectivityResult.none) {
    showCustomDialog('??????????????? ??????????????????', 1400);
    return HTTPResponse.networkError();
  } else {
    try {
      var response = await http.get(url, headers: headers);
      print('??? ??????api : ${response.statusCode}');
      String responsebody = utf8.decode(response.bodyBytes);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print(responsebody);
        return HTTPResponse.success(Room.fromJson(jsonDecode(responsebody)));
      } else {
        return HTTPResponse.apiError('', response.statusCode);
      }
    } on SocketException {
      return HTTPResponse.serverError();
    } catch (e) {
      print(e);
      // showcustomCustomDialog(1200);
      return HTTPResponse.unexpectedError(e);
    }
  }
}

Future<HTTPResponse> roomparticipate(int roomId, String type) async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  var url = Uri.parse('${Environment.apiUrl}/room_api/host_member');

  var body = {
    'room_id': roomId.toString(),
    'type': type,
  };
  var headers = {
    'Authorization': 'Token $token',
  };
  if (result == ConnectivityResult.none) {
    showCustomDialog('??????????????? ??????????????????', 1400);
    return HTTPResponse.networkError();
  } else {
    try {
      var response = await http.put(url, headers: headers, body: body);
      String responsebody = utf8.decode(response.bodyBytes);
      print('??? ?????? or ?????? : ${response.statusCode}');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return HTTPResponse.success(type);
      } else {
        print(response.statusCode);
        return HTTPResponse.apiError('apierror', response.statusCode);
      }
    } on SocketException {
      Get.back();
      showCustomDialog('?????? ??????????????????.', 1200);
      return HTTPResponse.serverError();
    } catch (e) {
      Get.back();
      print(e);
      showCustomDialog('?????? ??????????????????.', 1200);
      return HTTPResponse.unexpectedError(e);
    }
  }
}

Future<HTTPResponse> roomJoin(String room_id) async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  var url = Uri.parse('${Environment.apiUrl}/room_api/join_member');

  var body = {
    'room_id': room_id,
    'member_id': ParticipateController.to.members.toString(),
    'introduction': ParticipateController.to.introController.text
  };
  var headers = {
    'Authorization': 'Token $token',
  };
  if (result == ConnectivityResult.none) {
    return HTTPResponse.networkError();
  } else {
    try {
      var response = await http.post(url, headers: headers, body: body);
      print('?????? ?????? ????????? : ${response.statusCode}');
      String responsebody = utf8.decode(response.bodyBytes);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return HTTPResponse.success(responsebody);
      } else {
        print(response.statusCode);
        return HTTPResponse.apiError('apierror', response.statusCode);
      }
    } on SocketException {
      return HTTPResponse.serverError();
    } catch (e) {
      print(e);
      return HTTPResponse.unexpectedError(e);
    }
  }
}

Future<HTTPResponse> roomRequestJoin(
    int roomId, String type, int fromId) async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  var url = Uri.parse('${Environment.apiUrl}/room_api/join_member');

  var body = {
    'room_id': roomId.toString(),
    'from_id': fromId.toString(),
    'type': type,
  };
  var headers = {
    'Authorization': 'Token $token',
  };
  if (result == ConnectivityResult.none) {
    showCustomDialog('??????????????? ??????????????????', 1400);
    return HTTPResponse.networkError();
  } else {
    try {
      var response = await http.put(url, headers: headers, body: body);
      String responsebody = utf8.decode(response.bodyBytes);
      print('??? ?????? or ?????? : ${response.statusCode}');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return HTTPResponse.success(type);
      } else {
        print(response.statusCode);
        return HTTPResponse.apiError('apierror', response.statusCode);
      }
    } on SocketException {
      Get.back();
      showCustomDialog('?????? ??????????????????.', 1200);
      return HTTPResponse.serverError();
    } catch (e) {
      Get.back();
      print(e);
      showCustomDialog('?????? ??????????????????.', 1200);
      return HTTPResponse.unexpectedError(e);
    }
  }
}

Future<void> deleteMyRoom(String id) async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  var url = Uri.parse('${Environment.apiUrl}/room_api/room');

  var body = {'room_id': id};
  var headers = {
    'Authorization': 'Token $token',
  };
  if (result == ConnectivityResult.none) {
    showCustomDialog('??????????????? ??????????????????', 1400);
  } else {
    var response = await http.delete(url, headers: headers, body: body);
    String responsebody = utf8.decode(response.bodyBytes);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      print(responsebody);
      print(response.statusCode);
    } else {
      print(response.statusCode);
    }
  }
}

Future<void> reportRoom(String roomId, String reason) async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  var url = Uri.parse('${Environment.apiUrl}/room_api/report_room');

  var body = {'id': roomId, 'reason': reason};
  var headers = {
    'Authorization': 'Token $token',
  };
  if (result == ConnectivityResult.none) {
    showCustomDialog('??????????????? ??????????????????', 1400);
  } else {
    var response = await http.post(url, headers: headers, body: body);
    String responsebody = utf8.decode(response.bodyBytes);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      print(responsebody);
      print(response.statusCode);
    } else {
      print(response.statusCode);
    }
  }
}



// '${Environment.apiUrl}/room_api/report_room
//body{id(??? ?????????),reason(text)}


