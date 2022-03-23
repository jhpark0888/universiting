import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:universiting/models/profile_model.dart';

class Alarm {
  int id;
  int userId;
  int type;
  int targetId;
  String content;
  Profile profile;
  DateTime date;
  bool isRead;

  Alarm(
      {required this.id,
      required this.userId,
      required this.type,
      required this.targetId,
      required this.content,
      required this.profile,
      required this.date,
      required this.isRead});

  factory Alarm.fromJson(Map<String, dynamic> json) => Alarm(
      id: json['id'],
      userId: json['user_id'],
      type: json['type'],
      targetId: json['target_id'],
      content: json['content'].runtimeType == String ?  json['content'] :  '',
      profile: Profile.fromJson(json['profile']),
      date: DateTime.parse(json['date']),
      isRead: json['is_read']);
}

List<Alarm> alarmParsed(String responsebody){
  List parse = jsonDecode(responsebody);
  return parse.map<Alarm>((e) => Alarm.fromJson(e)).toList();
}
