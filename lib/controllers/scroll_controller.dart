import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomScrollController extends GetxController{
  static CustomScrollController get to => Get.put(CustomScrollController());
  final Rx<ScrollController> customScrollController = ScrollController().obs;

  
  void scrollToBottom() {
    print(customScrollController.value.offset);
    customScrollController.value.animateTo(
      customScrollController.value.position.maxScrollExtent,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}