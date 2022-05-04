import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:universiting/api/room_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/models/my_room_model.dart';
import 'package:universiting/models/room_model.dart';
import 'package:universiting/widgets/myroom_widget.dart';
import 'package:universiting/widgets/profile_image_widget.dart';
import 'package:universiting/widgets/room_final_widget.dart';
import 'package:universiting/widgets/room_profile_image_widget.dart';
import 'package:universiting/widgets/room_widget.dart';

class ManagementController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static ManagementController get to => Get.find();

  late TabController managetabController;

  RefreshController myroomrefreshController = RefreshController();
  RefreshController requestrefreshController = RefreshController();
  // final myRoomList = MyRoom(chiefList: [], memberList: []).obs;
  final chiefList = <Room>[].obs;
  final memberList = <Room>[].obs;
  final room = <MyRoomWidget>[].obs;
  final profileImage = <RoomProfileImageWidget>[].obs;
  @override
  void onInit() async {
    managetabController = TabController(length: 2, vsync: this);
    // myRoomList.value = await getMyRoom();
    await getMyRoom(0).then((httpresponse) {
      if (httpresponse.isError == false) {
        chiefList((httpresponse.data as MyRoom).chiefList);
      }
      // memberList.value = myRoomList.memberList;
    });
    getRoom();
    super.onInit();
  }

  void onRefresh() async {
    getRoomList();
    myroomrefreshController.refreshCompleted();
    print('리프레시 완료');
  }

  void getRoomList() async {
    await getMyRoom(chiefList.isEmpty ? 0 : chiefList.first.id!)
        .then((httpresponse) {
      if (httpresponse.isError == false) {
        chiefList((httpresponse.data as MyRoom).chiefList);
      }
      // memberList.value = myRoomList.memberList;
    });
    getRoom();
  }

  void getRoom() {
    room.clear();
    for (Room i in chiefList) {
      room.add(MyRoomWidget(
        room: i,
        roomMember: getHostsList(i),
        isChief: true,
      ));
    }
    for (Room i in memberList) {
      room.add(MyRoomWidget(
        room: i,
        roomMember: getHostsList(i),
        isChief: false,
      ));
    }
  }

  List<RoomProfileImageWidget> getHostsList(Room room) {
    switch (room.totalMember) {
      case 2:
      case 3:
      case 4:
        print(room);
        break;
    }
    profileImage.clear();
    for (int i = 0; i < room.hosts!.length; i++) {
      profileImage.add(RoomProfileImageWidget(
        host: room.hosts![i],
        isname: false,
      ));
    }
    return profileImage.toList();
  }
}
