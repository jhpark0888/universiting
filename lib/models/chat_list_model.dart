import 'dart:convert';

import 'package:universiting/models/group_model.dart';
import 'package:universiting/models/message_model.dart';

class ChatRoom {
  Group group;
  Message message;

  ChatRoom({required this.group, required this.message});

  factory ChatRoom.fromJson(Map<String, dynamic> json) => ChatRoom(
      group: Group.fromJson(json['group']),
      message: Message.fromJson(json['message']));
}

List<ChatRoom> chatListParsed(String responsebody){
  List<dynamic> parsed = jsonDecode(responsebody);
  return parsed.map((chatList) => ChatRoom.fromJson(chatList)).toList(); 
}