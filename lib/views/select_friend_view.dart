import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/create_room_controller.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/controllers/participate_controller.dart';
import 'package:universiting/controllers/profile_controller.dart';
import 'package:universiting/controllers/select_member_controller.dart';
import 'package:universiting/utils/global_variable.dart';
import 'package:universiting/widgets/appbar_widget.dart';
import 'package:universiting/widgets/participate_selected_name_widget.dart';
import 'package:universiting/widgets/textformfield_widget.dart';

class SelectFriendView extends StatelessWidget {
  SelectFriendView({Key? key, required this.text, required this.type})
      : super(key: key);
  SelectMemberController selectFriendController =
      Get.put(SelectMemberController());
  int text;
  AddFriends type;
  @override
  Widget build(BuildContext context) {
    print(selectFriendController.seletedMember);
    return Scaffold(
      appBar: AppBarWidget(
        title: '같이 갈 친구 선택',
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '같이 갈 친구들 (${type == AddFriends.myRoom ? CreateRoomController.to.members.length + 1 : ParticipateController.to.members.length + 1} / ${text.toString()})',
                style: kSubtitleStyle2,
              ),
              const SizedBox(height: 12),
              if (type == AddFriends.myRoom)
                Row(
                  children: CreateRoomController.to.seletedMembers,
                ),
              if (type == AddFriends.otherRoom)
                Row(
                  children: ParticipateController.to.selectedMembers,
                ),
              const SizedBox(height: 12),
              CustomTextFormField(
                controller: selectFriendController.nickNameController,
                hinttext: '친구 닉네임 검색',
              ),
              const SizedBox(height: 48),
              GestureDetector(
                  onTap: () {
                    if (type == AddFriends.myRoom) {
                      if (!CreateRoomController.to.members.contains(
                          selectFriendController.seletedMember.value.userId)) {
                        if (text > CreateRoomController.to.members.length + 1) {
                          CreateRoomController.to.members.add(
                              selectFriendController
                                  .seletedMember.value.userId);
                          CreateRoomController.to.seletedMembers.add(
                              SelectedNameWidget(
                                  name: selectFriendController
                                      .seletedMember.value.nickname));
                          print(selectFriendController
                              .seletedMember.value.nickname);
                          print(CreateRoomController.to.members);
                        } else {
                          showCustomDialog('인원이 초과되었어요', 1200);
                        }
                      } else {
                        showCustomDialog('이미 등록되었어요', 1200);
                      }
                    } else {
                      if (!ParticipateController.to.members.contains(
                          selectFriendController.seletedMember.value.userId)) {
                        if (text >
                            ParticipateController.to.members.length + 1) {
                          ParticipateController.to.members.add(
                              selectFriendController
                                  .seletedMember.value.userId);
                          ParticipateController.to.selectedMembers.add(
                              SelectedNameWidget(
                                  name: selectFriendController
                                      .seletedMember.value.nickname));
                        } else {
                          showCustomDialog('인원이 초과되었어요', 1200);
                        }
                      } else {
                        showCustomDialog('이미 등록되었어요', 1200);
                      }
                    }
                  },
                  child:
                      Text(selectFriendController.seletedMember.value.nickname))
            ],
          ),
        ),
      ),
    );
  }
}
