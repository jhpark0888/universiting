import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/models/chat_list_model.dart';
import 'package:universiting/models/group_model.dart';
import 'package:universiting/models/host_model.dart';
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
              university:'',
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
    if (response.statusCode <= 200 && response.statusCode < 300) {
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


Future<void> postTime(int groupId, int userId) async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  var url = Uri.parse('$serverUrl/chat/last_view');

  var body = {
    'id': groupId.toString(),
    'last_view': DateFormat('yyyy-MM-dd HH:mm:ss').format(
          DateTime.now()),
    'user_id' : userId.toString()
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
      print('${response.statusCode}이거야');

    } else {
      print('${response.statusCode}이거야2');
    }
  }
}