import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:universiting/models/host_model.dart';

class Room {
  int? id;
  int? createrId;
  int? universityId;
  String? introduction;
  String title;
  String? university;
  double? avgAge;
  List<Host>? hosts;
  int? totalMember;
  String? gender;
  int? isCreater;
  int? isJoin;
  DateTime? date;
  bool? type;
  Room(
      {this.id,
      required this.title,
      this.university,
      this.hosts,
      this.totalMember,
      this.type,
      this.gender,
      this.avgAge,
      this.createrId,
      this.universityId,
      this.isCreater,
      this.isJoin,
      this.date,
      this.introduction});

  factory Room.fromJson(Map<String, dynamic> json) => Room(
      id: json['id'],
      university: json['university'],
      title: json['title'],
      avgAge: json['avg_age'],
      hosts:json['hosts'] != null ? List<Map<String, dynamic>>.from(json['hosts'])
          .map((value) => Host.fromJson(value))
          .toList() : null,
      totalMember: json['totalmember'],
      gender: json['gender'],
      type: json['type'] ?? null,
      createrId: json['creater_id'],
      universityId: json['university_id'],
      introduction: json['introduction'],
      isCreater: json['is_creater'],
      isJoin : json['is_join'],
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      );
      
}

// class AlarmRoom {
//   String title;
//   List<Host>? hosts;
//   String? gender;
//   double? avgAge;

//   AlarmRoom({required this.title, this.hosts, this.gender, this.avgAge});

//   factory AlarmRoom.fromJson(Map<String, dynamic> json) => AlarmRoom(
//       title: json['title'],
//       hosts: json['hosts'] != null ? List<Map<String, dynamic>>.from(json['hosts'])
//           .map((value) => Host.fromJson(value))
//           .toList() :null,
//       gender: json['gender'],
//       avgAge: json['avg_age']);
// }
