import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/api/login_api.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/views/image_check_view.dart';

class AppController extends GetxController {
  static AppController get to => Get.find();
  RxInt currentIndex = 0.obs;
  RxInt stackPage = 0.obs;
  RxBool isImageCheck = true.obs;
  @override
  void onInit() async{
    if(isImageCheck.value == false){
      customDialog(1);
    }
    image();
    super.onInit();
  }
  void changePageIndex(int index) {
    if (index == 0) {
      currentIndex.value = index;
    } else if (index == 1) {
      currentIndex.value = index;
    } else if (index == 2) {
      currentIndex.value = index;
    } else if (index == 3) {
      currentIndex.value = index;
    }
  }

  void addPage() {
    stackPage.value += 1;
  }

  void deletePage() {
    stackPage.value -= 1;
  }

  void getbacks() {
    for (int i = 0; i < stackPage.value; i++) {
      Get.back();
    }
  }

  void image() async {
    await imageCheck().then((httpresponse) async {
      if (httpresponse.isError == false) {
        print(httpresponse.data);
        isImageCheck.value = httpresponse.data;
      }
    });
  }
}
