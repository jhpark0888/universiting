import 'package:universiting/models/host_model.dart';

class Group {
  int id;
  String title;
  int countMember;
  List<Host> memberImages;

  Group(
      {required this.id,
      required this.title,
      required this.countMember,
      required this.memberImages});

  factory Group.fromJson(Map<String, dynamic> json) => Group(
      id: json['id'],
      title: json['title'],
      countMember: json['count_member'],
      memberImages: List<Map<String, dynamic>>.from(json['member_images'])
          .map((host) => Host.fromJson(host))
          .toList());
}
