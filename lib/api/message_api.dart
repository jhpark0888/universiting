import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/message_detail_controller.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/models/message_detail_model.dart';
import 'package:universiting/models/message_model.dart';
import 'package:universiting/utils/global_variable.dart';
import 'package:http/http.dart' as http;

Future<MessageDetail> getMessageDetail(String groupId, String last) async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = const FlutterSecureStorage();
  var url = Uri.parse('$serverUrl/chat/chatting?group_id=$groupId&last=$last');
  String? token = await storage.read(key: 'token');
  Map<String, String> headers = {'Authorization': 'Token $token'};
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
    return MessageDetail(userType: '0', message: [Message(id: 0, message: '', date: DateTime.now()),], groupTitle: '', memberProfile: []);
  } else {
    try {
      var response = await http.get(url, headers: headers);

      if (response.statusCode <= 200 && response.statusCode < 300) {
        String responsebody = utf8.decode(response.bodyBytes);
        print(response.statusCode);
        print(responsebody);
        return MessageDetail.fromJson(jsonDecode(responsebody));
      } else {
        print(response.statusCode);
        return MessageDetail(userType: '0', message: [Message(id: 0, message: '', date: DateTime.now()),], groupTitle: '', memberProfile: []);
      }
    } catch (e) {
      print(e);
      showCustomDialog('서버 점검중입니다.', 1200);
      return MessageDetail(userType: '0', message: [Message(id: 0, message: '', date: DateTime.now()),], groupTitle: '', memberProfile: []);
    }
  }
}


Future<void> sendMessage(String groupId) async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  var url = Uri.parse('$serverUrl/chat/chatting');

  var body = {
    'group_id': groupId,
    'message': MessageDetailController.to.chatController.text,
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
      print(response.statusCode);

    } else {
      print(response.statusCode);
    }
  }
}