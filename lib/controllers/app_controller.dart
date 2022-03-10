import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppController extends GetxController{

  RxInt currentIndex = 1.obs;

  void changePageIndex(int index){
    if(index == 0){
      currentIndex.value = index;
    }else if(index == 1){
      currentIndex.value = index; 
    }else if(index == 2){
      currentIndex.value = index;
    }
  }
}