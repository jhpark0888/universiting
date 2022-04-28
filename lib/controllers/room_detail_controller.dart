import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/api/room_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/app_controller.dart';
import 'package:universiting/models/host_model.dart';
import 'package:universiting/models/room_model.dart';
import 'package:universiting/widgets/room_person_widget.dart';

class RoomDetailController extends GetxController {
  static RoomDetailController get to => Get.find();
  RoomDetailController({required this.roomid});
  TextEditingController reportController = TextEditingController();
  Rx<Screenstate> screenstate = Screenstate.loading.obs;
  int currentPage = 0;
  PageController pageController = PageController(
    initialPage: 0,
  );
  Timer? timer;
  String roomid;
  final roomPersonList = <Widget>[].obs;
  final detailRoom = Room(
          id: 0,
          title: '',
          hosts: <Host>[],
          totalMember: 0,
          type: false,
          date: DateTime.now())
      .obs;
  @override
  void onInit() async {
    await getDetailRoom(roomid).then((httpresponse) {
      if (httpresponse.isError == false) {
        detailRoom(httpresponse.data);
        AppController.to.addPage();
        print(AppController.to.stackPage);
        screenstate(Screenstate.success);
        timerstart();
      } else {
        if (httpresponse.errorData!['statusCode'] == 59) {
          screenstate(Screenstate.network);
        } else {
          screenstate(Screenstate.error);
        }
      }
    });
    // makeRoomPersonList(detailRoom.value.hosts!.length);
    super.onInit();
  }

  @override
  void onClose() {
    AppController.to.deletePage();
    print(AppController.to.stackPage);
    if (timer != null) {
      timer!.cancel();
    }
    super.onClose();
  }

  void timerstart() {
    timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      currentPage++;

      pageController.animateToPage(
        currentPage,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  void makeRoomPersonList(int number) {
    for (int i = 0; i < number; i++) {
      roomPersonList
          .add(RoomPersonWidget(host: detailRoom.value.hosts![i], width: 50));
      roomPersonList.add(const SizedBox(height: 17));
    }

    roomPersonList.removeLast();
  }
}
