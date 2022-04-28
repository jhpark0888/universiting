import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/api/univ_room_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/models/room_model.dart';
import 'package:universiting/widgets/profile_image_widget.dart';
import 'package:universiting/widgets/room_final_widget.dart';
import 'package:universiting/widgets/room_profile_image_widget.dart';
import 'package:universiting/widgets/room_widget.dart';

class UnivRoomController extends GetxController {
  static UnivRoomController get to => Get.find();
  RxList<Room> univRoom = <Room>[].obs;
  RxList<RoomFinalWidget> room = <RoomFinalWidget>[].obs;
  RxList<RoomProfileImageWidget> profileImage = <RoomProfileImageWidget>[].obs;
  RxDouble changeHeight = 340.0.obs;
  @override
  void onInit() async {
    await getUnivRoom();
    room.value = univRoom
        .map((element) => RoomFinalWidget(
              room: element,
              roomMember: getHostsList(element),
              isChief: false,
              roomType: ViewType.otherView,
            ))
        .toList();
    print(room.length);
    super.onInit();
  }

  void refreshData() {
    univRoom.clear();
    getUnivRoom();
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
      profileImage.add(RoomProfileImageWidget(host: room.hosts![i]));
    }
    return profileImage.toList();
  }
}
