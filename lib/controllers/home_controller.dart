import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
// import 'package:universiting/api/main_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/map_controller.dart';
import 'package:universiting/controllers/profile_controller.dart';
import 'package:universiting/models/main_univ_model.dart';
import 'package:universiting/models/profile_model.dart';
import 'package:universiting/utils/global_variable.dart';
import 'package:universiting/views/home_view.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  static HomeController get to => Get.find(tag: '첫 화면');
  MapController mapController = Get.put(MapController());
  RxList<MainUniv> mainuniv = <MainUniv>[].obs;
  String? univId;
  RxString markerId = ''.obs;
  RxBool isLoading = true.obs;
  RxBool isGuest = true.obs;
  RxBool islogin = false.obs;
  RxBool isDetailClick = false.obs;
  late final OverlayImage image;
  

  @override
  void onInit() async {
    OverlayImage.fromAssetImage(assetName: 'assets/icons/marker.png')
        .then((value) => image = value);
    mainuniv.value = (await getMainUniv());
    createdMarker();
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

  void createdMarker() async{
    showcustomCustomDialog(1200);
    mainuniv.value = (await getMainUniv());
    mapController.markers.clear();
    mapController.markers.value = mainuniv
        .map((element) => Marker(
            markerId: element.id.toString(),
            position: LatLng(element.lat, element.lng),
            captionText: element.schoolname,
            captionColor: Colors.indigo,
            captionTextSize: 14.0,
            icon: image,
            iconTintColor: element.type ? kMainBlack : kPrimary,
            anchor: AnchorPoint(0.5, 1),
            width: 45,
            height: 45,
            onMarkerTab: mapController.onMarkerTap))
        .toList();
  }


  Future<List<MainUniv>> getMainUniv() async {
    ConnectivityResult result = await checkConnectionStatus();
    final url = Uri.parse('$serverUrl/school_api/main_load');
    if (result == ConnectivityResult.none) {
      showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
      return [
        MainUniv(
            id: 0, schoolname: '', lat: 37.563600, lng: 126.962370, type: false)
      ].obs;
    } else {
      try {
        
        var response = await http.get(url);
        
        if (response.statusCode >= 200 && response.statusCode < 300) {
          Get.back();
          isLoading(false);
          isLoading(false);
          String responsebody = utf8.decode(response.bodyBytes);
          print(response.statusCode);
          return mainUnivParse(responsebody);
        } else {
          print(response.statusCode);
          return [
            MainUniv(
                id: 0,
                schoolname: '',
                lat: 37.563600,
                lng: 126.962370,
                type: false)
          ].obs;
        }
      } catch (e) {
        print(e);
        if (isLoading.value == false) showCustomDialog('서버 점검중입니다.', 1200);
        return [
          MainUniv(
              id: 0,
              schoolname: '',
              lat: 37.563600,
              lng: 126.962370,
              type: false)
        ].obs;
      }
    }
  }
}
