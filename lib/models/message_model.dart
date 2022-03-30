import 'package:universiting/models/profile_model.dart';

class Message {
  int id;
  String message;
  DateTime date;
  int? sender;
  int? groupId;
  int? type;

  Message({required this.id, required this.message, required this.date, this.groupId, this.type, this.sender});

  factory Message.fromJson(Map<String, dynamic> json) => Message(
      id: json['id'],
      message: json['message'],
      date: DateTime.parse(json['date']),
      sender: json['sender'],
      // profile: json['profile'] != null ? Profile.fromJson(json['profile']) : null,
      groupId: json['group_id'],
      type: json['type']);
}
