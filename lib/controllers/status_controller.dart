import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:universiting/api/status_api.dart';
import 'package:universiting/models/alarm_model.dart';
import 'package:universiting/widgets/alarm_widget.dart';

class StatusController extends GetxController{
  static StatusController get to => Get.find();
  RefreshController refreshController = RefreshController();
  final receiveList = <Alarm>[].obs;
  final allReceiveList = <AlarmWidget>[].obs;
  @override
  void onInit() async{
    receiveList.value = await getReciveStatus();
    makeAllReceiveList();
    print(allReceiveList.length);
    super.onInit();
  }
  void makeAllReceiveList(){
    allReceiveList.clear();
    for(var alarm in receiveList){
      allReceiveList.add(AlarmWidget(alarm: alarm));
    }
  }
  void onrefresh()async{
    receiveList.value = await getReciveStatus();
    makeAllReceiveList();
    print(allReceiveList.length);
    refreshController.refreshCompleted();
    print('리프레시 완료');
  }
}