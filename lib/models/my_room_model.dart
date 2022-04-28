import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:universiting/models/room_model.dart';

class MyRoom {
  List<Room> chiefList;
  // List<Room> memberList;
  MyRoom({required this.chiefList});

  factory MyRoom.fromJson(List<dynamic> chiefList){
    List<Room> items = <Room>[];
    items = chiefList.map((e) => Room.fromJson(e)).toList();
    return MyRoom(chiefList: items);
  }    
}
