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
  int? isModify;
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
      this.isModify,
      this.introduction});

  factory Room.fromJson(Map<String, dynamic> json) => Room(
      id: json['id'],

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
      isModify: json['is_modify']);
      
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
