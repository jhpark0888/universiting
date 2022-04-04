import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/app_controller.dart';
import 'package:universiting/controllers/profile_controller.dart';
import 'package:universiting/models/profile_model.dart';
import 'package:universiting/models/select_member_model.dart';
import 'package:universiting/widgets/participate_selected_name_widget.dart';

class ParticipateController extends GetxController{
  static ParticipateController get to => Get.find();
  final members = [].obs;
  final memberProfile = <Profile>[].obs;
  final ageAvg = ProfileController.to.profile.value.age.obs;
  final gender = ProfileController.to.profile.value.gender.obs;
  final selectedMembers = [SelectedNameWidget(selectMember : ProfileController.to.profile.value, roomManager: true,type: AddFriends.otherRoom)].obs; 

  @override
  void onInit() {
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
}