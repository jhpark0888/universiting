import 'dart:convert';

import 'package:flutter/material.dart';

class MainUniv {
  int id;
  String schoolname;
  double lat;
  double lng;
  bool type;

  MainUniv(
      {required this.id,
      required this.schoolname,
      required this.lat,
      required this.lng,
      required this.type});

  factory MainUniv.fromJson(Map<String, dynamic> json) => MainUniv(
      id: json['id'],
      schoolname: json['schoolname'],
      lat: json['lat'] != '' ? double.parse(json['lat']) : 0.0,
      lng: json['lng'] != '' ? double.parse(json['lng']) : 0.0,
      type: json['type']);
}

List<MainUniv> mainUnivParse(String responsebody) {
  List parse = jsonDecode(responsebody);
  return parse.map<MainUniv>((e) => MainUniv.fromJson(e)).toList();
}
