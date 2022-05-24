import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/admob_controller.dart';
import 'package:universiting/controllers/home_controller.dart';
import 'package:universiting/controllers/map_controller.dart';
import 'package:universiting/controllers/univ_room_controller.dart';

void bottomSheetModal(Widget widget,RxBool isClick, RxBool isDetailClick, int index) {
  showModalBottomSheet(
      shape: !MapController.to.isDetailClick.value
          ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))
          : const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      isScrollControlled: true,
      useRootNavigator: true,
      barrierColor: kMainWhite.withOpacity(0.1),
      isDismissible: true,
      enableDrag: false,
      context: Get.context!,
      builder: (context) {
        return widget;
      }).whenComplete(() {
    isDetailClick.value = false;
    isClick.value = false;
    UnivRoomController.to.univRoom.isEmpty
        ? MapController.to.markers[index].icon = HomeController.to.image[1]
        : MapController.to.markers[index].icon = HomeController.to.image[0];
    MapController.to.markers.refresh();
    Get.delete<UnivRoomController>();
    Get.delete<AdmobController>();
  });
}


