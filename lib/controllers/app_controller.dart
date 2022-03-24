import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  RxInt currentIndex = 0.obs;

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
}
