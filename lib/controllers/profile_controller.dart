import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/api/profile_api.dart';
import 'package:universiting/controllers/home_controller.dart';
import 'package:universiting/models/profile_model.dart';

class ProfileController extends GetxController{
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController introController = TextEditingController();
  
  final profile = Profile(age: 0, department: '0', gender: '', introduction: '', nickname: '', profileImage: '', university: '', userId: 0).obs;
  
  @override
  void onInit()async{
    await getMyProfile();
    nameController.text = profile.value.nickname;
    ageController.text = profile.value.age.toString();
    introController.text = profile.value.introduction;
    print(profile);
    super.onInit();
  }

  @override
  void onClose(){
    nameController.text = '';
    ageController.text = '';
    introController.text = '';
  }
}