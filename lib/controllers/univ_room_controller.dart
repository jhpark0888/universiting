import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/api/univ_room_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/models/room_model.dart';
import 'package:universiting/utils/global_variable.dart';
import 'package:universiting/widgets/profile_image_widget.dart';
import 'package:universiting/widgets/room_final_widget.dart';
import 'package:universiting/widgets/room_profile_image_widget.dart';
import 'package:universiting/widgets/room_widget.dart';

class UnivRoomController extends GetxController {
  static UnivRoomController get to => Get.find();
  RxList<Room> univRoom = <Room>[].obs;
  RxList<RoomFinalWidget> room = <RoomFinalWidget>[].obs;
  ScrollController scrollController = ScrollController(initialScrollOffset: 0);
  RxDouble changeHeight = 340.0.obs;
  Rx<Screenstate> screenstate = Screenstate.loading.obs;

  @override
  void onInit() async {
    scrollController.addListener(() {
      print(scrollController.offset);
    });
    await getUnivRoom().then((httpresponse) {
      if (httpresponse.isError == false) {
        univRoom.value = List<Room>.from(httpresponse.data);
        room.value = univRoom
            .map((element) => RoomFinalWidget(
                  room: element,
                  roomMember: getHostsList(element),
                  isChief: false,
                  roomType: ViewType.univRoom,
                ))
            .toList();
        screenstate(Screenstate.success);
      } else {
        errorSituation(httpresponse);
        screenstate(Screenstate.error);
      }
    });
    room.value = univRoom
        .map((element) => RoomFinalWidget(
              room: element,
              roomMember: getHostsList(element),
              isChief: false,
              roomType: ViewType.univRoom,
            ))
        .toList();
    print(room.length);
    super.onInit();
  }

  void refreshData() {
    univRoom.clear();
    getUnivRoom();
  }

  List<Widget> getHostsList(Room room) {
    List<Widget> profileImage = [];
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
        isReject: true,
      ));
    }
    // profileImage.insert(0, const SizedBox(width: 20));
    return profileImage.toList();
  }
}
