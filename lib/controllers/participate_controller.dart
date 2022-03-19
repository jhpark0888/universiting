import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/controllers/profile_controller.dart';
import 'package:universiting/widgets/participate_selected_name_widget.dart';

class ParticipateController extends GetxController{
  static ParticipateController get to => Get.find();
  final members = [].obs;
  final ageAvg = ProfileController.to.profile.value.age.obs;
  final gender = ProfileController.to.profile.value.gender.obs;
  final selectedMembers = [SelectedNameWidget(name: ProfileController.to.profile.value.nickname)].obs; 
}