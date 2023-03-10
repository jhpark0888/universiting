import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/app_controller.dart';
import 'package:universiting/controllers/profile_controller.dart';
import 'package:universiting/models/profile_model.dart';
import 'package:universiting/models/select_member_model.dart';
import 'package:universiting/widgets/check_number_of_people_widget.dart';
import 'package:universiting/widgets/friend_to_go_with_widget.dart';
import 'package:universiting/widgets/new_person_widget.dart';

import '../widgets/selected_name_widget.dart';

class RoomInfoController extends GetxController {
  RoomInfoController(
      {required this.memberProfile,
      required this.roomtitle,
      required this.intro});
  static RoomInfoController get to => Get.find();
  TextEditingController roomTitleController = TextEditingController();
  TextEditingController introController = TextEditingController();

  // final checkNumberPeopleList = <CheckNumberOfPeopleWidget>[].obs;
  // final selectedMembers = <SelectedNameWidget>[
  //   SelectedNameWidget(
  //       selectMember: ProfileController.to.profile.value,
  //       roomManager: true,
  //       type: AddFriends.myRoom)
  // ].obs;
  final members = <int>[].obs;
  RxList<Profile> memberProfile =
      <Profile>[ProfileController.to.profile.value].obs;

  RxString roomtitle = ''.obs;
  RxString intro = ''.obs;
  // RxDouble ageAvg =
  //     double.parse(ProfileController.to.profile.value.age.toString()).obs;

  // int agesum = ProfileController.to.profile.value.age;
  // final gender = ProfileController.to.profile.value.gender.obs;
  @override
  void onInit() {
    AppController.to.addPage();
    print(AppController.to.stackPage);
    roomTitleController.text = roomtitle.value;
    introController.text = intro.value;

    roomTitleController.addListener(() {
      roomtitle(roomTitleController.text);
    });

    introController.addListener(() {
      intro(introController.text);
    });
    super.onInit();
    // for (int i = 2; i < 6; i++) {
    //   checkNumberPeopleList.add(CheckNumberOfPeopleWidget(text: i));
    // }
  }

  @override
  void onClose() {
    AppController.to.deletePage();
    print(AppController.to.stackPage);
    members.clear();
    print('?????????????????????.');
    super.onClose();
  }
}
