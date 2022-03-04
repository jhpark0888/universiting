import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';






double height(context) {
  return MediaQuery.of(context).size.height;
}

double width(context) {
  return MediaQuery.of(context).size.width;
}

void showCustomDialog(String title, int duration) {
  Get.dialog(
    AlertDialog(
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      contentPadding: const EdgeInsets.fromLTRB(
        24,
        12,
        24,
        14,
      ),
      backgroundColor: Colors.white,
      content: Text(
        title,
        // style: kSubTitle4Style,
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

