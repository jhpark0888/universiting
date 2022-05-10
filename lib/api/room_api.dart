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

Future<HTTPResponse> getMyRoom(int last) async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  var url =
      Uri.parse('$serverUrl/room_api/my_room?type=all&last=${last.toString()}');
  var headers = {'Authorization': 'Token $token'};
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
    return HTTPResponse.networkError();
  } else {
    // try {
    var response = await http.get(url, headers: headers);
    print('내방 불러오기 : ${response.statusCode}');
    String responsebody = utf8.decode(response.bodyBytes);
    if (response.statusCode <= 200 && response.statusCode < 300) {
      // selectMemberController.seletedMember.value =
      //     SelectMember.fromJson(jsonDecode(responsebody));
      return HTTPResponse.success(MyRoom.fromJson(jsonDecode(responsebody)));
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

Future<HTTPResponse> getSendlist(String type, int last) async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  var url = Uri.parse(
      '$serverUrl/room_api/send_list?type=${type}&last=${last.toString()}');
  var headers = {'Authorization': 'Token $token'};
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400);
    return HTTPResponse.networkError();
  } else {
    try {
      var response = await http.get(url, headers: headers);
      print('보낸신청 불러오기 : ${response.statusCode}');
      String responsebody = utf8.decode(response.bodyBytes);
      if (response.statusCode <= 200 && response.statusCode < 300) {
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
      '$serverUrl/room_api/request_list?type=${type}&last=${last.toString()}&room_id=${id.toString()}');
  var headers = {'Authorization': 'Token $token'};
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400);
    return HTTPResponse.networkError();
  } else {
    // try {
    var response = await http.get(url, headers: headers);
    print('내 방 신청 불러오기 : ${response.statusCode}');
    String responsebody = utf8.decode(response.bodyBytes);
    if (response.statusCode <= 200 && response.statusCode < 300) {
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
      '$serverUrl/user_api/search_member?nickname=${selectMemberController.nickName}');
  var headers = {'Authorization': 'Token $token'};
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
  } else {
    try {
      selectMemberController.searchtype(SearchType.loading);
      var response = await http.get(url, headers: headers);
      print('친구 검색 : ${response.statusCode}');
      String responsebody = utf8.decode(response.bodyBytes);
      if (response.statusCode <= 200 && response.statusCode < 300) {
        selectMemberController.searchtype(SearchType.success);
        selectMemberController.seletedMember.value =
            Profile.fromJson(jsonDecode(responsebody));
      } else if (response.statusCode == 404) {
        selectMemberController.searchtype(SearchType.empty);
      } else {}
    } on SocketException {
      selectMemberController.searchtype(SearchType.error);
      showCustomDialog('서버 점검중입니다.', 1200);
    } catch (e) {
      selectMemberController.searchtype(SearchType.error);
      showCustomDialog('서버 점검중입니다.', 1200);
    }
  }
}

Future<void> makeRoom() async {
  RoomInfoController createRoomController = Get.find();
  // CheckPeopleController checkPeopleController = Get.find();
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  var url = Uri.parse('$serverUrl/room_api/room');

  List<int> memberid = createRoomController.members.value;
  memberid.removeAt(0);

  var body = {
    'title': createRoomController.roomTitleController.text,
    'totalmember': (memberid.length + 1).toString(),
    'introduction': createRoomController.introController.text,
    'member_id': memberid.toString()
  };
  var headers = {
    'Authorization': 'Token $token',
  };
  if (result == ConnectivityResult.none) {
    Get.back();
    showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
  } else {
    try {
      var response = await http.post(url, headers: headers, body: body);
      print('방 만들기: ${response.statusCode}');
      String responsebody = utf8.decode(response.bodyBytes);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        Get.back();
        Get.back();
        print(responsebody);
        print(response.statusCode);
      } else {
        print(response.statusCode);
      }
    } on SocketException {
      Get.back();
      showCustomDialog('서버 점검중입니다.', 1200);
    } catch (e) {
      Get.back();
      print(e);
      showCustomDialog('서버 점검중입니다.', 1200);
    }
  }
}

Future<HTTPResponse> getDetailRoom(String id) async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  var url = Uri.parse('$serverUrl/room_api/room?type=room&room_id=${id}');
  var headers = {'Authorization': 'Token $token'};
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
    return HTTPResponse.networkError();
  } else {
    try {
      var response = await http.get(url, headers: headers);
      print('방 로드api : ${response.statusCode}');
      String responsebody = utf8.decode(response.bodyBytes);
      if (response.statusCode <= 200 && response.statusCode < 300) {
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
  var url = Uri.parse('$serverUrl/room_api/host_member');

  var body = {
    'room_id': roomId.toString(),
    'type': type,
  };
  var headers = {
    'Authorization': 'Token $token',
  };
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
    return HTTPResponse.networkError();
  } else {
    try {
      var response = await http.put(url, headers: headers, body: body);
      String responsebody = utf8.decode(response.bodyBytes);
      print('방 참가 or 거절 : ${response.statusCode}');
      if (response.statusCode <= 200 && response.statusCode < 300) {
        return HTTPResponse.success(type);
      } else {
        print(response.statusCode);
        return HTTPResponse.apiError('apierror', response.statusCode);
      }
    } on SocketException {
      Get.back();
      showCustomDialog('서버 점검중입니다.', 1200);
      return HTTPResponse.serverError();
    } catch (e) {
      Get.back();
      print(e);
      showCustomDialog('서버 점검중입니다.', 1200);
      return HTTPResponse.unexpectedError(e);
    }
  }
}

Future<void> roomJoin(String room_id) async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  var url = Uri.parse('$serverUrl/room_api/join_member');

  var body = {
    'room_id': room_id,
    'member_id': ParticipateController.to.members.toString(),
    'introduction': ParticipateController.to.introController.text
  };
  var headers = {
    'Authorization': 'Token $token',
  };
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
  } else {
    try {
      var response = await http.post(url, headers: headers, body: body);
      String responsebody = utf8.decode(response.bodyBytes);
      if (response.statusCode <= 200 && response.statusCode < 300) {
        print(responsebody);
        print(response.statusCode);
        AppController.to.getbacks();
        AppController.to.currentIndex.value = 2;
        Get.back();
        await getSendStatus().then((httpresponse) {
          if (httpresponse.isError == false) {
            StatusController.to.sendList(httpresponse.data);
          }
        });
        StatusController.to.makeAllSendList();
        StatusRoomTabController.to.currentIndex.value = 1;
      } else {
        print(response.statusCode);
      }
    } on SocketException {
      Get.back();
      showCustomDialog('서버 점검중입니다.', 1200);
    } catch (e) {
      Get.back();
      print(e);
      showCustomDialog('서버 점검중입니다.', 1200);
    }
  }
}

Future<void> deleteMyRoom(String id) async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  var url = Uri.parse('$serverUrl/room_api/room');

  var body = {'room_id': id};
  var headers = {
    'Authorization': 'Token $token',
  };
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
  } else {
    var response = await http.delete(url, headers: headers, body: body);
    String responsebody = utf8.decode(response.bodyBytes);
    if (response.statusCode <= 200 && response.statusCode < 300) {
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
  var url = Uri.parse('$serverUrl/room_api/report_room');

  var body = {'id': roomId, 'reason': reason};
  var headers = {
    'Authorization': 'Token $token',
  };
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
  } else {
    var response = await http.post(url, headers: headers, body: body);
    String responsebody = utf8.decode(response.bodyBytes);
    if (response.statusCode <= 200 && response.statusCode < 300) {
      print(responsebody);
      print(response.statusCode);
    } else {
      print(response.statusCode);
    }
  }
}



// '$serverUrl/room_api/report_room
//body{id(방 아이디),reason(text)}


