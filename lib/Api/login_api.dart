import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:universiting/controllers/login_controller.dart';
import 'package:universiting/utils/global_variable.dart';
import 'package:http/http.dart' as http;

import '../constant.dart';

Future<void> login() async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  LoginController loginController = Get.put(LoginController());
  Map<String, dynamic> login_info = {
    'username': loginController.emailController.text,
    'password': loginController.passwordController.text,
    'fcm_token': ' '
  };
  final headers = {'Content-Type': 'application/json'};
  final url = Uri.parse('$serverUrl/user_api/login');

  if (result == ConnectivityResult.none) {
    // showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
  } else {
    try {
      var response =
          await http.post(url, body: jsonEncode(login_info), headers: headers);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        String responsebody = utf8.decode(response.bodyBytes);
        String id = jsonDecode(responsebody)['user_id'];
        String token = jsonDecode(responsebody)['token'];
        await storage.write(key: 'id$id', value: id);
        await storage.write(key: 'token$id', value: token);
        print(response.statusCode);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }
}