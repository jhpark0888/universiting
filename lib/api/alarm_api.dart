import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/models/alarm_model.dart';
import 'package:universiting/models/profile_model.dart';
import 'package:universiting/utils/global_variable.dart';
import 'package:http/http.dart' as http;

Future<List<AlarmReceive>> getAlarmList(index) async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  // var url = Uri.parse('$serverUrl/room_api/alarm?last=$index');
  var url = Uri.parse('$serverUrl/room_api/alarm?last=$index');
  var headers = {'Authorization': 'Token $token'};
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400);
    return [
      AlarmReceive(
          id: 0,
          userId: 0,
          type: 0,
          targetId: 0,
          content: null,
          profile: Profile(
              age: 0,
              gender: '',
              introduction: '',
              nickname: '',
              profileImage: '',
              userId: 0),
          date: DateTime(2020),
          isRead: false,
          roomInformation: '')
    ];
  } else {
    var response = await http.get(url, headers: headers);

    String responsebody = utf8.decode(response.bodyBytes);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      print(response.statusCode);
      print(responsebody);
      if (jsonDecode(responsebody).isNotEmpty) {
        return alarmReceiveParsed(responsebody);
      } else {
        return [];
      }
    } else if (response.statusCode == 500) {
      print(response.statusCode);
      return [];
    } else {
      print(response.statusCode);
      return [
        AlarmReceive(
            id: 0,
            userId: 0,
            type: 0,
            targetId: 0,
            content: null,
            profile: Profile(
                age: 0,
                gender: '',
                introduction: '',
                nickname: '',
                profileImage: '',
                userId: 0),
            date: DateTime(2020),
            isRead: false,
            roomInformation: '')
      ];
    }
  }
}
