import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/map_controller.dart';
import 'package:universiting/controllers/univ_room_controller.dart';

class UnivRoomWidget extends StatelessWidget {
  UnivRoomWidget({Key? key}) : super(key: key);
  MapController mapController = Get.find();

  @override
  Widget build(BuildContext context) {
    UnivRoomController univRoomController = Get.put(UnivRoomController());
    return Obx(
      () => SafeArea(
        child: AnimatedContainer(
            height: mapController.isDetailClick.value
                ? Get.height - 30
                : Get.width / 1.5,
            duration: Duration(milliseconds: 100),
            decoration: const BoxDecoration(
                color: kBackgroundWhite,
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
                      print('눌렸다');
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(
                            child: Container(
                                height: 4, width: 28, color: kLightGrey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                mapController.clickedUniv.value,
                                style: kSubtitleStyle1,
                              ),
                              Text(
                                '방 ${univRoomController.univRoom.length}개',
                                style: kSubtitleStyle2,
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          if (univRoomController.univRoom.isEmpty)
                            Text(
                              '아직 만들어진 방이 없어요',
                              style: kSubtitleStyle2.copyWith(
                                  color: kMainBlack.withOpacity(0.38)),
                            ),
                          if (univRoomController.univRoom.isNotEmpty)
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: univRoomController.room,
                                ),
                              ),
                            )
                        ]),
                      )
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
