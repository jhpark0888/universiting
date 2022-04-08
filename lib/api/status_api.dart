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

Future<List<AlarmReceive>> getReceiveStatus() async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  var url = Uri.parse('$serverUrl/room_api/alarm_list?type=receive');
  var headers = {'Authorization': 'Token $token'};
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
    return [
      AlarmReceive(
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
        return alarmReceiveParsed(responsebody);
      } else if(response.statusCode == 500){
        print(response.statusCode);
        return [];
      } else {
        print(response.statusCode);
        return [
          AlarmReceive(
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

Future<List<AlarmSend>> getSendStatus() async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  var url = Uri.parse(
      '$serverUrl/room_api/alarm_list?type=send');
  var headers = {'Authorization': 'Token $token'};
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
    return [AlarmSend(id: 0, room: Room(title: ''), joinmember: <Host>[])];
  } else {
    try {
      var response = await http.get(url, headers: headers);
      print(response.statusCode);
      String responsebody = utf8.decode(response.bodyBytes);
      if (response.statusCode <= 200 && response.statusCode < 300) {
        print('getSendStatus()의 상태코드 : ${response.statusCode}');
        return alarmSendParsed(responsebody);
      } else {
        print(response.statusCode);
        return [AlarmSend(id: 0, room: Room(title: ''), joinmember: <Host>[])];
      }
    } catch (e) {
      showCustomDialog('서버 점검중입니다.', 1200);
    }
    return [AlarmSend(id: 0, room: Room(title: ''), joinmember: <Host>[])];
  }
}

Future<void> joinToChat(AlarmReceive alarmReceive) async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  var url = Uri.parse('$serverUrl/chat/make_group');

  var headers = {
    'Authorization': 'Token $token',
  };
  var body = {
    'room_id' : alarmReceive.targetId.toString(),
    'creater_id' : alarmReceive.profile.userId.toString()
  };
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
  } else {
    var response =
        await http.post(url, headers: headers, body: body);
    String responsebody = utf8.decode(response.bodyBytes);
    if (response.statusCode <= 200 && response.statusCode < 300) {
      print(responsebody);
      print('${response.statusCode}삭제하기');

    } else {
     print('${response.statusCode}삭제가 안됐습니다');
    }
  }
}

Future<void> rejectToChat(AlarmReceive alarmReceive) async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  var url = Uri.parse('$serverUrl/chat/make_group');

  var headers = {
    'Authorization': 'Token $token',
  };
  var body = {
    'room_id' : alarmReceive.targetId.toString(),
    'creater_id' : alarmReceive.profile.userId.toString()
  };
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
  } else {
    var response =
        await http.delete(url, headers: headers, body: body);
    String responsebody = utf8.decode(response.bodyBytes);
    if (response.statusCode <= 200 && response.statusCode < 300) {
      print(responsebody);
      print('${response.statusCode}삭제하기');

    } else {
     print('${response.statusCode}삭제가 안됐습니다');
    }
  }
}