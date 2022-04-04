import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/custom_animation_controller.dart';
import 'package:universiting/controllers/home_controller.dart';
import 'package:universiting/controllers/univ_room_controller.dart';
import 'package:universiting/modal.dart';
import 'package:universiting/widgets/univ_room_widget.dart';

class MapController extends GetxController {
  static MapController get to => Get.find();
  Completer<NaverMapController> nMapController = Completer();
  RxList<Marker> markers = <Marker>[].obs;
  RxString clickedUniv = ''.obs;
  RxString clickedId = ''.obs;
  RxBool isClick = false.obs;
  RxBool isDetailClick = false.obs;
  final CustomAnimationController _animationController =
      Get.put(CustomAnimationController(), tag: 'bottomnavigation');
  void onMapCreated(NaverMapController controller) {
    if (nMapController.isCompleted) nMapController = Completer();
    nMapController.complete(controller);
  }

  void onCameraChange(
      LatLng? latLng, CameraChangeReason reason, bool? isAnimated) {
    // print('카메라 움직임 >>> 위치 : ${latLng!.latitude}, ${latLng.longitude}'
    //     '\n원인: $reason'
    //     '\n에니메이션 여부: $isAnimated');
  }

  Future<void> onMarkerTap(Marker? marker, Map<String, int?>? iconSize) async {
    int pos = markers.indexWhere((m) => m.markerId == marker?.markerId);
    clickedId.value = markers.value[pos].markerId;
    clickedUniv.value = markers[pos].captionText!;
    isClick.value = true;
    clickedId.refresh();
    clickedUniv.refresh();
    isClick.refresh();
    print(HomeController.to.isGuest.value);
    if (HomeController.to.isGuest.value == false) {
      try {
        bottomSheetModal(UnivRoomWidget(), isDetailClick, pos);
        // HomeController.to.univRoom.add(UnivRoomWidget());
        Timer(Duration(milliseconds: 500), () async{
          await HomeController.to.getDetailOverlyImage(
              UnivRoomController.to.univRoom.length.toString());
              HomeController.to.image.refresh();
              markers[pos].icon = HomeController.to.image.last;
              
markers.refresh();
        });
        
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
}
