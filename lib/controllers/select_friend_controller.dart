import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/api/room_api.dart';
import 'package:universiting/models/select_member_model.dart';

class SelectMemberController extends GetxController{
  TextEditingController nickNameController = TextEditingController();
  Rx<SelectMember> member = SelectMember(userId: 0, nickname: '', age: 0, gender: 'M').obs;
  RxString nickName = ''.obs;
  RxInt nicNameLength = 0.obs;
  @override
  void onInit(){
    nickNameController.addListener(() { 
      nickName.value = nickNameController.text;
      if(nickName.value.isNotEmpty)
      nicNameLength++;
      print(nicNameLength);
    });
    debounce(nicNameLength, (callback) => SearchMember(), time: Duration(seconds: 2));
    super.onInit();
  }
}