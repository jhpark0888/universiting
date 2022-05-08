import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/controllers/profile_controller.dart';
import 'package:universiting/controllers/signup_controller.dart';
import 'package:universiting/models/profile_model.dart';
import 'package:universiting/utils/global_variable.dart';
import 'package:http/http.dart' as http;

Future<void> getMyProfile() async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = const FlutterSecureStorage();
  ProfileController profileController = Get.find();
  var url = Uri.parse('$serverUrl/user_api/profile');
  String? token = await storage.read(key: 'token');
  Map<String, String> headers = {'Authorization': 'Token $token'};
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
  } else {
    try {
      var response = await http.get(url, headers: headers);

      if (response.statusCode <= 200 && response.statusCode < 300) {
        String responsebody = utf8.decode(response.bodyBytes);
        profileController.profile.value =
            Profile.fromJson(jsonDecode(responsebody));
        print(response.statusCode);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
      showCustomDialog('서버 점검중입니다.', 1200);
    }
  }
}

Future<void> updateMyProfile(ProfileType profileType, File? image) async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = const FlutterSecureStorage();
  ProfileController profileController = Get.find();
  var url = Uri.parse('$serverUrl/user_api/profile?type=${profileType.name}');
  String? token = await storage.read(key: 'token');
  Map<String, String> headers = {'Authorization': 'Token $token'};
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
  } else {
    try {
      var request = http.MultipartRequest('PUT', url);
      request.headers.addAll(headers);

      if (profileType != ProfileType.image) {
        // request.fields['nickname'] = profileController.nameController.text;
        request.fields['introduction'] = profileController.introController.text;
        // request.fields['department'] = profileController.departmentController.text;
      }
      if (profileType == ProfileType.image) {
        if (image != null) {
          print('이것도 클릭됨');
          var multipartFile =
              await http.MultipartFile.fromPath('image', image.path);
          request.files.add(multipartFile);
          // profileController.profile.value.profileImage = image.path;
        } else if (image == null) {
          request.fields['image'] = jsonEncode(null);
          // profileController.profile.value.profileImage = '';
        }
      }
      http.StreamedResponse response = await request.send();
      if (response.statusCode <= 200 && response.statusCode < 300) {
        String responsebody = await response.stream.bytesToString();
        // profileController.profile.value.nickname ==
        //     profileController.nameController.text;
        // profileController.profile.value.age ==
        //     int.parse(profileController.ageController.text);
        // profileController.profile.value.introduction ==
        //     profileController.introController.text;
        profileController.profile.value =
            Profile.fromJson(jsonDecode(responsebody));
        print(response.statusCode);
        print(responsebody);
        Get.back();
      }else{
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
      showCustomDialog('서버 점검중입니다.', 1200);
    }
  }
}

Future<Profile> getOtherProfile(String id) async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = const FlutterSecureStorage();

  var url = Uri.parse('$serverUrl/user_api/profile_info?id=$id');
  String? token = await storage.read(key: 'token');
  Map<String, String> headers = {'Authorization': 'Token $token'};
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
    return Profile(
        age: 0,
        gender: '',
        introduction: '',
        nickname: '',
        profileImage: '',
        userId: 0);
  } else {
    try {
      var response = await http.get(url, headers: headers);

      if (response.statusCode <= 200 && response.statusCode < 300) {
        String responsebody = utf8.decode(response.bodyBytes);
        print(responsebody);
        print(response.statusCode);
        return Profile.fromJson(jsonDecode(responsebody));
      } else {
        print(response.statusCode);
        return Profile(
            age: 0,
            gender: '',
            introduction: '',
            nickname: '',
            profileImage: '',
            userId: 0);
      }
    } catch (e) {
      print(e);
      showCustomDialog('서버 점검중입니다.', 1200);
    }
    return Profile(
        age: 0,
        gender: '',
        introduction: '',
        nickname: '',
        profileImage: '',
        userId: 0);
  }
}
