import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/controllers/create_room_controller.dart';
import 'package:universiting/controllers/select_friend_controller.dart';
import 'package:universiting/utils/global_variable.dart';
import 'package:universiting/widgets/appbar_widget.dart';
import 'package:universiting/widgets/textformfield_widget.dart';

class SelectMemberView extends StatelessWidget {
  SelectMemberView({Key? key}) : super(key: key);
  SelectMemberController selectFriendController =
      Get.put(SelectMemberController());
  CreateRoomController createRoomController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: '함께 할 친구'),
      body: Obx(
        () => Column(
          children: [
            CustomTextFormField(
              controller: selectFriendController.nickNameController,
              hinttext: '친구 닉네임 검색',
            ),
            const SizedBox(height: 48),
            GestureDetector(
                onTap: () {
                  if(!createRoomController.members.contains(selectFriendController.member.value.userId)){
                  createRoomController.members
                      .add(selectFriendController.member.value.userId);
                  Get.back();
                  }else{
                    showCustomDialog('이미 등록되었어요', 1200);
                  }
                },
                child: Text(selectFriendController.member.value.nickname))
          ],
        ),
      ),
    );
  }
}
