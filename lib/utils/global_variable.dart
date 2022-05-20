import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/models/httpresponse_model.dart';

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
  if (DateTime.now().difference(date).inMilliseconds < 1000) {
    return '방금 전';
  } 
  else if (DateTime.now().difference(date).inMinutes < 60) {
    return '${DateTime.now().difference(date).inMinutes}분 전';
  } else if(DateTime.now().difference(date).inHours <= 24){
    return '${DateTime.now().difference(date).inHours}시간 전';
  }
   else if (DateTime.now().difference(date).inDays <= 31) {
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

Future? getbacks(int number) {
  for (int i = 0; i < number; i++) {
    Get.back(closeOverlays: true);
  }
  return null;
}

void errorSituation(HTTPResponse httpresponse) {
  if (httpresponse.errorData!['statusCode'] == 59) {
    showNetworkDisconnectDialog();
  } else if (httpresponse.errorData!['statusCode'] == 404) {
    Get.back();
    showCustomDialog('존재하지 않는 콘텐츠입니다', 1200);
  } else {
    showErrorDialog();
  }
}
