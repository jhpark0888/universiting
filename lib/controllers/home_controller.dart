import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:universiting/api/main_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/map_controller.dart';
import 'package:universiting/models/main_univ_model.dart';
import 'package:universiting/views/home_view.dart';

class HomeController extends GetxController {
  HomeController();
  MapController mapController = Get.put(MapController());
  RxList<MainUniv> mainuniv = <MainUniv>[].obs;

  RxBool isGuest = true.obs;
  RxBool islogin = false.obs;
  RxBool isDetailClick = false.obs;
  late final OverlayImage image;

  @override
  void onInit() async {
    OverlayImage.fromAssetImage(assetName: 'assets/icons/marker.png')
        .then((value) => image = value);
    mainuniv.value = (await getMainUniv());
    mapController.markers.value = mainuniv
        .map((element) => Marker(
            markerId: element.id.toString(),
            position: LatLng(element.lat, element.lng),
            captionText: element.schoolname,
            captionColor: Colors.indigo,
            captionTextSize: 14.0,
            icon: image,
            iconTintColor: element.type ? kMainBlack : Colors.red,
            anchor: AnchorPoint(0.5, 1),
            width: 45,
            height: 45,
            onMarkerTab: mapController.onMarkerTap))
        .toList();
    super.onInit();
  }

  @override
  void onClose() {
    mainuniv.clear;
    islogin(false);
    isGuest(true);
    isDetailClick(false);
    super.onClose();
  }
}
