import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/check_people_controller.dart';
import 'package:universiting/controllers/room_info_controller.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/controllers/participate_controller.dart';
import 'package:universiting/controllers/profile_controller.dart';
import 'package:universiting/controllers/select_member_controller.dart';
import 'package:universiting/utils/global_variable.dart';
import 'package:universiting/widgets/appbar_widget.dart';
import 'package:universiting/widgets/participate_selected_name_widget.dart';
import 'package:universiting/widgets/empty_back_textfield_widget.dart';
import 'package:universiting/widgets/profile_image_widget.dart';

import '../widgets/background_textfield_widget.dart';

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
                '같이 갈 친구들 (${type == AddFriends.myRoom ? RoomInfoController.to.members.length + 1 : ParticipateController.to.members.length + 1} / ${text.toString()})',
                style: kSubtitleStyle2,
              ),
              const SizedBox(height: 12),
              if (type == AddFriends.myRoom)
                Row(
                  children: RoomInfoController.to.seletedMembers,
                ),
              if (type == AddFriends.otherRoom)
                Row(
                  children: ParticipateController.to.selectedMembers,
                ),
              const SizedBox(height: 12),
              BackgroundTextfieldWidget(
                controller: selectFriendController.nickNameController,
                hinttext: '친구 닉네임 검색',
              ),
              const SizedBox(height: 48),
              GestureDetector(
                  onTap: () {
                    print(type);
                    if (type == AddFriends.myRoom) {
                      if (!RoomInfoController.to.members.contains(
                          selectFriendController.seletedMember.value.userId)) {
                        if (text > RoomInfoController.to.members.length + 1) {
                          RoomInfoController.to.members.add(
                              selectFriendController
                                  .seletedMember.value.userId);
                          RoomInfoController.to.seletedMembers
                              .add(SelectedNameWidget(
                            selectMember:
                                selectFriendController.seletedMember.value,
                            roomManager: false,
                            type: AddFriends.myRoom,
                          ));
                          RoomInfoController.to.memberProfile[text - 2] =
                              selectFriendController.seletedMember.value;
                          print(selectFriendController
                              .seletedMember.value.nickname);
                          print(RoomInfoController.to.members);
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
                                  selectMember: selectFriendController
                                      .seletedMember.value,
                                  roomManager: false,
                                  type: AddFriends.otherRoom));

                          ParticipateController.to.memberProfile[text - 2] =
                              selectFriendController.seletedMember.value;
                        } else {
                          showCustomDialog('인원이 초과되었어요', 1200);
                        }
                      } else {
                        showCustomDialog('이미 등록되었어요', 1200);
                      }
                    }
                  },
                  child: Obx(
                      () => selectFriendController.seletedMember.value.age != 0
                          ? Row(
                              children: [
                                ProfileImageWidget(
                                  type: ViewType.otherView,
                                  width: 48,
                                  profile: selectFriendController
                                      .seletedMember.value,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  selectFriendController
                                      .seletedMember.value.nickname,
                                  style: kSubtitleStyle2,
                                ),Expanded(child: Container()),
                                type == AddFriends.myRoom
                                    ? RoomInfoController.to.seletedMembers
                                            .where((member) =>
                                                member.selectMember ==
                                                selectFriendController
                                                    .seletedMember.value)
                                            .toList()
                                            .isEmpty
                                        ? SvgPicture.asset(
                                            'assets/icons/check_nactive.svg')
                                        : SvgPicture.asset(
                                            'assets/icons/check_active.svg')
                                    : ParticipateController.to.selectedMembers
                                            .where((member) =>
                                                member.selectMember ==
                                                selectFriendController
                                                    .seletedMember.value)
                                            .toList()
                                            .isEmpty
                                        ? SvgPicture.asset(
                                            'assets/icons/check_nactive.svg')
                                        : SvgPicture.asset(
                                            'assets/icons/check_active.svg')
                              ],
                            )
                          : const SizedBox.shrink()))
              // Text(selectFriendController.seletedMember.value.nickname))
            ],
          ),
        ),
      ),
    );
  }
}
