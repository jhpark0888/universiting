import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/api/room_api.dart';
import 'package:universiting/controllers/app_controller.dart';
import 'package:universiting/models/host_model.dart';
import 'package:universiting/models/room_model.dart';
import 'package:universiting/widgets/room_person_widget.dart';

class RoomDetailController extends GetxController {
  static RoomDetailController get to => Get.find();
  RoomDetailController({required this.roomid});
  TextEditingController reportController = TextEditingController();
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
    detailRoom.value = await getDetailRoom(roomid);
    makeRoomPersonList(detailRoom.value.hosts!.length);
    AppController.to.addPage();
    print(AppController.to.stackPage);
    super.onInit();
  }

  @override
  void onClose() {
    AppController.to.deletePage();
    print(AppController.to.stackPage);
    super.onClose();
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
