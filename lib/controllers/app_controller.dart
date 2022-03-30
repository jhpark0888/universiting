import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  static AppController get to => Get.find();
  RxInt currentIndex = 0.obs;
  RxInt stackPage = 0.obs;
  void changePageIndex(int index) {
    if (index == 0) {
      currentIndex.value = index;
    } else if (index == 1) {
      currentIndex.value = index;
    } else if (index == 2) {
      currentIndex.value = index;
    } else if (index == 3) {
      currentIndex.value = index;
    } else if (index == 4) {
      currentIndex.value = index;
    }
  }

  void addPage(){
    stackPage.value += 1;
  }
  void deletePage(){
    stackPage.value -= 1;
  }

  void getbacks(){
    for(int i = 0 ; i < stackPage.value; i ++){
      Get.back();
    }
  }
}
