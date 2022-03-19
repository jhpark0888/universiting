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
