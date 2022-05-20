import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/app_controller.dart';
import 'package:universiting/controllers/management_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:universiting/views/m_my_room_view.dart';
import 'package:universiting/views/m_send_request_view.dart';
import 'package:universiting/widgets/scroll_noneffect_widget.dart';

class ManagementView extends StatelessWidget {
  ManagementView({Key? key}) : super(key: key);
  final ManagementController _manageController =
      Get.put(ManagementController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        try {
          if (Platform.isAndroid &&
              (AppController.to.currentIndex.value == 1)) {
            AppController.to.currentIndex(0);
            return false;
          }
        } catch (e) {
          print(e);
        }

        return true;
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: false,
              elevation: 0,
              titleSpacing: 20,
              title: const Padding(
                padding: EdgeInsets.only(top: 28),
                child: Text(
                  '관리',
                  style: k26SemiBold,
                ),
              ),
            ),
            body: NestedScrollView(
                headerSliverBuilder: (context, value) {
                  return [
                    SliverAppBar(
                      toolbarHeight: 70,
                      automaticallyImplyLeading: false,
                      elevation: 0,
                      floating: false,
                      pinned: true,
                      flexibleSpace: TabBar(
                          padding: const EdgeInsets.fromLTRB(20, 18, 0, 18),
                          labelPadding: const EdgeInsets.all(0),
                          indicatorColor: Colors.transparent,
                          labelStyle: k26SemiBold,
                          labelColor: kMainBlack,
                          unselectedLabelStyle: k26SemiBold,
                          unselectedLabelColor: kMainBlack.withOpacity(0.4),
                          isScrollable: true,
                          controller: _manageController.managetabController,
                          tabs: [
                            Row(
                              children: [
                                const Tab(
                                  text: '내 방',
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Container(
                                  height: 26,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              color: kMainBlack
                                                  .withOpacity(0.1)))),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                              ],
                            ),
                            Tab(
                              text: '보낸 신청',
                            )
                          ]),
                    ),
                  ];
                },
                body: ScrollNoneffectWidget(
                  child: TabBarView(
                      controller: _manageController.managetabController,
                      children: [MyRoomView(), SendRequestView()]),
                ))),
      ),
    );
  }
}
