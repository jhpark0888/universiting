import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class MapController extends GetxController {
  static MapController get to => Get.find();
  final Completer<NaverMapController> nMapController = Completer();

  final RxList<Marker> markers = <Marker>[].obs;
  // final RxString _name = '한양대학교'.obs;

  // final RxInt currentMode = MODE_NONE.obs;

  // void onMapTap(LatLng latLng) {
  //   if (currentMode.value == MODE_ADD) {
  //     markers.add(Marker(
  //       markerId: DateTime.now().toIso8601String(),
  //       position: latLng,
  //       infoWindow: '테스트',
  //       onMarkerTab: onMarkerTap,
  //     ));
  //   }
  // }

}
