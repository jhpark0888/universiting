import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatusRoomTabController extends GetxController with GetSingleTickerProviderStateMixin{
  static StatusRoomTabController get to => Get.find();
  late TabController tapcontroller;
  RxInt currentIndex = 0.obs;
  @override 
  void onInit(){
    super.onInit();
    tapcontroller = TabController(length: 2, vsync: this);

  }

  void changePageIndex(int index){
    if(index == 0){
      currentIndex.value = index;
    }else if(index == 1){
      currentIndex.value = index; 
    }
  }
}