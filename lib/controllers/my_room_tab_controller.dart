import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyRoomTabController extends GetxController with GetSingleTickerProviderStateMixin{
  late TabController tapcontroller;
  RxInt currentIndex = 0.obs;
  @override 
  void onInit(){
    super.onInit();
    tapcontroller = TabController(length: 3, vsync: this);

  }

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