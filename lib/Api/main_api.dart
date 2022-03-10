import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/home_controller.dart';
import 'package:universiting/controllers/map_controller.dart';
import 'package:universiting/models/main_univ_model.dart';
import 'package:universiting/utils/global_variable.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

Future<List<MainUniv>> getMainUniv() async {
  ConnectivityResult result = await checkConnectionStatus();
  final url = Uri.parse('$serverUrl/school_api/main_load');
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
    return [MainUniv(id: 0, schoolname: '', lat: 37.563600, lng: 126.962370, type: false)].obs;
  } else {
    try {
      var response = await http.get(url);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        String responsebody = utf8.decode(response.bodyBytes);
        print(response.statusCode);
        return mainUnivParse(responsebody);

      } else {
        print(response.statusCode);
        return [MainUniv(id: 0, schoolname: '', lat: 37.563600, lng: 126.962370, type: false)].obs;
      }
    } catch (e) {
      print(e);
      return [MainUniv(id: 0, schoolname: '', lat: 37.563600, lng: 126.962370, type: false)].obs;
    }
  }
}
