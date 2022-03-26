import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/status_controller.dart';

class  StatusViewSendView extends StatelessWidget {
  StatusViewSendView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        controller: StatusController.to.sendRefreshController,
        header: const ClassicHeader(
            spacing: 0.0,
            height: 60,
            completeDuration: Duration(milliseconds: 600),
            textStyle: TextStyle(color: kMainBlack),
            refreshingText: '',
            releaseText: "",
            completeText: "",
            idleText: "",
            refreshingIcon: Text('당기는 중입니다.')), onRefresh: StatusController.to.onrefreshSend,
      child: Obx(
        () => SingleChildScrollView(
          child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: StatusController.to.allSendList.isEmpty ? [Text(
                              '아직 받은 신청이 없어요',
                              style: kSubtitleStyle2.copyWith(
                                  color: kMainBlack.withOpacity(0.38)),
                              textAlign: TextAlign.center,
                            )] : StatusController.to.allSendList,
                          ) 
                        )
                      ],
                    ),
        ),
      ),
    );
  }
}