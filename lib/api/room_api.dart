import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/check_people_controller.dart';
import 'package:universiting/controllers/create_room_controller.dart';
import 'package:universiting/controllers/select_friend_controller.dart';
import 'package:universiting/models/select_member_model.dart';
import 'package:universiting/utils/global_variable.dart';
import 'package:http/http.dart' as http;

Future<void> getMyRoom() async {
  SelectMemberController selectMemberController = Get.find();
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  var url = Uri.parse(
      '$serverUrl/room_api/my_list');
  var headers = {'Authorization': 'Token $token'};
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
  } else {
    try {
      var response = await http.get(url, headers: headers);
      print(response.statusCode);
      String responsebody = utf8.decode(response.bodyBytes);
      if (response.statusCode <= 200 && response.statusCode < 300) {
        selectMemberController.member.value =
            SelectMember.fromJson(jsonDecode(responsebody));
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      showCustomDialog('서버 점검중입니다.', 1200);
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
      var response = await http.get(url, headers: headers);
      print(response.statusCode);
      String responsebody = utf8.decode(response.bodyBytes);
      if (response.statusCode <= 200 && response.statusCode < 300) {
        selectMemberController.member.value =
            SelectMember.fromJson(jsonDecode(responsebody));
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      showCustomDialog('서버 점검중입니다.', 1200);
    }
  }
}

Future<void> makeRoom() async {
  CreateRoomController createRoomController = Get.find();
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
    var response =
        await http.post(url, headers: headers, body: body);
    print(response.statusCode);
    String responsebody = utf8.decode(response.bodyBytes);
    if (response.statusCode <= 200 && response.statusCode < 300) {
      print(responsebody);
      print(response.statusCode);
      Get.back();
    } else {
      print(response.statusCode);
    }
  }
}
