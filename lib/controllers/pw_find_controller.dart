import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/utils/check_validator.dart';

import '../api/signup_api.dart';
import '../models/signup_model.dart';

class PwController extends GetxController {
  static PwController get to => Get.find();

  TextEditingController emailController = TextEditingController();
  TextEditingController originpwController = TextEditingController();
  TextEditingController newpwController = TextEditingController();
  TextEditingController newpwCheckController = TextEditingController();

  RxBool isPasswordCheck = false.obs;
  RxBool isOriginPasswordlength = false.obs;
  RxBool isPasswordlength = false.obs;
  RxBool isPasswordchecklength = false.obs;

  Rx<EmailCheckState> emailcheckstate = EmailCheckState.empty.obs;
  @override
  void onInit() async {
    originpwController.addListener(() {
      if (originpwController.text.length >= 6) {
        isOriginPasswordlength.value = true;
      } else {
        isOriginPasswordlength.value = false;
      }
    });

    newpwController.addListener(() {
      if (newpwController.text.length >= 6) {
        isPasswordlength.value = true;
      } else {
        isPasswordlength.value = false;
      }
    });

    newpwCheckController.addListener(() {
      if (newpwCheckController.text.length >= 6) {
        isPasswordchecklength.value = true;
      } else {
        isPasswordchecklength.value = false;
      }
    });

    emailController.addListener(() {
      if (CheckValidate().validateEmail(emailController.text) == null) {
        emailcheckstate(EmailCheckState.fill);
      } else {
        emailcheckstate(EmailCheckState.empty);
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    isPasswordCheck(false);

    super.onClose();
  }
}
