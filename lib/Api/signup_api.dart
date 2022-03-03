import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:universiting/Screen/login_screen.dart';
import 'package:universiting/controller/signup_controller.dart';
import 'package:universiting/function/global_variable.dart';
import 'package:universiting/model/signup_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> getUniversityList() async {
  ConnectivityResult result = await checkConnectionStatus();
  SignupController signupController = Get.find();
  var url = Uri.parse('$uri/user_api/university_list');
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
  } else {
    var response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode <= 200 && response.statusCode < 300) {
      String responsebody = utf8.decode(response.bodyBytes);

      signupController.allUnivList.value = univParsed(responsebody);
      for (Univ i in signupController.allUnivList) {
        signupController.univList.add(i.school);
      }

      signupController.univList =
          signupController.univList.toList().toSet().toList().obs;
    } else {
      print(response.statusCode);
    }
  }
}

Future<void> getDepartList(String univ) async {
  ConnectivityResult result = await checkConnectionStatus();
  SignupController signupController = Get.find();
  var url = Uri.parse('$uri/user_api/department_list?query=$univ');
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
  } else {
    try {
      var response = await http.get(url);

      if (response.statusCode <= 200 && response.statusCode < 300) {
        String responsebody = utf8.decode(response.bodyBytes);
        signupController.allDepartList.value = departParsed(responsebody);
        for (Depart i in signupController.allDepartList) {
          signupController.departList.add(i.depName);
        }
        signupController.departList.value =
            signupController.departList.value.toSet().toList();
        print(response.statusCode);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }
}

Future<void> checkEmail() async {
  ConnectivityResult result = await checkConnectionStatus();
  SignupController signupController = Get.find();
  var url = Uri.parse('$uri/user_api/check_email');
  Map<String, dynamic> signup = {
    'email':
        signupController.emailController.text + signupController.univLink.value,
    'password': signupController.passwordController.text
  };
  var headers = {'Content-Type': 'multipart/form-data'};
  if (result == ConnectionState.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
  } else {
    try {
      var response = await http.post(url, body: signup);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print(response.statusCode);
        signupController.isEmailCheck.value = true;
      } else if (response.statusCode == 400) {
        showCustomDialog('이미 가입된 회원입니다.', 1400);
      }
      {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }
}

Future<void> postProfile() async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = const FlutterSecureStorage();
  SignupController signupController = Get.find();
  var url = Uri.parse('$uri/user_api/signup');
  Map<String, dynamic> signup = {
    'type': '12',
    'email':
        signupController.emailController.text + signupController.univLink.value,
    'nickname': signupController.nameController.text,
    'gender': signupController.gender.value,
    'birth': DateFormat('yyyy-MM-dd')
        .format(DateTime.parse(signupController.datetime[0].toString())),
    'department_id': signupController.departId.toString(),
    'university_id': signupController.schoolId.toString()
  };
  var headers = {'Content-Type': 'multipart/form-data'};
  if (result == ConnectionState.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
  } else {
    try {
      var response = await http.post(url, body: signup);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        String responsebody = utf8.decode(response.bodyBytes);
        String id = jsonDecode(responsebody)['user_id'];
        String token = jsonDecode(responsebody)['token'];
        await storage.write(key: 'id$id', value: id);
        await storage.write(key: 'token$id', value: token);
        print(id);
        print(token);
        print(response.statusCode);
        Get.offAll(() =>LoginScreen(isSignup: true,));
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }
}
