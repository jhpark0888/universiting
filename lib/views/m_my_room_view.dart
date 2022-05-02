import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/management_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyRoomView extends StatelessWidget {
  MyRoomView({Key? key}) : super(key: key);
  final ManagementController _manageController =
      Get.put(ManagementController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SmartRefresher(
          controller: _manageController.myroomrefreshController,
          header: const ClassicHeader(
              spacing: 0.0,
              height: 60,
              completeDuration: Duration(milliseconds: 600),
              textStyle: TextStyle(color: kMainBlack),
              refreshingText: '',
              releaseText: "",
              completeText: "",
              idleText: "",
              refreshingIcon: Text('당기는 중입니다.')),
          onRefresh: _manageController.onRefresh,
          child:
              // Text(myRoomController.myRoomList.value.chiefList[0].toString())
              SingleChildScrollView(
                  child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 82),
            child: Column(
              children: _manageController.room.reversed.toList(),
            ),
          ))),
    );
  }
}
