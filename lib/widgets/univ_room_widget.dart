import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/map_controller.dart';
import 'package:universiting/controllers/univ_room_controller.dart';
import 'package:universiting/views/univ_room_view.dart';
import 'package:universiting/widgets/scroll_noneffect_widget.dart';

class UnivRoomWidget extends StatelessWidget {
  UnivRoomWidget({Key? key}) : super(key: key);
  MapController mapController = Get.find();

  @override
  Widget build(BuildContext context) {
    UnivRoomController univRoomController = Get.put(UnivRoomController());
    return Obx(
      () => SafeArea(
        child: AnimatedContainer(
            height:
                // mapController.isDetailClick.value ? Get.height : 220
                univRoomController.changeHeight.value,
            duration: const Duration(milliseconds: 200),
            decoration: !mapController.isDetailClick.value
                ? const BoxDecoration(
                    color: kBackgroundWhite,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ))
                : const BoxDecoration(color: kBackgroundWhite),
            child: ClipRRect(
              borderRadius: !mapController.isDetailClick.value
                  ? univRoomController.changeHeight.value == Get.height
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        )
                      : BorderRadius.zero
                  : BorderRadius.zero,
              child: GestureDetector(
                onTap: () {
                  // mapController.isDetailClick.value =
                  //     !mapController.isDetailClick.value;

                  // mapController.isDetailClick.value
                  //     ? univRoomController.changeHeight.value = Get.height
                  //     : univRoomController.changeHeight.value = 220;
                },
                onVerticalDragUpdate: (value) {
                  mapController.isDetailClick(true);
                  if (univRoomController.changeHeight.value <
                      Get.height - value.globalPosition.dy) {
                    univRoomController.changeHeight.value = Get.height;
                  }
                  if (Get.height - value.globalPosition.dy > Get.height - 100) {
                    if (univRoomController.changeHeight.value >
                        Get.height - value.globalPosition.dy) {
                      Get.back();
                    }
                  }

                  // // if (univRoomController.changeHeight.value -
                  // //         Get.height -
                  // //         value.globalPosition.dy >
                  // //     100) {
                  // //   Get.back();
                  // //   print('실행1');
                  // // }
                  // // if (univRoomController.changeHeight.value -
                  // //         Get.height -
                  // //         value.globalPosition.dy <
                  // //     -100) {
                  // //   univRoomController.changeHeight.value = Get.height;
                  // //   print('실행2');
                  // // }

                  // // if (univRoomController.changeHeight.value == Get.height) {
                  // //   univRoomController.changeHeight.value =
                  // //       Get.height - value.globalPosition.dy;
                  // //   print('실행3');
                  // // }
                  // // if (Get.height - value.globalPosition.dy < Get.height - 60 &&
                  // //     Get.height - value.globalPosition.dy > 10) {
                  // //   univRoomController.changeHeight.value =
                  // //       Get.height - value.globalPosition.dy;
                  // //   print('실행4');
                  // // } else if (Get.height - value.globalPosition.dy >=
                  // //     Get.height - 30) {
                  // //   univRoomController.changeHeight.value = Get.height;
                  // //   print('실행5');
                  // // } else if (Get.height - value.globalPosition.dy <= 10) {
                  // //   univRoomController.changeHeight.value = 0;
                  // //   Get.back();
                  // //   print('실행6');
                  // // }

                  // // if (univRoomController.changeHeight.value < 100) {
                  // //   Get.back();
                  // //   print('실행7');
                  // }
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Stack(children: [
                    Column(
                      children: [
                        if (univRoomController.changeHeight.value != Get.height)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Center(
                                child: Container(
                                  height: 5,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: kIconColor),
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(height: 28),
                        GestureDetector(
                          onTap: () {
                            print('dsadas');
                          },
                          child: Container(
                              padding: univRoomController.changeHeight.value == Get.height
                                  ? EdgeInsets.only(top: 28)
                                  : EdgeInsets.only(top: 0),
                              color: kBackgroundWhite,
                              width: Get.width,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Text(
                                  mapController.clickedUniv.value,
                                  style: kBodyStyle6,
                                ),
                              )),
                        ),
                        const SizedBox(height: 28),
                        if (univRoomController.univRoom.isEmpty)
                          Text(
                            '아직 만들어진 방이 없어요',
                            style: kSubtitleStyle2.copyWith(
                                color: kMainBlack.withOpacity(0.38)),
                          ),
                        if (univRoomController.univRoom.isNotEmpty)
                          Expanded(
                            child: ScrollNoneffectWidget(
                              child: SingleChildScrollView(
                                physics:
                                    univRoomController.changeHeight.value ==
                                            Get.height
                                        ? null
                                        : const NeverScrollableScrollPhysics(),
                                child: Column(
                                  children:
                                      univRoomController.room.reversed.toList(),
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                    if (mapController.isDetailClick.value)
                      Positioned.fill(
                        bottom: 20,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: kPrimary,
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      padding: const EdgeInsets.fromLTRB(
                                          30, 14, 30, 14),
                                      child: Center(
                                        child: Text(
                                          '홈으로 돌아가기',
                                          style: kBodyStyle2.copyWith(
                                              color: kMainWhite, height: 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                  ]),
                ),
              ),
            )),
      ),
    );
  }
}
