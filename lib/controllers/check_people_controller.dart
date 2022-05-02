import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/participate_controller.dart';
import 'package:universiting/controllers/room_info_controller.dart';
import 'package:universiting/models/profile_model.dart';
import 'package:universiting/models/select_member_model.dart';
import 'package:universiting/widgets/check_number_of_people_widget.dart';
import 'package:universiting/widgets/friend_to_go_with_widget.dart';
import 'package:universiting/widgets/room_manager_widget.dart';

class CheckPeopleController extends GetxController {
  static CheckPeopleController get to => Get.find();
  CheckPeopleController({required this.type, this.number});
  AddFriends type;
  int? number;
  int a = 2;
  final checkPeopleList = <Widget>[RoomManagerWithWidget()].obs;
  final backColors =
      <Color>[kLightGrey, kLightGrey, kLightGrey, kLightGrey].obs;
  final textColors =
      <Color>[kMainBlack, kMainBlack, kMainBlack, kMainBlack].obs;
  RxInt peopleNumber = 0.obs;
  void changeColor(int text) {
    switch (text) {
      case 2:
      case 3:
      case 4:
      case 5:
        peopleNumber.value = text;
        break;
    }
    for (int i = 0; i < 4; i++) {
      if (i == text - 2) {
        backColors[i] = kMainBlack;
        textColors[i] = kMainWhite;
      } else {
        backColors[i] = kLightGrey;
        textColors[i] = kMainBlack;
      }
    }
  }

  void selectPeople(int number) {
    checkPeopleList.value = [RoomManagerWithWidget()];
    switch (number) {
      case 1:
      case 2:
      case 3:
      case 4:
        print(number);
        break;
    }
    for (int i = 0; i < number - 1; i++) {
      checkPeopleList.add(FriendToGoWithWidget(
        text: number - 2,
        type: type,
        humanNum: i + 1,
      ));
      if (type == AddFriends.myRoom) {
        RoomInfoController.to.memberProfile.add(Profile(
            age: 0,
            gender: '',
            introduction: '',
            nickname: '',
            profileImage: '',
            userId: 0));
      } else {
        ParticipateController.to.memberProfile.add(Profile(
            age: 0,
            gender: '',
            introduction: '',
            nickname: '',
            profileImage: '',
            userId: 0));
      }
    }
    if (type == AddFriends.myRoom) {
      if (RoomInfoController.to.selectedMembers.length > number) {
        RoomInfoController.to.selectedMembers.removeLast();
        RoomInfoController.to.members.removeLast();
      }
    }
  }

  @override
  void onInit() {
    if (type == AddFriends.otherRoom) {
      selectPeople(number!);
      print(checkPeopleList);
    }
    super.onInit();
  }

  @override
  void onClose() {
    checkPeopleList.clear();
    super.onClose();
  }
}
