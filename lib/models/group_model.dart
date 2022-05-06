import 'package:universiting/models/host_model.dart';

class Group {
  int id;
  String title;
  int countMember;
  List<Host> member;
  DateTime date;
  String university;
  int dateCount;
  Group(
      {required this.id,
      required this.title,
      required this.countMember,
      required this.member,
      required this.date,
      required this.university,
      required this.dateCount});

  factory Group.fromJson(Map<String, dynamic> json) => Group(
      id: json['id'],
      title: json['title'],
      countMember: json['count_member'],
      member: List<Map<String, dynamic>>.from(json['member_images'])
          .map((host) => Host.fromJson(host))
          .toList(),
      date: DateTime.parse(json['end_date']),
      university : json['university'],
      dateCount: json['end_date_count']);
}
