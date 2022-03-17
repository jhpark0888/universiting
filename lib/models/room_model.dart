import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:universiting/models/host_model.dart';

class Room {
  int id;
  String title;
  double avgAge;
  List<Host> hosts;
  int totalMember;
  String gender;
  bool type;

  Room(
      {required this.id,
      required this.title,
      required this.avgAge,
      required this.hosts,
      required this.totalMember,
      required this.gender,
      required this.type});

  factory Room.fromJson(Map<String, dynamic> json) => Room(
      id: json['id'],
      title: json['title'],
      avgAge: json['avg_age'],
      hosts: List<Map<String,dynamic>>.from(json['hosts']).map((value)=> Host.fromJson(value)).toList(),
      totalMember: json['totalmember'],
      gender: json['gender'],
      type: json['type']);
}
