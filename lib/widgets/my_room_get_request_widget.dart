import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/status_controller.dart';
import 'package:universiting/views/create_room_view.dart';
import 'package:universiting/widgets/alarm_widget.dart';
import 'package:universiting/widgets/button_widget.dart';

class MyRoomGetRequestWidget extends StatelessWidget {
  MyRoomGetRequestWidget({Key? key}) : super(key: key);
  StatusController statusController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        controller: statusController.refreshController,
        header: const ClassicHeader(
            spacing: 0.0,
            height: 60,
            completeDuration: Duration(milliseconds: 600),
            textStyle: TextStyle(color: kMainBlack),
            refreshingText: '',
            releaseText: "",
            completeText: "",
            idleText: "",
            refreshingIcon: Text('당기는 중입니다.')), onRefresh: statusController.onrefresh,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: statusController.allReceiveList.isEmpty ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      '아직 받은 신청이 없어요',
                      style: kSubtitleStyle2.copyWith(
                          color: kMainBlack.withOpacity(0.38)),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),      
                  ],
                ) : Column(children: statusController.allReceiveList.toList()),
              )
            ],
          ),
        );
  }
}
