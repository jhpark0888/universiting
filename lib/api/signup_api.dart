import 'dart:collection';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:universiting/app.dart';
import 'package:universiting/controllers/home_controller.dart';
import 'package:universiting/views/home_view.dart';
import 'package:universiting/views/login_view.dart';
import 'package:universiting/views/signup_age_view.dart';

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
    try {
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
    } catch (e) {
      showCustomDialog('서버 점검중입니다.', 1200);
    }
  }
}

// Future<void> getDepartList(int id) async {
//   ConnectivityResult result = await checkConnectionStatus();
//   SignupController signupController = Get.find();
//   var url = Uri.parse('$serverUrl/school_api/department_list?id=$id');
//   if (result == ConnectivityResult.none) {
//     showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
//   } else {
//     try {
//       var response = await http.get(url);

//       if (response.statusCode <= 200 && response.statusCode < 300) {
//         String responsebody = utf8.decode(response.bodyBytes);
//         signupController.allDepartList.value = departParsed(responsebody);
//         for (Depart i in signupController.allDepartList) {
//           signupController.departList.add(i.depName);
//         }
//         print(responsebody);
//         print(response.statusCode);
//         print(signupController.departList);
//       } else {
//         print(response.statusCode);
//       }
//     } catch (e) {
//       showCustomDialog('서버 점검중입니다.', 1200);
//       print(e);
//     }
//   }
// }

Future<void> checkNickName() async {
  ConnectivityResult result = await checkConnectionStatus();
  SignupController signupController = Get.find();
  var url = Uri.parse(
      '$serverUrl/user_api/nickname?nickname=${signupController.nameController.text}');
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
  } else {
    try {
      var response = await http.get(
        url,
      );
      print(response.statusCode);
      String responsebody = utf8.decode(response.bodyBytes);
      if (response.statusCode <= 200 && response.statusCode < 300) {
        signupController.isname.value = true;
        print(response.statusCode);
        Get.to(() => SignupAgeView());
      } else if (response.statusCode == 406) {
        signupController.isname.value = false;
        showCustomDialog('이미 사용 중인 닉네임이에요', 1200);
      }
    } catch (e) {
      showCustomDialog('서버 점검중입니다.', 1200);
    }
  }
}

Future<void> checkEmail() async {
  ConnectivityResult result = await checkConnectionStatus();
  SignupController signupController = Get.find();
  var url = Uri.parse('$serverUrl/user_api/check_email');
  Map<String, dynamic> signup = {
    'email': signupController.emailController.text +
        '@' +
        signupController.uni.value.email,
    'password': signupController.passwordController.text
  };
  var headers = {'Content-Type': 'multipart/form-data'};
  if (result == ConnectionState.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
  } else {
    try {
      showcustomCustomDialog(1200);
      await Future.delayed(const Duration(milliseconds: 1200));
      signupController.isSendEmail.value = true;
       showEmailCustomDialog(
          '${signupController.emailController.text}@${signupController.uni.value.email}로 인증 메일을 보내드렸어요',
          1200);
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
      showCustomDialog('서버 점검중입니다.', 1200);
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
    'email': signupController.emailController.text +
        '@' +
        signupController.uni.value.email,
    'nickname': signupController.nameController.text,
    'gender': signupController.isgender.value,
    'age': int.parse(signupController.ageController.text),
    // 'department_id': signupController.departId.value,
    'university_id': signupController.schoolId.value
  };
  print(signup);
  var headers = {'Content-Type': 'application/json'};
  if (result == ConnectionState.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
  } else {
    try {
      var response =
          await http.post(url, body: jsonEncode(signup), headers: headers);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        String responsebody = utf8.decode(response.bodyBytes);
        String id = jsonDecode(responsebody)['user_id'];
        String token = jsonDecode(responsebody)['token'];
        await storage.write(key: 'id$id', value: id);
        await storage.write(key: 'token$id', value: token);
        await storage.write(key: signupController.emailController.text +
        '@' +
        signupController.uni.value.email, value: signupController.schoolId.value.toString());
        login();
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      showCustomDialog('서버 점검중입니다.', 1200);
    }
  }
}




Future<void> login() async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  // NotificationController controller = Get.put(NotificationController());
  SignupController signupController = Get.find();
  HomeController homeController = Get.find(tag: '첫 화면');
  var fcm_token = await storage.read(key: 'fcm_token');
  Map<String, dynamic> login_info = {
    'username': signupController.emailController.text + '@' +signupController.uni.value.email,
    'password': signupController.passwordController.text,
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
        Get.offAll( () => App(lat: double.parse(jsonDecode(responsebody)['lat']), lng: double.parse(jsonDecode(responsebody)['lng'])));
      } else{
        print(response.statusCode);
      }
    } catch (e) {
      showCustomDialog('서버 점검중입니다.', 1200);
      print(e);
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

