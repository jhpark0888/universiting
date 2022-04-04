import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/home_controller.dart';
import 'package:universiting/controllers/map_controller.dart';
import 'package:universiting/controllers/univ_room_controller.dart';

void bottomSheetModal(Widget widget, RxBool a, int index) {
  showModalBottomSheet(
      isScrollControlled: true,
      useRootNavigator: true,
      barrierColor: kMainWhite.withOpacity(0.1),
      isDismissible: true,
      context: Get.context!,
      builder: (context) {
        return widget;
      }).whenComplete(() {
    a.value = false;
    UnivRoomController.to.univRoom.isEmpty ?
    MapController.to.markers[index].icon = HomeController.to.image[1] :
    MapController.to.markers[index].icon = HomeController.to.image[0];
    MapController.to.markers.refresh();
    Get.delete<UnivRoomController>();
  });
}


// void bottomSheetModals(Widget widget, RxBool a, int index) {
//   return 
// }