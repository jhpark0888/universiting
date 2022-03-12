import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/home_controller.dart';

class MapController extends GetxController {
  static MapController get to => Get.find();
  final Completer<NaverMapController> nMapController = Completer();
  BuildContext? context1;
  RxList<Marker> markers = <Marker>[].obs;
  RxString clickedUniv = ''.obs;
  RxBool isClick = false.obs;
  RxBool isDetailClick = false.obs;
  // final RxString _name = '한양대학교'.obs;

  // final RxInt currentMode = MODE_NONE.obs;
  void bottomSheetModal(context1) {
    showModalBottomSheet(
      isScrollControlled : true,
      useRootNavigator : true,
        barrierColor: kMainWhite.withOpacity(0.1),
        isDismissible: false,
        context: context1,
        builder: (context) {
          return Obx(
            () => SafeArea(
              child: AnimatedContainer(
                  height: isDetailClick.value ? Get.height - 30 : Get.width / 1.5,
                  duration: Duration(milliseconds: 100),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  )),
                  // foregroundDecoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),color: kMainWhite),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        isDetailClick.value = !isDetailClick.value;
                        print(isDetailClick.value);
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 12, 20, 0),
                        child: Column(
                          children: [
                            Center(
                                child: Container(
                                    height: 10, width: 28, color: kLightGrey)),
                            SizedBox(height: 21),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  clickedUniv.value,
                                  style: kHeaderStyle2,
                                ),
                                Text(
                                  '방 0개',
                                  style: kSubtitleStyle1,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
            ),
          );
        });
    print('실행되었습니다.');
  }

  void onMarkerTap(Marker? marker, Map<String, int?>? iconSize) {
    int pos = markers.indexWhere((m) => m.markerId == marker?.markerId);
    clickedUniv.value = markers[pos].captionText!;
    isClick.value = true;
    clickedUniv.refresh();
    isClick.refresh();
    print('실행됐어요');
    try {
      bottomSheetModal(context1);
    } catch (e) {
      print(e);
    }
    print('실행됐어요');
    // setState(() {});
    // _name.value = '선택됨';
    // Get.dialog(Container(
    //   child: Text('as'),
    // ));
    // if (currentMode.value == MODE_REMOVE) {
    //   markers.removeWhere((m) => m.markerId == marker?.markerId);
    // }
    print('${clickedUniv}');
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
  // @override
  // void onReady() {
  //   super.onReady();
  //   OverlayImage.fromAssetImage(
  //     assetName: 'assets/icons/marker.png',
  //   ).then((image) {
  //     markers.add(Marker(
  //         markerId: 'id',
  //         position: LatLng(37.563600, 126.962370),
  //         captionText: '한양대학교',
  //         captionColor: Colors.indigo,
  //         captionTextSize: 14.0,
  //         icon: image,
  //         anchor: AnchorPoint(0.5, 1),
  //         width: 45,
  //         height: 45,
  //         onMarkerTab: onMarkerTap));
  //   });
  // }

  @override
  void onClose() {
    markers.clear();
    isClick(false);
    super.onClose();
  }
}
