import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/models/alarm_model.dart';
import 'package:universiting/models/host_model.dart';
import 'package:universiting/models/httpresponse_model.dart';
import 'package:universiting/models/profile_model.dart';
import 'package:universiting/models/room_model.dart';
import 'package:universiting/models/send_request_model.dart';
import 'package:universiting/utils/global_variable.dart';
import 'package:http/http.dart' as http;

Future<HTTPResponse> getReceiveStatus() async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  var url = Uri.parse('$serverUrl/room_api/alarm_list?type=receive');
  var headers = {'Authorization': 'Token $token'};
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400);
    return HTTPResponse.networkError();
  } else {
    try {
      var response = await http.get(url, headers: headers);

      String responsebody = utf8.decode(response.bodyBytes);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print(response.statusCode);
        print(jsonDecode(responsebody).runtimeType);
        return HTTPResponse.success(alarmReceiveParsed(responsebody));
      } else if (response.statusCode == 500) {
        print(response.statusCode);
        return HTTPResponse.apiError('', response.statusCode);
      } else {
        print(response.statusCode);
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

Future<void> hostMemberAlarm(String room_id, String type) async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  var url = Uri.parse('$serverUrl/room_api/host_member');

  var body = {'room_id': room_id, 'type': type};
  var headers = {
    'Authorization': 'Token $token',
  };
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400);
  } else {
    var response = await http.put(url, headers: headers, body: body);
    String responsebody = utf8.decode(response.bodyBytes);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      print(responsebody);
      print('${response.statusCode} 거절 또는 수락');
    } else {
      print('${response.statusCode} 거절 또는 수락');
    }
  }
}

Future<void> okJoinAlarm(String room_id, String from_id, String type) async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  var url = Uri.parse('$serverUrl/room_api/join_member');

  var body = {'room_id': room_id, 'from_id': from_id, 'type': type};
  var headers = {
    'Authorization': 'Token $token',
  };
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400);
  } else {
    var response = await http.put(url, headers: headers, body: body);
    String responsebody = utf8.decode(response.bodyBytes);
    if (response.statusCode >= 200 && response.statusCode < 300) {
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
    showCustomDialog('네트워크를 확인해주세요', 1400);
  } else {
    var response = await http.delete(url, headers: headers);
    String responsebody = utf8.decode(response.bodyBytes);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      print(responsebody);
      print('${response.statusCode}삭제하기');
    } else {
      print('${response.statusCode}삭제가 안됐습니다');
    }
  }
}

Future<HTTPResponse> getSendStatus() async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  var url = Uri.parse('$serverUrl/room_api/alarm_list?type=send');
  var headers = {'Authorization': 'Token $token'};
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400);
    return HTTPResponse.networkError();
  } else {
    try {
      var response = await http.get(url, headers: headers);
      print(response.statusCode);
      String responsebody = utf8.decode(response.bodyBytes);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print('getSendStatus()의 상태코드 : ${response.statusCode}');
        return HTTPResponse.success(alarmSendParsed(responsebody));
      } else {
        print(response.statusCode);
        return HTTPResponse.apiError('', response.statusCode);
      }
    } on SocketException {
      showCustomDialog('서버 점검중입니다.', 1200);
      return HTTPResponse.serverError();
    } catch (e) {
      print(e);
      return HTTPResponse.unexpectedError(e);
    }
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
    'room_id': alarmReceive.targetId.toString(),
    'creater_id': alarmReceive.profile.userId.toString()
  };
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400);
  } else {
    var response = await http.post(url, headers: headers, body: body);
    String responsebody = utf8.decode(response.bodyBytes);
    if (response.statusCode >= 200 && response.statusCode < 300) {
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
    'room_id': alarmReceive.targetId.toString(),
    'creater_id': alarmReceive.profile.userId.toString()
  };
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400);
  } else {
    var response = await http.delete(url, headers: headers, body: body);
    String responsebody = utf8.decode(response.bodyBytes);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      print(responsebody);
      print('${response.statusCode}삭제하기');
    } else {
      print('${response.statusCode}삭제가 안됐습니다');
    }
  }
}

Future<HTTPResponse> getDetailSendView(
    int id, StateManagement management) async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  var url = Uri.parse(
      '$serverUrl/room_api/send_list?type=${management == StateManagement.theyReject ? 'reject' : management == StateManagement.friendReject ? 'reject' : 'join'}/detail&id=${id.toString()}');
  var headers = {'Authorization': 'Token $token'};
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400);
    return HTTPResponse.networkError();
  } else {
    try {
      var response = await http.get(url, headers: headers);

      String responsebody = utf8.decode(response.bodyBytes);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print(response.statusCode);
        print(jsonDecode(responsebody).runtimeType);
        return HTTPResponse.success(
            SendRequest.fromJson(jsonDecode(responsebody)));
        // SendRequest.fromJson(jsonDecode(responsebody))
      } else if (response.statusCode == 500) {
        print(response.statusCode);
        return HTTPResponse.apiError('', response.statusCode);
      } else {
        print(response.statusCode);
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
