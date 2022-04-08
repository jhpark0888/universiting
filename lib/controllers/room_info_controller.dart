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

import '../widgets/participate_selected_name_widget.dart';

class RoomInfoController extends GetxController {
  static RoomInfoController get to => Get.find();
  TextEditingController roomTitleController = TextEditingController();
  TextEditingController introController = TextEditingController();
  // final checkNumberPeopleList = <CheckNumberOfPeopleWidget>[].obs;
  final seletedMembers = <SelectedNameWidget>[
    SelectedNameWidget(
        selectMember: ProfileController.to.profile.value,
        roomManager: true,
        type: AddFriends.myRoom)
  ].obs;
  final RxList<NewPersonTileWidget> allmembertile = <NewPersonTileWidget>[].obs;
  final members = <int>[].obs;
  final memberProfile = <Profile>[].obs;
  @override
  void onInit() {
    AppController.to.addPage();
    print(AppController.to.stackPage);
    allmembertile.add(NewPersonTileWidget(
      profile: ProfileController.to.profile.value,
    ));
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
    print('삭제되었습니다.');
    super.onClose();
  }
}