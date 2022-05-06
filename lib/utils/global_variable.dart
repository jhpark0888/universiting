import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:universiting/constant.dart';



Future<ConnectivityResult> checkConnectionStatus() async {
  late ConnectivityResult result = ConnectivityResult.none;
  final connectivity = Connectivity();
  try {
    result = await connectivity.checkConnectivity();
    print(result);
    return result;
  } catch (e) {
    print(e);
    return result;
  }
  // if(result == ConnectivityResult.none){
  //   throw SocketException('연결상태를 확인해 주세요');
  // }else{
  //   return result;
  // }
}

Future<bool> resultOfConnection() async {
  ConnectivityResult result = await checkConnectionStatus();
  if (result == ConnectivityResult.none) {
    return false;
  } else {
    return true;
  }
}


String calculateDate(DateTime date) {
    if (DateTime.now().difference(date).inHours <= 24) {
      return '${DateTime.now().difference(date).inHours}시간 전';
    } else if (DateTime.now().difference(date).inDays <= 31) {
      return '${DateTime.now().difference(date).inDays}일 전';
    } else if (DateTime.now().difference(date).inDays <= 365) {
      return '일 년 이내 만들어진 방';
    }
    return '일 년 이전 만들어진 방';
  }

  Widget getBoxColor(DateTime date) {
    if (DateTime.now().difference(date).inHours <= 24) {
      return Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color(0xFF00B933)));
    } else if (DateTime.now().difference(date).inDays <= 31) {
      return Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color(0xFFEAEF00)));
    } else if (DateTime.now().difference(date).inDays <= 365) {
      return Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color(0xFFFF6565)));
    }
    return Container();
  }

  void getbacks(int number){
    for(int i = 0 ; i < number; i ++){
      Get.back();
    }
  }