import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/check_people_controller.dart';
import 'package:universiting/controllers/room_info_controller.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/controllers/participate_controller.dart';
import 'package:universiting/controllers/room_detail_controller.dart';
import 'package:universiting/controllers/select_member_controller.dart';
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
    return MyRoom(chiefList: [], memberList: []);
  } else {
    try {
      var response = await http.get(url, headers: headers);
      print(response.statusCode);
      String responsebody = utf8.decode(response.bodyBytes);
      if (response.statusCode <= 200 && response.statusCode < 300) {
        // selectMemberController.seletedMember.value =
        //     SelectMember.fromJson(jsonDecode(responsebody));
        return MyRoom.fromJson(jsonDecode(responsebody));
      } else {
        print(response.statusCode);
        return MyRoom(chiefList: [], memberList: []);
      }
    } catch (e) {
      showCustomDialog('서버 점검중입니다.', 1200);
    }
    return MyRoom(chiefList: [], memberList: []);
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
      var response = await http.get(url, headers: headers);
      print(response.statusCode);
      String responsebody = utf8.decode(response.bodyBytes);
      if (response.statusCode <= 200 && response.statusCode < 300) {
        selectMemberController.seletedMember.value =
            Profile.fromJson(jsonDecode(responsebody));
      } else if (response.statusCode == 404) {
        print(response.statusCode);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      showCustomDialog('서버 점검중입니다.', 1200);
    }
  }
}

Future<void> makeRoom() async {
  RoomInfoController createRoomController = Get.find();
  CheckPeopleController checkPeopleController = Get.find();
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  var url = Uri.parse('$serverUrl/room_api/room');

  var body = {
    'title': createRoomController.roomTitleController.text,
    'totalmember': checkPeopleController.peopleNumber.toString(),
    'introduction': createRoomController.introController.text,
    'member_id': createRoomController.members.toString()
  };
  var headers = {
    'Authorization': 'Token $token',
  };
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
  } else {
    var response = await http.post(url, headers: headers, body: body);
    print(response.statusCode);
    String responsebody = utf8.decode(response.bodyBytes);
    if (response.statusCode <= 200 && response.statusCode < 300) {
      print(responsebody);
      print(response.statusCode);
    } else {
      print(response.statusCode);
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
    }catch(e){
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
    'member_id': ParticipateController.to.members.toString()
  };
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

Future<void> deleteMyRoom(String id) async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  var url = Uri.parse('$serverUrl/room_api/room');

  var body = {'room_id' : id};
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

  var body = {
    'id': roomId,
    'reason' : reason
  };
  var headers = {
    'Authorization': 'Token $token',
  };
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
  } else {
    var response =
        await http.post(url, headers: headers, body: body);
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


