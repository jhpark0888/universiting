import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/widgets/check_number_of_people_widget.dart';
import 'package:universiting/widgets/friend_to_go_with_widget.dart';

class CheckPeopleController extends GetxController {
  static CheckPeopleController get to => Get.find();
  final checkPeopleList = <FriendToGoWithWidget>[].obs;
  final backColors =
      <Color>[kLightGrey, kLightGrey, kLightGrey, kLightGrey].obs;
  final textColors =
      <Color>[kMainBlack, kMainBlack, kMainBlack, kMainBlack].obs;
  RxInt peopleNumber = 0.obs;
  void changeColor(int text) {
    checkPeopleList.clear();
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
    for(int i = 0; i < text - 1; i++){
      checkPeopleList.add(FriendToGoWithWidget(text: i + 1,));
    }
  }
  void selectPeople(int text) {
    switch (text) {
      case 1:
      case 2:
      case 3:
      case 4:
      print(text);
      break;
    }
  }
}
