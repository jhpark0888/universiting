import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/univ_room_controller.dart';

void bottomSheetModal(Widget widget, RxBool a) {
  
  showModalBottomSheet(
      isScrollControlled: true,
      useRootNavigator: true,
      barrierColor: kMainWhite.withOpacity(0.1),
      isDismissible: true,
      context: Get.context!,
      builder: (context) {
        return widget;
      }).whenComplete((){a.value = false; Get.delete<UnivRoomController>(); });
}