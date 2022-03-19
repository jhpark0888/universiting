import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/api/room_api.dart';
import 'package:universiting/models/host_model.dart';
import 'package:universiting/models/room_model.dart';
import 'package:universiting/widgets/room_person_widget.dart';

class RoomDetailController extends GetxController{
  static RoomDetailController get to => Get.find();
  RoomDetailController({required this.roomid});
  String roomid;
  final roomPersonList = <Widget>[].obs;
  final detailRoom = Room(id: 0, title: '', hosts: <Host>[], totalMember: 0, type: false).obs; 
  @override
  void onInit() async{
    detailRoom.value = await getDetailRoom(roomid);
    makeRoomPersonList(detailRoom.value.hosts.length);
    super.onInit();
  }

  void makeRoomPersonList(int number){
    for(int i = 0; i < number; i ++){
      roomPersonList.add(RoomPersonWidget(host: detailRoom.value.hosts[i],));
      roomPersonList.add(SizedBox(height: 8));
    }
  }
}