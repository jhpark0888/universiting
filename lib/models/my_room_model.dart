import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:universiting/models/room_model.dart';

class MyRoom {
  List<Room> chiefList;
  List<Room> memberList;
  MyRoom({required this.chiefList, required this.memberList});

  factory MyRoom.fromJson(Map<String, dynamic> json) => MyRoom(
      chiefList: List<Map<String, dynamic>>.from(json['chief_list'])
          .map((e) => Room.fromJson(e))
          .toList(),
      memberList: List<Map<String, dynamic>>.from(json['member_list']).map((e) => Room.fromJson(e)).toList());
}
