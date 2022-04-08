import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:universiting/models/host_model.dart';
import 'package:universiting/models/profile_model.dart';
import 'package:universiting/models/room_model.dart';

class AlarmReceive {
  int id;
  int userId;
  int type;
  int targetId;
  Room? content;
  Profile profile;
  DateTime date;
  bool isRead;
  String roomInformation;
  AlarmReceive(
      {required this.id,
      required this.userId,
      required this.type,
      required this.targetId,
      this.content,
      required this.profile,
      required this.date,
      required this.isRead,
      required this.roomInformation});

  factory AlarmReceive.fromJson(Map<String, dynamic> json) => AlarmReceive(
      id: json['id'],
      userId: json['user_id'],
      type: json['type'],
      targetId: json['target_id'],
      content: json['content'] != null ? Room.fromJson(json['content']) : Room(title: ''),
      profile: Profile.fromJson(json['profile']),
      date: DateTime.parse(json['date']),
      isRead: json['is_read'],
      roomInformation: json['room_information']);
}

List<AlarmReceive> alarmReceiveParsed(String responsebody) {
  List parse = jsonDecode(responsebody);
  return parse.map<AlarmReceive>((e) => AlarmReceive.fromJson(e)).toList();
}

class AlarmSend {
  int id;
  Room room;
  List<Host> joinmember;

  AlarmSend({required this.id, required this.room, required this.joinmember});

  factory AlarmSend.fromJson(Map<String, dynamic> json) => AlarmSend(
      id: json['id'],
      room: Room.fromJson(json['room']),
      joinmember: List<Map<String, dynamic>>.from(json['joinmember'])
          .map((host) => Host.fromJson(host))
          .toList());
}

List<AlarmSend> alarmSendParsed(String responsebody){
  List parse = jsonDecode(responsebody);
  return parse.map((alarmsend) => AlarmSend.fromJson(alarmsend)).toList();
}
