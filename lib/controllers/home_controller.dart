import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  RxBool islogin = false.obs;

  @override
  void onClose(){
    islogin(false);
    super.onClose();
  }
}