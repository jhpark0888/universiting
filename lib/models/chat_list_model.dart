import 'dart:convert';

import 'package:universiting/models/group_model.dart';
import 'package:universiting/models/message_model.dart';

class ChatRoom {
  Group group;
  Message message;
  int newMsg;
  ChatRoom({required this.group, required this.message, required this.newMsg});

  factory ChatRoom.fromJson(Map<String, dynamic> json) => ChatRoom(
      group: Group.fromJson(json['group']),
      message: Message.fromJson(json['message']),
      newMsg: json['new_msg']);
}

List<ChatRoom> chatListParsed(String responsebody){
  List<dynamic> parsed = jsonDecode(responsebody);
  return parsed.map((chatList) => ChatRoom.fromJson(chatList)).toList(); 
}