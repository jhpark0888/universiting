import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/management_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SendRequestView extends StatelessWidget {
  SendRequestView({Key? key}) : super(key: key);
  final ManagementController _manageController =
      Get.put(ManagementController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SmartRefresher(
          controller: _manageController.requestrefreshController,
          enablePullUp: _manageController.enablepulluprequest.value,
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
          onRefresh: _manageController.onRequestRefresh,
          onLoading: _manageController.onRequestLoading,
          child:
              // Text(myRoomController.myRoomList.value.chiefList[0].toString())
              Obx(
            () => _manageController.sendRequestWidgetList.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '아직 보낸 신청이 없어요',
                        style: kSubtitleStyle2.copyWith(
                            color: kMainBlack.withOpacity(0.38)),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                : SingleChildScrollView(
                    child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 82),
                    child: Column(
                      children: _manageController.sendRequestWidgetList.reversed
                          .toList(),
                    ),
                  )),
          )),
    );
  }
}
