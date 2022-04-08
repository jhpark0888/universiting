import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/api/room_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/profile_controller.dart';
import 'package:universiting/models/profile_model.dart';
import 'package:universiting/models/select_member_model.dart';
import 'package:universiting/widgets/participate_selected_name_widget.dart';

class SelectMemberController extends GetxController {
  TextEditingController nickNameController = TextEditingController();
  Rx<Profile> seletedMember = Profile(
          age: 0,
          gender: '',
          introduction: '',
          nickname: '',
          profileImage: '',
          userId: 0)
      .obs;
  RxString nickName = ''.obs;
  RxInt nicNameLength = 0.obs;
  Rx<SearchType> searchtype = SearchType.empty.obs;
  @override
  void onInit() {
    nickNameController.addListener(() {
      nicNameLength.value = nickNameController.text.length;
      nickName.value = nickNameController.text;
      if (nickName.value != '') {
        print(nicNameLength);
      }
    });
    debounce(nicNameLength, (callback) => SearchMember(),
        time: Duration(seconds: 1));
    super.onInit();
  }

  @override
  void onClose() {
    seletedMember = Profile(
            age: 0,
            gender: '',
            introduction: '',
            nickname: '',
            profileImage: '',
            userId: 0)
        .obs;
    super.onClose();
  }
}
