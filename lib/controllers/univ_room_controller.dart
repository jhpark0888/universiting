import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:universiting/api/univ_room_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/admob_controller.dart';
import 'package:universiting/models/room_model.dart';
import 'package:universiting/utils/global_variable.dart';
import 'package:universiting/widgets/profile_image_widget.dart';
import 'package:universiting/widgets/room_final_widget.dart';
import 'package:universiting/widgets/room_profile_image_widget.dart';
import 'package:universiting/widgets/room_widget.dart';

class UnivRoomController extends GetxController {
  static UnivRoomController get to => Get.find();
  RxList<Room> univRoom = <Room>[].obs;
  RxList<Widget> room = <Widget>[].obs;
  RxList<Widget> adRoom = <Widget>[].obs;
  ScrollController scrollController = ScrollController(initialScrollOffset: 0);
  RxDouble changeHeight = 340.0.obs;
  Rx<Screenstate> screenstate = Screenstate.loading.obs;

  @override
  void onInit() async {
    // scrollController.addListener(() {print(scrollController.offset); });
    await getUnivRoom().then((httpresponse) {
      if (httpresponse.isError == false) {
        univRoom.value = List<Room>.from(httpresponse.data);

        room.addAll(univRoom
            .map((element) => RoomFinalWidget(
                  room: element,
                  roomMember: getHostsList(element),
                  isChief: false,
                  roomType: ViewType.univRoom,
                ))
            .toList());

        adRoom.value = List<Widget>.from(getAdList(room));

        screenstate(Screenstate.success);
      } else {
        errorSituation(httpresponse);
        screenstate(Screenstate.error);
      }
    });

    super.onInit();
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

  List<dynamic> getAdList(List<dynamic> room) {
    List<dynamic> list = room;
    if (room.length > 3) {
      for (int a = 1; a < room.length; a++) {
        if (a % 3 == 0) {
          list.insert(
            a - 1,
            Container(
              // padding: EdgeInsets.only(left: 20, right: 20),
                width: Get.width,
                height: 40,
                decoration: const BoxDecoration(color: Colors.transparent),
                child: AdWidget(ad: AdmobController.to.getBanner()..load())),
          );
        }
      }
    }
    return room;
  }
}
