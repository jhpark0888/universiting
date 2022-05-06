import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/management_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:universiting/views/room_info_view.dart';

class MyRoomView extends StatelessWidget {
  MyRoomView({Key? key}) : super(key: key);
  final ManagementController _manageController =
      Get.put(ManagementController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SmartRefresher(
          controller: _manageController.myroomrefreshController,
          enablePullUp: _manageController.enablepullupMyRoom.value,
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
          footer: ClassicFooter(
            loadStyle: LoadStyle.ShowWhenLoading,
            spacing: 0.0,
            completeDuration: Duration(milliseconds: 600),
            loadingText: "로딩 중",
            canLoadingText: "캔 로딩 중",
            idleText: "아이들",
            textStyle: TextStyle(color: kMainBlack),
            idleIcon: Container(),
          ),
          onRefresh: _manageController.onRoomRefresh,
          onLoading: _manageController.onRoomLoading,
          child:
              // Text(myRoomController.myRoomList.value.chiefList[0].toString())
              Obx(
            () => _manageController.room.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '아직 방이 없어요',
                        style: kSubtitleStyle2.copyWith(
                            color: kMainBlack.withOpacity(0.38)),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                          onTap: () {
                            Get.to(() => RoomInfoView());
                          },
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          height: 42,
                                          decoration: BoxDecoration(
                                              color: kPrimary,
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          padding: const EdgeInsets.fromLTRB(
                                              30, 13, 30, 13),
                                          child: Center(
                                            child: Text(
                                              '방 만들기',
                                              style: kBodyStyle2.copyWith(
                                                  color: kMainWhite, height: 1),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ])))
                    ],
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 82),
                      child: Column(
                        children: _manageController.room.reversed.toList(),
                      ),
                    ),
                  ),
          )),
    );
  }
}
