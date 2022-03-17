import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/api/univ_room_api.dart';
import 'package:universiting/models/room_model.dart';
import 'package:universiting/widgets/profile_image_widget.dart';
import 'package:universiting/widgets/room_widget.dart';
class UnivRoomController extends GetxController{
  UnivRoomController get to =>Get.find();
  RxList<Room> univRoom = <Room>[].obs;
  RxList<RoomWidget> room = <RoomWidget>[].obs;
  RxList<ProfileImageWidget> profileImage = <ProfileImageWidget>[].obs;
  @override
  void onInit() async{
    await getUnivRoom();
    room.value = univRoom.map((element) => RoomWidget(room: element, hosts: getHostsList(element),)).toList();
    print(room.length);
    super.onInit();
  }

  void refreshData(){
    univRoom.clear();
    getUnivRoom();
  }

  List<ProfileImageWidget> getHostsList(Room e){
    switch(e.totalMember){
      case 2:
      case 3:
      case 4:
      print(e);
      break;
    }
    profileImage.clear();
    for(int i = 0; i < e.totalMember;i ++){
      profileImage.add(ProfileImageWidget());
    }
    return profileImage.toList();
  }
}