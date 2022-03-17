import 'package:flutter/material.dart';

class Host {
  int userId;
  String profileImage;
  String gender;

  Host(
      {required this.userId, required this.profileImage, required this.gender});

  factory Host.fromJson(Map<String, dynamic> json) => Host(
      userId: json['user_id'],
      profileImage: json['profile_image'] != null ? json['profile_image'] : '',
      gender: json['gender']);
}
