import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:universiting/api/alarm_api.dart';
import 'package:universiting/controllers/app_controller.dart';
import 'package:universiting/models/alarm_model.dart';
import 'package:universiting/widgets/alarm_widget.dart';

class AlarmListController extends GetxController{
  static AlarmListController get to => Get.find();
  final alarmReceiveList = <AlarmReceive>[].obs;
  RefreshController refreshController = RefreshController();
  RxList<AlarmReceiveWidget> alarmList = <AlarmReceiveWidget>[].obs;
  RxBool canLoading = true.obs;
  @override
  void onInit() async{
    AppController.to.addPage();
    getAlarms();
    super.onInit();
  }
  @override
  void onClose() {
    AppController.to.deletePage();
    super.onClose();
  }
  void getAlarms()async{
    alarmReceiveList.value = await getAlarmList(0);
    mappingAlarmList();
  }

  void mappingAlarmList(){
    alarmList.clear();
    for(int i=0; i < alarmReceiveList.length; i++){
      alarmList.add(AlarmReceiveWidget(alarmreceive: alarmReceiveList[i]));
    }
  }

  void onRefresh()async{
    getAlarms();
    refreshController.refreshCompleted();
  }

  void onLoading()async{

    alarmReceiveList.value = await getAlarmList(alarmReceiveList.last.id);
    if(alarmReceiveList.isEmpty){
      canLoading(false);
    } else{
      canLoading(true);
    }
    mappingAlarmList();
    
    refreshController.loadComplete();
  }
}