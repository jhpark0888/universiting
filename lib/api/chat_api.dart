import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/models/chat_list_model.dart';
import 'package:universiting/models/group_model.dart';
import 'package:universiting/models/host_model.dart';
import 'package:universiting/models/httpresponse_model.dart';
import 'package:universiting/models/message_model.dart';
import 'package:universiting/utils/global_variable.dart';
import 'package:http/http.dart' as http;

Future<List<ChatRoom>> getChatList() async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  var url = Uri.parse('$serverUrl/chat/get_list');
  var headers = {'Authorization': 'Token $token'};
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
    return [
      ChatRoom(
          group: Group(
              countMember: 0,
              id: 0,
              title: '',
              university: '',
              member: <Host>[],
              date: DateTime.now(),
              dateCount: 0),
          newMsg: 0,
          message: Message(date: DateTime.now(), id: 0, message: ''))
    ];
  } else {
    var response = await http.get(url, headers: headers);
    print(response.statusCode);
    String responsebody = utf8.decode(response.bodyBytes);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      print('getChatList의 statuscode : ${response.statusCode}');
      return chatListParsed(responsebody);
    } else {
      print('내 채팅방 목록 불러오기 ${response.statusCode}');
      return [
        ChatRoom(
            group: Group(
                countMember: 0,
                id: 0,
                title: '',
                university: '',
                member: <Host>[],
                date: DateTime.now(),
                dateCount: 0),
            newMsg: 0,
            message: Message(date: DateTime.now(), id: 0, message: ''))
      ];
    }
  }
}

Future<HTTPResponse> requestaccept(
    int roomId, int createrid, bool accept) async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  var url = Uri.parse('$serverUrl/chat/make_group');

  var body = {
    'room_id': roomId.toString(),
    'creater_id': createrid.toString(),
  };
  var headers = {
    'Authorization': 'Token $token',
  };
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
    return HTTPResponse.networkError();
  } else {
    try {
      var response = accept
          ? await http.post(url, headers: headers, body: body)
          : await http.delete(url, headers: headers, body: body);

      String responsebody = utf8.decode(response.bodyBytes);
      print(accept
          ? '요청 수락 : ${response.statusCode}'
          : '요청 거절 : ${response.statusCode}');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return HTTPResponse.success('success');
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

Future<void> postTime(int groupId, int userId) async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  var url = Uri.parse('$serverUrl/chat/last_view');

  var body = {
    'id': groupId.toString(),
    'last_view': DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
    'user_id': userId.toString()
  };
  var headers = {
    'Authorization': 'Token $token',
  };
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
  } else {
    var response = await http.post(url, headers: headers, body: body);
    String responsebody = utf8.decode(response.bodyBytes);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      print('${response.statusCode}이거야');
    } else {
      print('${response.statusCode}이거야2');
    }
  }
}
