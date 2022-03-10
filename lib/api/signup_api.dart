import 'dart:collection';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:universiting/views/home_view.dart';
import 'package:universiting/views/login_view.dart';

import '../constant.dart';
import '../controllers/signup_controller.dart';
import '../models/signup_model.dart';
import '../utils/global_variable.dart';

Future<void> getUniversityList() async {
  ConnectivityResult result = await checkConnectionStatus();
  SignupController signupController = Get.find();
  var url = Uri.parse('$serverUrl/school_api/university_list');
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
  } else {
    var response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode <= 200 && response.statusCode < 300) {
      String responsebody = utf8.decode(response.bodyBytes);

      signupController.allUnivList.value = univParsed(responsebody);
      for (Univ i in signupController.allUnivList) {
        signupController.univList.add(i.schoolname);
      }

      signupController.univList =
          signupController.univList.toList().toSet().toList().obs;
    } else {
      print(response.statusCode);
    }
  }
}

Future<void> getDepartList(int id) async {
  ConnectivityResult result = await checkConnectionStatus();
  SignupController signupController = Get.find();
  var url = Uri.parse('$serverUrl/school_api/department_list?id=$id');
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
            signupController.departList.toSet().toList();
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
  var url = Uri.parse('$serverUrl/user_api/check_email');
  Map<String, dynamic> signup = {
    'email':
        signupController.emailController.text + '@' +signupController.uni.value.email,
    'password': signupController.passwordController.text
  };
  var headers = {'Content-Type': 'multipart/form-data'};
  if (result == ConnectionState.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
  } else {
    try {
      signupController.isSendEmail.value = true;
      showEmailCustomDialog('${signupController.emailController.text}@${signupController.uni.value.email}로 인증 메일을 보내드렸어요', 1200);
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
  var url = Uri.parse('$serverUrl/user_api/signup');
  Map<String, dynamic> signup = {
    'type': 12,
    'email':
        signupController.emailController.text + '@' +signupController.uni.value.email,
    'nickname': signupController.nameController.text,
    'gender': signupController.isgender.value,
    'age': int.parse(signupController.ageController.text),
    'department_id': signupController.departId.value,
    'university_id': signupController.schoolId.value
  };
  var headers = {'Content-Type': 'application/json'};
  if (result == ConnectionState.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
  } else {
      var response = await http.post(url, body: jsonEncode(signup), headers: headers);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        String responsebody = utf8.decode(response.bodyBytes);
        String id = jsonDecode(responsebody)['user_id'];
        String token = jsonDecode(responsebody)['token'];
        await storage.write(key: 'id$id', value: id);
        await storage.write(key: 'token$id', value: token);
        print(id);
        print(token);
        print(response.statusCode);
        
      } else {
        print(response.statusCode);
      }
    
  }
}
void showEmailCustomDialog(String title, int duration) {
  Get.dialog(
    AlertDialog(
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      contentPadding: EdgeInsets.fromLTRB(
        Get.width / 15,
        Get.width / 30,
        Get.width / 15,
        Get.width / 30,
      ),
      backgroundColor: Colors.white,
      content: Text(
        title,
        style: kActiveButtonStyle,
        textAlign: TextAlign.center,
      ),
    ),
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.3),
    // transitionCurve: kAnimationCurve,
    // transitionDuration: kAnimationDuration,
  );
  Future.delayed(Duration(milliseconds: duration), () {
    Get.back();
  });
}