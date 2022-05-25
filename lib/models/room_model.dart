import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/management_controller.dart';
import 'package:universiting/controllers/profile_controller.dart';
import 'package:universiting/models/host_model.dart';
import 'package:universiting/models/myroom_request_model.dart';

class Room {
  int? id;
  int? createrId;
  int? universityId;
  String? introduction;
  String title;
  String? university;
  double? avgAge;
  List<Host>? hosts;
  List<Host>? inactivehosts;
  int? totalMember;
  String? gender;
  int? isCreater;
  int? isJoin;
  DateTime? date;
  bool? type;
  Rx<StateManagement>? roomstate;
  int? views;
  RxInt? requestcount;
  RxList<MyRoomRequest>? requestlist = <MyRoomRequest>[].obs;
  Room(
      {this.id,
      required this.title,
      this.university,
      this.hosts,
      this.inactivehosts,
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
      this.requestcount,
      this.introduction});

  factory Room.fromJson(Map<String, dynamic> json) => 
     Room(
        id: json['id'],
        university: json['university'],
        title: json['title'],
        avgAge: json['avg_age'],
        hosts: json['member'] != null
            ? List<Map<String, dynamic>>.from(json['member'])
                .map((value) => Host.fromJson(value))
                .toList()
                .where((host) => host.type != 2 && host.type != 3)
                .toList()
            : null,
        inactivehosts: json['member'] != null
            ? List<Map<String, dynamic>>.from(json['member'])
                .map((value) => Host.fromJson(value))
                .toList()
                .where((host) => host.type == 2 || host.type == 3)
                .toList()
            : null,
        totalMember: json['totalmember'],
        gender: json['gender'] == 'M'
            ? '남성'
            : json['gender'] == 'F'
                ? '여성'
                : '혼성',
        type: json['type'] ?? null,
        roomstate: json['state'] == null
            ? null
            : json['state'] == 1
                ? StateManagement.roomActivated.obs
                : json['state'] == 2
                    ? StateManagement.friendReject.obs
                    : json['state'] == 3
                        ? StateManagement.friendLeave.obs
                        : List<Map<String, dynamic>>.from(json['member'])
                                .where((element) =>
                                    element['user_id'].toString() ==
                                    // ProfileController.to.profile.value.userId.toString()
                                    ManagementController.to.id
                                    )
                                .isEmpty
                            ? StateManagement.roomActivated.obs
                            : List<Map<String, dynamic>>.from(json['member'])
                                        .where((element) =>
                                            element['user_id'] ==
                                            ProfileController
                                                .to.profile.value.userId)
                                        .first['host_type'] ==
                                    true
                                ? StateManagement.waitingFriend.obs
                                : StateManagement.sendme.obs,
        createrId: json['creater_id'],
        universityId: json['university_id'],
        introduction: json['introduction'],
        isCreater: json['is_creater'],
        isJoin: json['is_join'],
        views: json['views'],
        requestcount:
            json['request'] != null ? (json['request'] as int).obs : 0.obs,
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
