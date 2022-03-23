import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:universiting/api/status_api.dart';
import 'package:universiting/models/alarm_model.dart';
import 'package:universiting/models/room_model.dart';
import 'package:universiting/widgets/alarm_widget.dart';
import 'package:universiting/widgets/profile_image_widget.dart';

class StatusController extends GetxController{
  static StatusController get to => Get.find();
  RefreshController refreshController = RefreshController();
  final receiveList = <Alarm>[].obs;
  final allReceiveList = <AlarmWidget>[].obs;
  final profileImage = <ProfileImageWidget>[].obs;
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
      profileImage.value = getHostsList(alarm.content);
    }
  }
  void onrefresh()async{
    receiveList.value = await getReciveStatus();
    makeAllReceiveList();
    print(allReceiveList.length);
    refreshController.refreshCompleted();
    print('리프레시 완료');
  }

  List<ProfileImageWidget> getHostsList(Room room){
    if(room.hosts != null){
    switch(room.totalMember){
      case 2:
      case 3:
      case 4:
      print(room);
      break;
    }
    profileImage.clear();
    for(int i = 0; i < room.hosts!.length;i ++){
      profileImage.add(ProfileImageWidget(host: room.hosts![i],));
    }
    return profileImage.toList();
  }
  return profileImage.toList();
  }
}