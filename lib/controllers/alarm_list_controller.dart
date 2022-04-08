import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/api/alarm_api.dart';

class AlarmListController extends GetxController{
  @override
  void onInit() {
    getAlarmList(0);
    super.onInit();
  }
}