import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/my_room_tab_controller.dart';
import 'package:universiting/widgets/my_room_get_request_widget.dart';

class RoomView extends StatelessWidget {
  RoomView({Key? key}) : super(key: key);
  MyRoomTabController myRoomTabController = Get.put(MyRoomTabController());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: Obx(
                () => Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 250,
                          child: TabBar(
                              onTap: myRoomTabController.changePageIndex,
                              indicatorColor: kLightGrey,
                              controller: myRoomTabController.tapcontroller,
                              unselectedLabelColor:
                                  kMainBlack.withOpacity(0.38),
                              tabs: [
                                Tab(
                                    icon: Text('받은 신청',
                                        style: myRoomTabController
                                                    .currentIndex.value ==
                                                0
                                            ? kSmallCaptionStyle
                                            : kSmallCaptionStyle.copyWith(
                                                color: kMainBlack
                                                    .withOpacity(0.38)))),
                                Tab(
                                    icon: Text('보낸 신청',
                                        style: myRoomTabController
                                                    .currentIndex.value ==
                                                1
                                            ? kSmallCaptionStyle
                                            : kSmallCaptionStyle.copyWith(
                                                color: kMainBlack
                                                    .withOpacity(0.38)))),
                                Tab(
                                    icon: Text('채팅방',
                                        style: myRoomTabController
                                                    .currentIndex.value ==
                                                2
                                            ? kSmallCaptionStyle
                                            : kSmallCaptionStyle.copyWith(
                                                color: kMainBlack
                                                    .withOpacity(0.38))))
                              ]),
                        ),
                        Text('이용권')
                      ],
                    ),
                    Expanded(
                        child: TabBarView(
                      children: [
                        MyRoomGetRequestWidget(),
                        Text('dsds'),
                        Text('dsad')
                      ],
                      controller: myRoomTabController.tapcontroller,
                    ))
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
