import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';

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
  TextEditingController yearController = TextEditingController();
TextEditingController monthController = TextEditingController();
TextEditingController dayController = TextEditingController();
  RxList<DateTime> datetime = <DateTime>[DateTime.now()].obs;
  RxList<Univ> allUnivList = <Univ>[].obs;
  RxList<String> univList = <String>[].obs;
  RxList<String> univSearchList = <String>[].obs;
  // RxList<Depart> allDepartList = <Depart>[].obs;
  // RxList<String> departList = <String>[].obs;
  // RxList<String> departSearchList = <String>[].obs;

  final uni = Univ(email: '', schoolname: '', id: 1).obs;

  RxString isgender = ''.obs;
  RxInt departId = 0.obs;
  RxInt schoolId = 0.obs;
  RxInt age = 0.obs;
  RxBool isUniv = false.obs;
  RxBool isDepart = false.obs;
  RxBool isname = false.obs;
  RxBool isage = false.obs;
  RxBool isPasswordCheck = false.obs;
  RxBool isEmail = false.obs;
  RxBool isEmailPress = false.obs;
  RxBool isSendEmail = false.obs;
  RxBool isEmailCheck = false.obs;
  @override
  void onInit() async {
    await getUniversityList();

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

    // departmentController.addListener(() {
    //   departSearchList.clear();
    //   for (String depart in departList) {
    //     if (departmentController.text != '') {
    //       if (depart.contains(departmentController.text)) {
    //         departSearchList.add(depart);
    //         checkdepartment();
    //       }
    //     }
    //   }
    // });

    // nameController.addListener(() {
    //   if (nameController.text.isNotEmpty) {
    //     isname.value = true;
    //   } else if (nameController.text.isEmpty) {
    //     isname.value = false;
    //   }
    // });

    // ageController.addListener(() {
    //   if (ageController.text.isNotEmpty) {
    //     isage.value = true;
    //   } else if (ageController.text.isEmpty) {
    //     isage.value = false;
    //   }
    // });

    emailController.addListener(() {
      if (emailController.text.isNotEmpty) {
        isEmail.value = true;
      } else if (emailController.text.isEmpty) {
        isEmail.value = false;
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
    isname(false);
    isPasswordCheck(false);
    isEmail(false);
    isEmailPress(false);
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

  // void checkdepartment() {
  //   if (departSearchList.contains(departmentController.text)) {
  //     isDepart(true);
  //   } else {
  //     isDepart(false);
  //   }
  // }

  void selectuniv(String univ) {
    for (Univ i in allUnivList) {
      if (i.schoolname == univ) {
        uni.value = i;
        schoolId.value = i.id;
      }
    }
  }

  // void getDepartId(String depart) {
  //   for (Depart i in allDepartList) {
  //     if (i.depName == depart) {
  //       departId.value = i.id;
  //       schoolId.value = i.schoolId;
  //     }
  //   }
  // }

  String checkAge() {
    age.value = DateTime.now().year - int.parse(yearController.text) + 1;
    if (age <= 22) {
      return ageContents[0];
    } else if (age <= 26) {
      return ageContents[1];
    } else {
      return ageContents[2];
    }
  }
}
