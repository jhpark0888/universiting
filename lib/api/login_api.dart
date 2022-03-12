import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:universiting/app.dart';
import 'package:universiting/controllers/home_controller.dart';
import 'package:universiting/controllers/login_controller.dart';
import 'package:universiting/controllers/notifications_controller.dart';
import 'package:universiting/utils/global_variable.dart';
import 'package:http/http.dart' as http;

import '../constant.dart';

Future<void> login() async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  // NotificationController controller = Get.put(NotificationController());
  LoginController loginController = Get.put(LoginController());
  HomeController homeController = Get.find(tag: '첫 화면');
  var fcm_token = await storage.read(key: 'fcm_token');
  Map<String, dynamic> login_info = {
    'username': loginController.emailController.text,
    'password': loginController.passwordController.text,
    'fcm_token': fcm_token
  };
  print(login_info);
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
        await storage.write(key: 'id', value: id);
        await storage.write(key: 'token', value: token);
        print(response.statusCode);
        print(responsebody);
        homeController.isGuest(false);
        Get.offAll( () => App());
      } else if(response.statusCode == 401) {
        showCustomDialog('이메일 주소 또는 비밀번호를 다시 확인해주세요', 1400);
        print(response.statusCode);
      }
    } catch (e) {
      showCustomDialog('서버 점검중입니다.', 1200);
      print(e);
    }
  }
}
