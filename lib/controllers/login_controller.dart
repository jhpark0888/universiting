import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  static LoginController get to => Get.put(LoginController());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
}