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

  void onMarkerTap(Marker? marker, Map<String, int?>? iconSize) {
    int pos = markers.indexWhere((m) => m.markerId == marker?.markerId);
    markers[pos].captionText = '선택됨';
    // setState(() {});
    // _name.value = '선택됨';
    // Get.dialog(Container(
    //   child: Text('as'),
    // ));
    // if (currentMode.value == MODE_REMOVE) {
    //   markers.removeWhere((m) => m.markerId == marker?.markerId);
    // }
  }

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
  @override
  void onReady() {
    super.onReady();
    OverlayImage.fromAssetImage(
      assetName: 'assets/icons/marker.png',
    ).then((image) {
      markers.add(Marker(
          markerId: 'id',
          position: LatLng(37.563600, 126.962370),
          captionText: '한양대학교',
          captionColor: Colors.indigo,
          captionTextSize: 14.0,
          icon: image,
          anchor: AnchorPoint(0.5, 1),
          width: 45,
          height: 45,
          onMarkerTab: onMarkerTap));
    });
  }
}
