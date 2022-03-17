import 'package:flutter/material.dart';

class SelectMember {
  int userId;
  String nickname;
  int age;
  String gender;
  SelectMember(
      {required this.userId,
      required this.nickname,
      required this.age,
      required this.gender});

  factory SelectMember.fromJson(Map<String, dynamic> json) => SelectMember(
      userId: json['user_id'],
      nickname: json['nickname'],
      age: json['age'],
      gender: json['gender']);
}
