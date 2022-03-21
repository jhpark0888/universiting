import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:universiting/api/room_api.dart';
import 'package:universiting/models/my_room_model.dart';
import 'package:universiting/models/room_model.dart';
import 'package:universiting/widgets/profile_image_widget.dart';
import 'package:universiting/widgets/room_widget.dart';

class MyRoomController extends GetxController {
  static MyRoomController get to => Get.find();
  RefreshController refreshController = RefreshController();
  // final myRoomList = MyRoom(chiefList: [], memberList: []).obs;
  final chiefList = [].obs;
  final memberList = [].obs;
  final room = <RoomWidget>[].obs;
  final profileImage = <ProfileImageWidget>[].obs;
  @override
  void onInit() async {
    // myRoomList.value = await getMyRoom();
    await getMyRoom().then((myRoomList) {
      chiefList.value = myRoomList.chiefList;
      memberList.value = myRoomList.memberList;
    });
    getRoom();
    super.onInit();
  }

  void onRefresh() async {
   await getMyRoom().then((myRoomList) {
      chiefList.value = myRoomList.chiefList;
      memberList.value = myRoomList.memberList;
    });
    getRoom();
    refreshController.refreshCompleted();
    print('리프레시 완료');
  }

  void getRoom() {
    room.clear();
    for(Room i in chiefList){
      room.add(RoomWidget(room: i, hosts: getHostsList(i), isChief: true,));
    }
    for(Room i in memberList){
      room.add(RoomWidget(room: i, hosts: getHostsList(i), isChief: false,));
    }
  }

  List<ProfileImageWidget> getHostsList(Room room){
    switch(room.totalMember){
      case 2:
      case 3:
      case 4:
      print(room);
      break;
    }
    profileImage.clear();
    for(int i = 0; i < room.hosts.length;i ++){
      profileImage.add(ProfileImageWidget(host: room.hosts[i],));
    }
    return profileImage.toList();
  }
}
