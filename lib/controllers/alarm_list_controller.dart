import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:universiting/api/alarm_api.dart';
import 'package:universiting/models/alarm_model.dart';
import 'package:universiting/widgets/alarm_widget.dart';

class AlarmListController extends GetxController{
  final alarmReceiveList = <AlarmReceive>[].obs;
  RefreshController refreshController = RefreshController();
  RxList<Widget> alarmList = <Widget>[].obs;
  @override
  void onInit() async{
    alarmReceiveList.value = await getAlarmList(0);
    mappingAlarmList();
    super.onInit();
  }

  void mappingAlarmList(){
    for(int i=0; i < alarmReceiveList.length; i++){
      alarmList.add(AlarmReceiveWidget(alarmreceive: alarmReceiveList[i]));
      alarmList.add(const SizedBox(height: 10));
    }
  }
}