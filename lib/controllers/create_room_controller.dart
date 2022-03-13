import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/widgets/check_number_of_people_widget.dart';
import 'package:universiting/widgets/friend_to_go_with_widget.dart';

class CreateRoomController extends GetxController {
  TextEditingController roomTitleController = TextEditingController();
  TextEditingController introController = TextEditingController();
  final checkNumberPeopleList = <CheckNumberOfPeopleWidget>[].obs;
  final members = [].obs;
  @override
  void onInit() {
    super.onInit();
    for (int i = 2; i < 6; i++) {
      checkNumberPeopleList.add(CheckNumberOfPeopleWidget(text: i));
    }
  }
}
