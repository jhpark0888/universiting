import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:universiting/api/room_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/models/my_room_model.dart';
import 'package:universiting/models/room_model.dart';
import 'package:universiting/widgets/profile_image_widget.dart';
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
  final room = <RoomWidget>[].obs;
  final profileImage = <ProfileImageWidget>[].obs;
  @override
  void onInit() async {
    managetabController = TabController(length: 2, vsync: this);
    // myRoomList.value = await getMyRoom();
    await getMyRoom().then((myRoomList) {
      chiefList.value = myRoomList.chiefList;
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
    await getMyRoom().then((myRoomList) {
      chiefList.value = myRoomList.chiefList;
      // memberList.value = myRoomList.memberList;
    });
    getRoom();
  }

  void getRoom() {
    room.clear();
    for (Room i in chiefList) {
      room.add(RoomWidget(
        room: i,
        hosts: getHostsList(i),
        isChief: true,
        roomType: ViewType.myRoom,
      ));
    }
    for (Room i in memberList) {
      room.add(RoomWidget(
          room: i,
          hosts: getHostsList(i),
          isChief: false,
          roomType: ViewType.myRoom));
    }
  }

  List<ProfileImageWidget> getHostsList(Room room) {
    switch (room.totalMember) {
      case 2:
      case 3:
      case 4:
        print(room);
        break;
    }
    profileImage.clear();
    for (int i = 0; i < room.hosts!.length; i++) {
      profileImage.add(ProfileImageWidget(
        host: room.hosts![i],
        type: ViewType.otherView,
      ));
    }
    return profileImage.toList();
  }
}