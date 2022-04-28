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
import 'package:universiting/controllers/room_info_controller.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/controllers/participate_controller.dart';
import 'package:universiting/controllers/room_detail_controller.dart';
import 'package:universiting/controllers/select_member_controller.dart';
import 'package:universiting/controllers/status_controller.dart';
import 'package:universiting/controllers/status_room_tab_controller.dart';
import 'package:universiting/models/host_model.dart';
import 'package:universiting/models/my_room_model.dart';
import 'package:universiting/models/profile_model.dart';
import 'package:universiting/models/room_model.dart';
import 'package:universiting/models/select_member_model.dart';
import 'package:universiting/utils/global_variable.dart';
import 'package:http/http.dart' as http;

Future<MyRoom> getMyRoom() async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  var url = Uri.parse('$serverUrl/room_api/my_room');
  var headers = {'Authorization': 'Token $token'};
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
    return MyRoom(chiefList: []);
  } else {
      var response = await http.get(url, headers: headers);
      print(response.statusCode);
      String responsebody = utf8.decode(response.bodyBytes);
      if (response.statusCode <= 200 && response.statusCode < 300) {
        // selectMemberController.seletedMember.value =
        //     SelectMember.fromJson(jsonDecode(responsebody));
        return MyRoom.fromJson(jsonDecode(responsebody));
      } else {
        print(response.statusCode);
        return MyRoom(chiefList: []);;
      }
    
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

  var body = {
    'title': createRoomController.roomTitleController.text,
    'totalmember': (createRoomController.members.length + 1).toString(),
    'introduction': createRoomController.introController.text,
    'member_id': createRoomController.members.toString()
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

Future<Room> getDetailRoom(String id) async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  var url = Uri.parse('$serverUrl/room_api/room?type=room&room_id=${id}');
  var headers = {'Authorization': 'Token $token'};
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
    return Room(id: 0, title: '', hosts: <Host>[], totalMember: 0, type: false);
  } else {
    try {
      var response = await http.get(url, headers: headers);
      print(response.statusCode);
      String responsebody = utf8.decode(response.bodyBytes);
      if (response.statusCode <= 200 && response.statusCode < 300) {
        print(responsebody);
        return Room.fromJson(jsonDecode(responsebody));
      } else {
        print(response.statusCode);
        return Room(
            id: 0, title: '', hosts: <Host>[], totalMember: 0, type: false);
      }
    } catch (e) {
      print(e);
      showcustomCustomDialog(1200);
      return Room(
          id: 0, title: '', hosts: <Host>[], totalMember: 0, type: false);
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


