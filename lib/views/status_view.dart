import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/status_controller.dart';
import 'package:universiting/controllers/status_room_tab_controller.dart';
import 'package:universiting/widgets/my_room_get_request_widget.dart';

class StatusView extends StatelessWidget {
  StatusView({Key? key}) : super(key: key);
  StatusRoomTabController myRoomTabController = Get.put(StatusRoomTabController());
  StatusController statusController = Get.put(StatusController());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: Obx(
                () => 
               Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 230,
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
                                              ? kHeaderStyle3
                                              : kHeaderStyle3.copyWith(
                                                  color: kMainBlack
                                                      .withOpacity(0.38)))),
                                  Tab(
                                      icon: Text('보낸 신청',
                                          style: myRoomTabController
                                                      .currentIndex.value ==
                                                  1
                                              ? kHeaderStyle3
                                              : kHeaderStyle3.copyWith(
                                                  color: kMainBlack
                                                      .withOpacity(0.38)))),
                                  
                                ]),
                          ),
                        ],
                      ),
                      Expanded(
                          child: TabBarView(
                        children: [
                          MyRoomGetRequestWidget(),
                          Text('dsds')
                        ],
                        controller: myRoomTabController.tapcontroller,
                      ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
  }
}
