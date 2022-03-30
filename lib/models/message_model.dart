import 'package:universiting/models/profile_model.dart';

class Message {
  int id;
  String message;
  DateTime date;
  Profile? profile;
  int? groupId;
  int? type;

  Message({required this.id, required this.message, required this.date, this.profile, this.groupId, this.type});

  factory Message.fromJson(Map<String, dynamic> json) => Message(
      id: json['id'],
      message: json['message'],
      date: DateTime.parse(json['date']),
      profile: json['profile'] != null ? Profile.fromJson(json['profile']) : null,
      groupId: json['group_id'],
      type: json['type']);
}
