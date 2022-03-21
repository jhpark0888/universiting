import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:universiting/models/host_model.dart';

class Room {
  int id;
  int? createrId;
  int? universityId;
  String? introduction;
  String title;
  double? avgAge;
  List<Host> hosts;
  int totalMember;
  String? gender;
  bool type;

  Room(
      {required this.id,
      required this.title,
      required this.hosts,
      required this.totalMember,
      required this.type,
      this.gender,
      this.avgAge,
      this.createrId,
      this.universityId,
      this.introduction});

  factory Room.fromJson(Map<String, dynamic> json) => Room(
      id: json['id'],
      title: json['title'],
      avgAge: json['avg_age'],
      hosts: List<Map<String, dynamic>>.from(json['hosts'])
          .map((value) => Host.fromJson(value))
          .toList(),
      totalMember: json['totalmember'],
      gender: json['gender'],
      type: json['type'],
      createrId: json['creater_id'],
      universityId: json['university_id'],
      introduction: json['introduction']);
}
