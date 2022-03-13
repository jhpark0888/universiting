import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/map_controller.dart';

void bottomSheetModal() {
  MapController mapController = Get.find();
  showModalBottomSheet(
      isScrollControlled: true,
      useRootNavigator: true,
      barrierColor: kMainWhite.withOpacity(0.1),
      isDismissible: false,
      context: Get.context!,
      builder: (context) {
        return Obx(
          () => SafeArea(
            child: AnimatedContainer(
            height: mapController.isDetailClick.value
                ? Get.height - 30
                : Get.width / 1.5,
            duration: Duration(milliseconds: 100),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            )),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
              ),
              child: GestureDetector(
                onTap: () {
                  mapController.isDetailClick.value =
                      !mapController.isDetailClick.value;
                  print(mapController.isDetailClick.value);
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
                            mapController.clickedUniv.value,
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
