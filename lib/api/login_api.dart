import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:universiting/app.dart';
import 'package:universiting/controllers/app_controller.dart';
import 'package:universiting/controllers/chat_list_controller.dart';
import 'package:universiting/controllers/home_controller.dart';
import 'package:universiting/controllers/login_controller.dart';
import 'package:universiting/controllers/map_controller.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/controllers/management_controller.dart';
import 'package:universiting/controllers/notifications_controller.dart';
import 'package:universiting/controllers/profile_controller.dart';
import 'package:universiting/controllers/status_controller.dart';
import 'package:universiting/models/httpresponse_model.dart';
import 'package:universiting/utils/global_variable.dart';
import 'package:http/http.dart' as http;
import 'package:universiting/views/home_view.dart';
import 'package:universiting/models/environment_model.dart';
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
  final url = Uri.parse('${Environment.apiUrl}/user_api/login');

  if (result == ConnectivityResult.none) {
    // showCustomDialog('네트워크를 확인해주세요', 1400);
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
        await storage.write(
            key: 'lat',
            value: double.parse(jsonDecode(responsebody)['lat']).toString());
        await storage.write(
            key: 'lng',
            value: double.parse(jsonDecode(responsebody)['lng']).toString());

        String? univId =
            await storage.read(key: loginController.emailController.text);
        print(response.statusCode);
        print(responsebody);
        homeController.isGuest(false);
        print(univId);
        Get.offAll(() => App(
            lat: double.parse(jsonDecode(responsebody)['lat']),
            lng: double.parse(jsonDecode(responsebody)['lng'])));
      } else if (response.statusCode == 401) {
        showCustomDialog('이메일 주소 또는 비밀번호를 다시 확인해주세요', 1400);
        print(response.statusCode);
      }
    } catch (e) {
      showCustomDialog('서버 점검중입니다.', 1200);
      print(e);
    }
  }
}

Future<HTTPResponse> logout() async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = const FlutterSecureStorage();
  var url = Uri.parse('${Environment.apiUrl}/user_api/logout');
  String? token = await storage.read(key: 'token');
  Map<String, String> headers = {'Authorization': 'Token $token'};
  if (result == ConnectivityResult.none) {
    return HTTPResponse.networkError();
  } else {
    try {
      var response = await http.post(url, headers: headers);
      print('로그아웃 : ${response.statusCode}');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return HTTPResponse.success('success');
      } else {
        print(response.statusCode);
        return HTTPResponse.apiError('', response.statusCode);
      }
    } on SocketException {
      return HTTPResponse.serverError();
    } catch (e) {
      print(e);
      return HTTPResponse.unexpectedError(e);
    }
  }
}

Future<HTTPResponse> imageCheck() async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  var url = Uri.parse('${Environment.apiUrl}/school_api/check_profile');
  var headers = {'Authorization': 'Token $token'};
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400);
    return HTTPResponse.networkError();
  } else {
    try {
      var response = await http.get(url, headers: headers);
      print('이미지 체크 : ${response.statusCode}');
      String responsebody = utf8.decode(response.bodyBytes);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (jsonDecode(responsebody) == '프로필 이미지를 만들어주세요') {
          return HTTPResponse.success(false);
        } else {
          return HTTPResponse.success(true);
        }
      } else {
        return HTTPResponse.apiError('', response.statusCode);
      }
    } on SocketException {
      return HTTPResponse.serverError();
    } catch (e) {
      print(e);
      return HTTPResponse.unexpectedError(e);
    }
  }
}
