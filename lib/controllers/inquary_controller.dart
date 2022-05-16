import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/utils/user_device_info.dart';

class InquaryController extends GetxController{
  UserDeviceInfo userDeviceInfo = Get.put(UserDeviceInfo());
  TextEditingController emailController = TextEditingController();
  TextEditingController contentcontroller = TextEditingController();
}