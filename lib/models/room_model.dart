import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:universiting/constant.dart';
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
  StateManagement? roomstate;
  int? views;
  Room(
      {this.id,
      required this.title,
      this.university,
      this.hosts,
      this.totalMember,
      this.type,
      this.roomstate,
      this.gender,
      this.avgAge,
      this.createrId,
      this.universityId,
      this.isCreater,
      this.isJoin,
      this.date,
      this.views,
      this.introduction});

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        id: json['id'],
        university: json['university'],
        title: json['title'],
        avgAge: json['avg_age'],
        hosts: json['hosts'] != null
            ? List<Map<String, dynamic>>.from(json['hosts'])
                .map((value) => Host.fromJson(value))
                .toList()
            : null,
        totalMember: json['totalmember'],
        gender: json['gender'] == 'M'
            ? '남성'
            : json['gender'] == 'F'
                ? '여성'
                : '혼성',
        type: json['type'] ?? null,
        roomstate: json['type'] == null
            ? null
            : json['type'] == true && json['state'] == 0
                ? StateManagement.roomActivated
                : json['type'] == false && json['state'] == 0
                    ? StateManagement.waitingFriend
                    : StateManagement.friendReject,
        createrId: json['creater_id'],
        universityId: json['university_id'],
        introduction: json['introduction'],
        isCreater: json['is_creater'],
        isJoin: json['is_join'],
        views: json['views'],
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
