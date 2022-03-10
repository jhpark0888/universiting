import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:universiting/constant.dart';

void showCustomDialog(String title, int duration) {
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
