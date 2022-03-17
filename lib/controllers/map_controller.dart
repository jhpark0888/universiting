import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/home_controller.dart';
import 'package:universiting/controllers/univ_room_controller.dart';
import 'package:universiting/widgets/univ_room_widget.dart';

class MapController extends GetxController {
  static MapController get to => Get.find();
  final Completer<NaverMapController> nMapController = Completer();
  RxList<Marker> markers = <Marker>[].obs;
  RxString clickedUniv = ''.obs;
  RxString clickedId = ''.obs;
  RxBool isClick = false.obs;
  RxBool isDetailClick = false.obs;
  
  void onMapCreated(NaverMapController controller) {
    nMapController.complete(controller);
  }

  void onMarkerTap(Marker? marker, Map<String, int?>? iconSize) {
    int pos = markers.indexWhere((m) => m.markerId == marker?.markerId);
    clickedId.value = markers.value[pos].markerId;
    clickedUniv.value = markers[pos].captionText!;
    isClick.value = true;
    clickedId.refresh();
    clickedUniv.refresh();
    isClick.refresh();
    print('실행됐어요');
    if(HomeController.to.isGuest.value == false){
    try {
      
      bottomSheetModal();
    } catch (e) {
      print(e);
    }
    }
  }

  @override
  void onClose() {
    markers.clear();
    isClick(false);
    super.onClose();
  }

  void bottomSheetModal() {
  
  showModalBottomSheet(
      isScrollControlled: true,
      useRootNavigator: true,
      barrierColor: kMainWhite.withOpacity(0.1),
      isDismissible: true,
      context: Get.context!,
      builder: (context) {
        return UnivRoomWidget();
      }).whenComplete((){isDetailClick.value = false; Get.delete<UnivRoomController>(); });
}
}
