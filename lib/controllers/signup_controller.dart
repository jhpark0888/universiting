import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/signup_api.dart';
import '../models/signup_model.dart';

class SignupController extends GetxController {
  static SignupController get to => Get.find();

  TextEditingController departmentController = TextEditingController();
  TextEditingController universityController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordCheckController = TextEditingController();

  RxList<DateTime> datetime = <DateTime>[DateTime.now()].obs;
  RxList<Univ> allUnivList = <Univ>[].obs;
  RxList<String> univList = <String>[].obs;
  RxList<String> univSearchList = <String>[].obs;
  RxList<Depart> allDepartList = <Depart>[].obs;
  RxList<String> departList = <String>['산업경영공학과'].obs;
  RxList<String> departSearchList = <String>[].obs;

  RxString univLink = ''.obs;
  RxString gender = ''.obs;
  RxInt departId = 0.obs;
  RxInt schoolId = 0.obs;
  RxBool isUniv = false.obs;
  RxBool isDepart = false.obs;
  RxBool isEmailCheck = false.obs;
  @override
  void onInit() async {
    try {
      await getUniversityList();
    } catch (e) {
      print(e);
    }

    universityController.addListener(() {
      univSearchList.clear();
      for (String univ in univList) {
        if (universityController.text != "") {
          if (univ.contains(universityController.text)) {
            univSearchList.add(univ);
            checkuniversity();
          }
        }
      }
    });

    departmentController.addListener(() {
      departSearchList.clear();
      for (String depart in departList) {
        if (departmentController.text != '') {
          if (depart.contains(departmentController.text)) {
            departSearchList.add(depart);
            checkdepartment();
          }
        }
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    universityController.clear();
    departmentController.clear();
    isUniv(false);
    isDepart(false);
    gender.value = '';
    isEmailCheck(false);
    super.onClose();
  }

  void checkuniversity() {
    if (univSearchList.contains(universityController.text)) {
      isUniv(true);
    } else {
      isUniv(false);
    }
  }

  void checkdepartment() {
    if (departSearchList.contains(departmentController.text)) {
      isDepart(true);
    } else {
      isDepart(false);
    }
  }

  void getlink(String univ) {
    for (Univ i in allUnivList) {
      if (i.school == univ) {
        univLink.value = '@${i.link}';
      }
    }
  }

  void getDepartId(String depart) {
    for (Depart i in allDepartList) {
      if (i.depName == depart) {
        departId.value = i.id;
        schoolId.value = i.schoolId;
      }
    }
  }
}
