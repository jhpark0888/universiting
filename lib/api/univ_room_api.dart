import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/map_controller.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/controllers/univ_room_controller.dart';
import 'package:universiting/models/httpresponse_model.dart';
import 'package:universiting/models/room_model.dart';
import 'package:universiting/utils/global_variable.dart';
import 'package:http/http.dart' as http;
import 'package:universiting/models/environment_model.dart';

Future<HTTPResponse> getUnivRoom() async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  MapController mapController = Get.find();
  UnivRoomController univRoomController = Get.find();
  print(mapController.clickedId);
  var url = Uri.parse(
      '${Environment.apiUrl}/room_api/room?type=university&university_id=${mapController.clickedId}&last=0');
  String? token = await storage.read(key: 'token');
  Map<String, String> headers = {'Authorization': 'Token $token'};
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400);
    return HTTPResponse.networkError();
  } else {
    try {
      var response = await http.get(url, headers: headers);
      print('대학교 방 로드 : ${response.statusCode}');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        String responsebody = utf8.decode(response.bodyBytes);
        print(jsonDecode(responsebody).runtimeType);
        // print(univRoomController.univRoom);
        return HTTPResponse.success(
            List<Map<String, dynamic>>.from(jsonDecode(responsebody))
                .map((value) => Room.fromJson(value))
                .toList());
      } else {
        return HTTPResponse.apiError('', response.statusCode);
      }
    } on SocketException {
      return HTTPResponse.serverError();
    } catch (e) {
      return HTTPResponse.unexpectedError(e);
    }
  }
}
