import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/models/alarm_model.dart';
import 'package:universiting/models/host_model.dart';
import 'package:universiting/models/profile_model.dart';
import 'package:universiting/models/room_model.dart';
import 'package:universiting/utils/global_variable.dart';
import 'package:http/http.dart' as http;

Future<List<Alarm>> getReciveStatus() async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  var url = Uri.parse('$serverUrl/room_api/alarm_list?type=recive');
  var headers = {'Authorization': 'Token $token'};
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
    return [
      Alarm(
          id: 0,
          userId: 0,
          type: 0,
          targetId: 0,
          content: Room(title: '', hosts: [Host(userId: 0, profileImage: '', gender: 'M')]),
          profile: Profile(
              age: 0,
              gender: '',
              introduction: '',
              nickname: '',
              profileImage: '',
              userId: 0),
          date: DateTime(2020),
          isRead: false)
    ];
  } else {
 
      var response = await http.get(url, headers: headers);

      String responsebody = utf8.decode(response.bodyBytes);
      if (response.statusCode <= 200 && response.statusCode < 300) {
        print(response.statusCode);
        print(jsonDecode(responsebody).runtimeType);
        return alarmParsed(responsebody);
      } else {
        print(response.statusCode);
        return [
          Alarm(
              id: 0,
              userId: 0,
              type: 0,
              targetId: 0,
              content: Room
              (title: '', hosts: [Host(userId: 0, profileImage: '', gender: 'M')]),
              profile: Profile(
                  age: 0,
                  gender: '',
                  introduction: '',
                  nickname: '',
                  profileImage: '',
                  userId: 0),
              date: DateTime(2020),
              isRead: false)
        ];
      }
  }
  // return [
  //   Alarm(
  //       id: 0,
  //       userId: 0,
  //       type: 0,
  //       targetId: 0,
  //       content: Room(title: '', hosts: [Host(userId: 0, profileImage: '', gender: 'M')], totalMember: 0),
  //       profile: Profile(
  //           age: 0,
  //           gender: '',
  //           introduction: '',
  //           nickname: '',
  //           profileImage: '',
  //           userId: 0),
  //       date: DateTime(2020),
  //       isRead: false)
  // ];
}


Future<void> hostMemberAlarm(String room_id, String type) async {

  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  var url = Uri.parse('$serverUrl/room_api/host_member');

  var body = {
    'room_id': room_id,
    'type': type
  };
  var headers = {
    'Authorization': 'Token $token',
  };
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
  } else {
    var response =
        await http.put(url, headers: headers, body: body);
    String responsebody = utf8.decode(response.bodyBytes);
    if (response.statusCode <= 200 && response.statusCode < 300) {
      print(responsebody);
      print('${response.statusCode} 거절 또는 수락');

    } else {
      print('${response.statusCode} 거절 또는 수락');
    }
  }
}

Future<void> okJoinAlarm(String room_id,String from_id, String type) async {

  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  var url = Uri.parse('$serverUrl/room_api/join_member');

  var body = {
    'room_id': room_id,
    'from_id' : from_id,
    'type': type
  };
  var headers = {
    'Authorization': 'Token $token',
  };
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
  } else {
    var response =
        await http.put(url, headers: headers, body: body);
    String responsebody = utf8.decode(response.bodyBytes);
    if (response.statusCode <= 200 && response.statusCode < 300) {
      print(responsebody);
      print('${response.statusCode} 거절 또는 수락');

    } else {
      print('${response.statusCode} 거절 또는 수락');
    }
  }
}

Future<void> deleteAlarm(String id) async {
  print(id);
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  var url = Uri.parse('$serverUrl/room_api/alarm_list?id=$id');

  var headers = {
    'Authorization': 'Token $token',
  };
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
  } else {
    var response =
        await http.delete(url, headers: headers);
    String responsebody = utf8.decode(response.bodyBytes);
    if (response.statusCode <= 200 && response.statusCode < 300) {
      print(responsebody);
      print('${response.statusCode}삭제하기');

    } else {
     print('${response.statusCode}삭제가 안됐습니다');
    }
  }
}