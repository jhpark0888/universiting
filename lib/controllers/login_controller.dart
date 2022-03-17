import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  static LoginController get to => Get.put(LoginController());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool emailValidate = false.obs;
  RxBool passwordValidate = false.obs;

  @override
  void onInit(){
    super.onInit();
    emailController.addListener(() {
      print(emailValidate);
      if(emailController.text.isNotEmpty){
        emailValidate(true);
      }else{
        emailValidate(false);
      }
    });

    passwordController.addListener(() {
      print(passwordValidate);
      if(passwordController.text.isNotEmpty){
        passwordValidate(true);
      }else{
        passwordValidate(false);
      }
    });
  }

  @override
  void onClose(){
    super.onClose();
    emailController.clear;
    passwordController.clear;
    emailValidate(false);
    passwordValidate(false);
  }
}