import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/admob_controller.dart';
import 'package:universiting/controllers/home_controller.dart';
import 'package:universiting/controllers/map_controller.dart';
import 'package:universiting/controllers/univ_room_controller.dart';
import 'package:universiting/views/univ_room_view.dart';
import 'package:universiting/widgets/loading_widget.dart';
import 'package:universiting/widgets/scroll_noneffect_widget.dart';

class UnivRoomWidget extends StatelessWidget {
  UnivRoomWidget({Key? key}) : super(key: key);
  MapController mapController = Get.find();
  UnivRoomController univRoomController = Get.put(UnivRoomController());

  double startoffset = 0;
  double endoffset = 0;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: AnimatedContainer(
            height:
                // mapController.isDetailClick.value ? Get.height : 220
                univRoomController.changeHeight.value,
            duration: const Duration(milliseconds: 150),
            decoration: !mapController.isDetailClick.value
                ? const BoxDecoration(
                    color: kBackgroundWhite,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ))
                : const BoxDecoration(color: kBackgroundWhite),
            curve: Curves.ease,
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
                  print('object');
                  if (mapController.isDetailClick.value == false) {
                    univRoomController.changeHeight.value = Get.height;
                    mapController.isDetailClick(true);
                  }
                },
                onVerticalDragUpdate: (value) {
                  // print(value.globalPosition.dy);

                  if (univRoomController.changeHeight.value <
                      Get.height - value.globalPosition.dy) {
                    // if(value.)
                    univRoomController.changeHeight.value = Get.height;
                    mapController.isDetailClick(true);
                  }

                  if (Get.height - value.globalPosition.dy > Get.height - 100) {
                    if (univRoomController.changeHeight.value >
                        Get.height - value.globalPosition.dy) {
                      mapController.isDetailClick(false);
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
                  padding: mapController.isDetailClick.value
                      ? EdgeInsets.only(
                          top: HomeController.to.statusBarHeight.value)
                      : const EdgeInsets.only(top: 8),
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
                        // if(mapController.isDetailClick.value == false)
                        const SizedBox(height: 28),
                        Container(
                            // padding: univRoomController.changeHeight.value == Get.height
                            //     ? EdgeInsets.only(top: 28)
                            //     : EdgeInsets.only(top: 0),
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
                        const SizedBox(height: 28),
                        Obx(() => univRoomController.screenstate.value ==
                                Screenstate.loading
                            ? Center(
                                child: Image.asset(
                                  'assets/icons/loading.gif',
                                  scale: 8,
                                ),
                              )
                            : univRoomController.screenstate.value ==
                                    Screenstate.success
                                ? univRoomController.univRoom.isEmpty
                                    ? Text(
                                        '아직 만들어진 방이 없어요',
                                        style: kSubtitleStyle2.copyWith(
                                            color:
                                                kMainBlack.withOpacity(0.38)),
                                      )
                                    : Expanded(
                                        child: NotificationListener<
                                            ScrollNotification>(
                                          onNotification: (scrollNotification) {
                                            if (scrollNotification
                                                is ScrollStartNotification) {
                                              startoffset = univRoomController
                                                  .scrollController.offset;
                                            } else if (scrollNotification
                                                is ScrollEndNotification) {
                                              endoffset = univRoomController
                                                  .scrollController.offset;
                                              if (startoffset == 0.0 &&
                                                  endoffset == 0.0 &&
                                                  mapController.isDetailClick
                                                          .value ==
                                                      true) {
                                                mapController
                                                    .isDetailClick(false);
                                                Get.back();
                                              }
                                            }

                                            return false;
                                          },
                                          child: ScrollNoneffectWidget(
                                            child: ListView.separated(
                                              controller: univRoomController
                                                  .scrollController,
                                              physics: univRoomController
                                                          .changeHeight.value ==
                                                      Get.height
                                                  ? null
                                                  : const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return univRoomController
                                                    .adRoom.reversed
                                                    .toList()[index];
                                              },
                                              separatorBuilder:
                                                  (buildContext, index) {
                                                return Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          20, 18, 20, 18),
                                                      child: Divider(
                                                        thickness: 1.5,
                                                        color: kMainBlack
                                                            .withOpacity(0.05),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                              itemCount: univRoomController
                                                  .adRoom.length),
                                        ),
                                      ))
                                // Expanded(
                                //     child: ScrollNoneffectWidget(
                                //       child: SingleChildScrollView(
                                //         controller: univRoomController
                                //             .scrollController,
                                //         physics: univRoomController
                                //                     .changeHeight.value ==
                                //                 Get.height
                                //             ? null
                                //             : const NeverScrollableScrollPhysics(),
                                //         child: Column(
                                //           children: univRoomController
                                //               .adRoom.reversed
                                //               .toList(),
                                //         ),
                                //       ),
                                //     ),
                                //   )

                                : Container()),
                        // if (univRoomController.univRoom.isEmpty)
                        //   Text(
                        //     '아직 만들어진 방이 없어요',
                        //     style: kSubtitleStyle2.copyWith(
                        //         color: kMainBlack.withOpacity(0.38)),
                        //   ),
                        // if (univRoomController.univRoom.isNotEmpty)
                        //   Expanded(
                        //     child: ScrollNoneffectWidget(
                        //       child: SingleChildScrollView(
                        //         controller: univRoomController.scrollController,
                        //         physics:
                        //             univRoomController.changeHeight.value ==
                        //                     Get.height
                        //                 ? null
                        //                 : const NeverScrollableScrollPhysics(),
                        //         child: Column(
                        //           children:
                        //               univRoomController.room.reversed.toList(),
                        //         ),
                        //       ),
                        //     ),
                        //   )
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
                                      mapController.isDetailClick(false);
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
