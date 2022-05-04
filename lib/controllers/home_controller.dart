import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
// import 'package:universiting/api/main_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/map_controller.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/controllers/notifications_controller.dart';
import 'package:universiting/controllers/profile_controller.dart';
import 'package:universiting/models/main_univ_model.dart';
import 'package:universiting/models/profile_model.dart';
import 'package:universiting/utils/global_variable.dart';
import 'package:universiting/views/home_view.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find(tag: '다음 화면');
  TextEditingController searchUniv = TextEditingController();
  MapController mapController = Get.put(MapController(), permanent: true);
  RxList<Widget> univRoom = [Container()].obs;
  RxList<MainUniv> mainuniv = <MainUniv>[].obs;
  RxList<MainUniv> searchedUniv = <MainUniv>[].obs;
  String? univId;
  RxString markerId = ''.obs;
  RxDouble searchPadding = 70.0.obs;
  RxDouble statusBarHeight = 0.0.obs;
  RxBool isLoading = true.obs;
  RxBool isGuest = true.obs;
  RxBool islogin = false.obs;
  RxBool isDetailClick = false.obs;
  RxBool isSearch = false.obs;
  RxBool iskeybord = false.obs;
  final RxList<OverlayImage> image = <OverlayImage>[].obs;
  // late final OverlayImage image;
  @override
  void onInit() async {
    String? temptoken = await const FlutterSecureStorage().read(key: 'token');
    var keyboardVisibilityController = KeyboardVisibilityController();
    statusBarHeight.value = MediaQuery.of(Get.context!).padding.top;
    if (temptoken != null) {
      isGuest.value = false;
      islogin.value = true;
    }
    await getOverlyImage();
    mainuniv.value = (await getMainUniv());
    // showcustomCustomDialog(1200);
    customDialog(1);
    createdMarker();
    super.onInit();

    searchUniv.addListener(() {
      searchedUniv.clear();
      for (MainUniv univ in mainuniv) {
        if (searchUniv.text != '') {
          if (univ.schoolname.contains(searchUniv.text)) {
            searchedUniv.add(
              univ,
            );
          }
        }
      }
    });
  keyboardVisibilityController.onChange.listen((bool visible) {
    iskeybord.value = visible;
    if(iskeybord.value == false && isSearch.value == true){
      isSearch(false);
    }
    if(iskeybord.value == true){
      searchPadding.value = MediaQuery.of(Get.context!).viewInsets.bottom;
    }else if(iskeybord.value == false){
      searchPadding.value = 70.0;
    }
  });
  }

  @override
  void onClose() {
    mainuniv.clear;
    islogin(false);
    isGuest(true);
    isDetailClick(false);
    super.onClose();
  }

  void createdMarker() async {
    // showcustomCustomDialog(1200);
    mainuniv.value = (await getMainUniv());
    mapController.markers.clear();
    mapController.markers.value = mainuniv
        .map((element) => Marker(
            markerId: element.id.toString(),
            position: LatLng(element.lat, element.lng),
            captionText: element.schoolname,
            captionColor: Colors.indigo,
            captionTextSize: 14.0,
            icon: element.type ? image[0] : image[1],
            width: 36,
            height: 45,
            onMarkerTab: mapController.onMarkerTap))
        .toList();
  }

  Future<void> getOverlyImage() async {
    image.add(await OverlayImage.fromAssetImage(
        assetName: 'assets/icons/marker_unselected.png',
        size: const Size(36, 45)));

    image.add(await OverlayImage.fromAssetImage(
        assetName: 'assets/icons/marker_none_unselect.png',
        size: const Size(36, 45)));
  }

  Future<void> getDetailOverlyImage(String count) async {
    if (int.parse(count) == 0) {
      image.add(await OverlayImage.fromAssetImage(
          assetName: 'assets/icons/marker_none.png', size: const Size(36, 45)));
    } else if (int.parse(count) <= 9) {
      image.add(await OverlayImage.fromAssetImage(
          assetName: 'assets/icons/marker_$count.png',
          size: const Size(36, 45)));
    } else if (int.parse(count) > 9) {
      image.add(await OverlayImage.fromAssetImage(
          assetName: 'assets/icons/marker_9.png', size: const Size(36, 45)));
    }
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

  Widget searchListWidget(RxList<Widget> univ) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
            color: kBackgroundWhite, borderRadius: BorderRadius.circular(16)),
        child: ListView(
            shrinkWrap: true,
            children: univ
                .map((e) => GestureDetector(
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          e,
                          const SizedBox(height: 20),
                          Divider(
                            thickness: 1,
                            color: kMainBlack.withOpacity(0.05),
                          )
                        ],
                      ),
                    ))
                .toList()),
      ),
    );
  }
}
