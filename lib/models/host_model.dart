import 'package:flutter/material.dart';

class Host {
  int userId;
  String? nickname;
  String profileImage;
  String? gender;
  int? age;
  String? introduction;
  bool? hostType;
  bool? joinType;
  int? hostId;

  Host(
      {required this.userId,
      required this.profileImage,
      required this.gender,
      this.nickname,
      this.age,
      this.introduction,
      this.hostType,
      this.hostId,
      this.joinType});

  factory Host.fromJson(Map<String, dynamic> json) => Host(
        userId: json['user_id'],
        nickname: json['nickname'],
        profileImage: json['profile_image'] ?? '',
        gender: json['gender'] ?? '',
        age: json['age'],
        introduction: json['introduction'] ?? '',
        hostType: json['host_type'],
        hostId: json['user_id'],
        joinType: json['join_type'],
      );
}
