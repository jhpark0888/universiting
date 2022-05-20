import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/api/profile_api.dart';
import 'package:universiting/controllers/home_controller.dart';
import 'package:universiting/models/profile_model.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();
  TextEditingController nameController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController introController = TextEditingController();
  final isEdit = false.obs;
  final profile = Profile(
          age: 0,
          department: '0',
          gender: '',
          introduction: '',
          nickname: '',
          profileImage: '',
          university: '',
          userId: 0)
      .obs;
  final statusBarHeight = 0.0.obs;
  @override
  void onInit() async {
    await getMyProfile();
    nameController.text = profile.value.nickname;
    departmentController.text =
        (profile.value.department! != '-' ? profile.value.department : '')!;
    introController.text = profile.value.introduction;
    statusBarHeight.value = MediaQuery.of(Get.context!).padding.top;
    print(profile);
    super.onInit();
  }

  @override
  void onClose() {
    nameController.text = '';
    departmentController.text = '';
    introController.text = '';
  }
}
