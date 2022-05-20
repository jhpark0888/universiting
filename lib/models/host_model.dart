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
  int? type;
  Host(
      {required this.userId,
      required this.profileImage,
      required this.gender,
      this.nickname,
      this.age,
      this.introduction,
      this.hostType,
      this.hostId,
      this.joinType,
      this.type});

  factory Host.fromJson(Map<String, dynamic> json) => Host(
      userId: json['user_id'] ?? json['profile']['user_id'],
      nickname: json['nickname'] ?? json['profile']['nickname'],
      profileImage: json['profile_image'] != null
          ? json['profile_image']
          : json['profile'] == null
              ? ''
              : json['profile']['profile_image'] ?? '',
      gender: json['gender'] != null
          ? json['gender'] == 'M'
              ? '남성'
              : json['gender'] == 'F'
                  ? '여성'
                  : '혼성'
          : '',
      age: json['age'],
      introduction: json['introduction'] ?? '',
      hostType: json['host_type'],
      hostId: json['user_id'],
      joinType: json['join_type'],
      type: json['type'] ?? json['state']);
}
