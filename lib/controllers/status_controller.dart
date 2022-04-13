import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:universiting/Api/status_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/models/alarm_model.dart';
import 'package:universiting/models/host_model.dart';
import 'package:universiting/models/room_model.dart';
import 'package:universiting/widgets/alarm_widget.dart';
import 'package:universiting/widgets/profile_image_widget.dart';

import '../Api/status_api.dart';

class StatusController extends GetxController {
  static StatusController get to => Get.find();
  RefreshController receiveRefreshController = RefreshController();
  RefreshController sendRefreshController = RefreshController();
  final receiveList = <AlarmReceive>[].obs;
  final sendList = <AlarmSend>[].obs;
  final allReceiveList = <AlarmReceiveWidget>[].obs;
  final allSendList = <AlarmSendWidget>[].obs;
  final receiveHostprofileImage = <ProfileImageWidget>[].obs;
  final sendHostprofileImage = <ProfileImageWidget>[].obs;
  final sendJoinMemberprofileImage = <ProfileImageWidget>[].obs;
  @override
  void onInit() async {
    await getReceiveStatus().then((httpresponse) {
      if (httpresponse.isError == false) {
        receiveList(httpresponse.data);
      } else {}
    });
    await getSendStatus().then((httprespnse) {
      if (httprespnse.isError == false) {
        sendList(httprespnse.data);
      }
    });
    makeAllReceiveList();
    makeAllSendList();
    super.onInit();
  }

  void makeAllReceiveList() {
    allReceiveList.clear();
    for (var alarmreceive in receiveList) {
      receiveHostprofileImage.value =
          getHostsList(alarmreceive.content!, ViewType.statusReceiveView);
      allReceiveList.add(AlarmReceiveWidget(
          alarmreceive: alarmreceive, host: receiveHostprofileImage.toList()));
    }
  }

  void makeAllSendList() {
    allSendList.clear();
    for (var alarmSend in sendList) {
      sendHostprofileImage.value =
          getHostsList(alarmSend.room, ViewType.statusReceiveView);
      sendJoinMemberprofileImage.value =
          getJoinMemberList(alarmSend.joinmember, ViewType.statusSendView);
      allSendList.add(AlarmSendWidget(
        alarmSend: alarmSend,
        joinMember: sendJoinMemberprofileImage,
        host: sendHostprofileImage.toList(),
      ));
    }
  }

  void onrefreshReceive() async {
    await getReceiveStatus().then((httpresponse) {
      if (httpresponse.isError == false) {
        receiveList(httpresponse.data);
      } else {}
    });
    makeAllReceiveList();
    receiveRefreshController.refreshCompleted();
    print('리프레시 완료');
  }

  void onrefreshSend() async {
    await getSendStatus().then((httprespnse) {
      if (httprespnse.isError == false) {
        sendList(httprespnse.data);
      }
    });
    makeAllSendList();
    sendRefreshController.refreshCompleted();
    print('리프레시 완료');
  }

  List<ProfileImageWidget> getHostsList(Room room, ViewType type) {
    List<ProfileImageWidget> imageList = <ProfileImageWidget>[];
    if (room.hosts != null) {
      switch (room.totalMember) {
        case 2:
        case 3:
        case 4:
          print(room);
          break;
      }
      for (int i = 0; i < room.hosts!.length; i++) {
        imageList.add(ProfileImageWidget(
          host: room.hosts![i],
          type: type,
        ));
      }
      return imageList;
    }
    return imageList;
  }

  List<ProfileImageWidget> getJoinMemberList(List<Host> hosts, ViewType type) {
    List<ProfileImageWidget> imageList = <ProfileImageWidget>[];
    for (Host host in hosts) {
      imageList.add(ProfileImageWidget(
        host: host,
        type: type,
      ));
    }
    return imageList;
  }
}
