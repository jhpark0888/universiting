import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/map_controller.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/controllers/univ_room_controller.dart';
import 'package:universiting/models/room_model.dart';
import 'package:universiting/utils/global_variable.dart';
import 'package:http/http.dart' as http;

Future<void> getUnivRoom() async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  MapController mapController = Get.find();
  UnivRoomController univRoomController = Get.find();
  var url = Uri.parse(
      '$serverUrl/room_api/room?type=university&university_id=${mapController.clickedId}&last=0');
  String? token = await storage.read(key: 'token');
  Map<String, String> headers = {'Authorization': 'Token $token'};
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
  } else {
    var response = await http.get(url, headers: headers);

    if (response.statusCode <= 200 && response.statusCode < 300) {
      String responsebody = utf8.decode(response.bodyBytes);
      print(jsonDecode(responsebody).runtimeType);

      univRoomController.univRoom.value =
          List<Map<String, dynamic>>.from(jsonDecode(responsebody))
              .map((value) => Room.fromJson(value))
              .toList();
      print(response.statusCode);
      print(univRoomController.univRoom);
    } else {
      print(response.statusCode);
    }
  }
}
