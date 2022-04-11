import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/alarm_list_controller.dart';
import 'package:universiting/widgets/appbar_widget.dart';

class AlarmListView extends StatelessWidget {
  AlarmListView({Key? key}) : super(key: key);
  AlarmListController alarmListController = Get.put(AlarmListController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: '알림'),
      body: Obx(
        () => SmartRefresher(
            enablePullDown: true,
            enablePullUp: alarmListController.canLoading.value ? true : false,
            controller: alarmListController.refreshController,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(children: alarmListController.alarmList.toList()),
              ),
            ),
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
            onRefresh: () {alarmListController.onRefresh();
            },
            footer: ClassicFooter(
              completeDuration: Duration.zero,
              loadingText: "",
              canLoadingText: "",
              idleText: "",
              idleIcon: Container(),
              noMoreIcon: Container(
                child: Text('as'),
              ),
              loadingIcon: Image.asset(
                'assets/icons/loading.gif',
                scale: 6,
              ),
              canLoadingIcon: Image.asset(
                'assets/icons/loading.gif',
                scale: 6,
              ),
            ),
            onLoading: alarmListController.onLoading),
      ),
    );
  }
}
