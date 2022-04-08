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
import 'package:universiting/widgets/new_person_widget.dart';
import 'package:universiting/widgets/participate_selected_name_widget.dart';
import 'package:universiting/widgets/empty_back_textfield_widget.dart';
import 'package:universiting/widgets/profile_image_widget.dart';
import 'package:universiting/widgets/white_textfield_widget.dart';

import '../widgets/background_textfield_widget.dart';

class SelectFriendView extends StatelessWidget {
  SelectFriendView({Key? key, this.peoplenum, required this.type})
      : super(key: key);
  SelectMemberController selectmemberController =
      Get.put(SelectMemberController());
  int? peoplenum;
  AddFriends type;
  @override
  Widget build(BuildContext context) {
    print(selectmemberController.seletedMember);
    return Scaffold(
      appBar: AppBarWidget(
        title: '함께 갈 친구 선택',
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '함께 갈 친구들 ${type == AddFriends.myRoom ? '${RoomInfoController.to.members.length + 1}명' : '(${ParticipateController.to.members.length + 1} / ${peoplenum.toString()})'}',
                style: kSubtitleStyle2,
              ),
              const SizedBox(height: 20),
              Row(
                  children: type == AddFriends.myRoom
                      ? RoomInfoController.to.seletedMembers
                      : ParticipateController.to.selectedMembers),
              const SizedBox(height: 20),
              WhiteTextfieldWidget(
                controller: selectmemberController.nickNameController,
                hinttext: '같은 학교 친구의 닉네임을 입력해주세요',
                prefixicon: Icon(
                  Icons.search,
                  color: kMainBlack.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                  onTap: () {
                    print(type);
                    if (selectmemberController.searchtype.value ==
                        SearchType.success) {
                      if (type == AddFriends.myRoom) {
                        if (!RoomInfoController.to.members.contains(
                            selectmemberController
                                .seletedMember.value.userId)) {
                          if (5 > RoomInfoController.to.members.length + 1) {
                            RoomInfoController.to.members.add(
                                selectmemberController
                                    .seletedMember.value.userId);
                            RoomInfoController.to.seletedMembers
                                .add(SelectedNameWidget(
                              selectMember:
                                  selectmemberController.seletedMember.value,
                              roomManager: false,
                              type: AddFriends.myRoom,
                            ));
                            RoomInfoController.to.memberProfile.add(
                                selectmemberController.seletedMember.value);
                            print(selectmemberController
                                .seletedMember.value.nickname);
                            print(RoomInfoController.to.members);
                          } else {
                            showCustomDialog('최대 인원 5명이 모두 찼어요', 1200);
                          }
                        } else {
                          showCustomDialog('이미 등록되었어요', 1200);
                        }
                      } else {
                        if (!ParticipateController.to.members.contains(
                            selectmemberController
                                .seletedMember.value.userId)) {
                          if (peoplenum! >
                              ParticipateController.to.members.length + 1) {
                            ParticipateController.to.members.add(
                                selectmemberController
                                    .seletedMember.value.userId);

                            ParticipateController.to.selectedMembers.add(
                                SelectedNameWidget(
                                    selectMember: selectmemberController
                                        .seletedMember.value,
                                    roomManager: false,
                                    type: AddFriends.otherRoom));

                            ParticipateController.to.memberProfile.add(
                                selectmemberController.seletedMember.value);
                          } else {
                            showCustomDialog('인원이 초과되었어요', 1200);
                          }
                        } else {
                          showCustomDialog('이미 등록되었어요', 1200);
                        }
                      }
                    }
                  },
                  child: Obx(() => selectmemberController.searchtype.value ==
                          SearchType.success
                      ? NewPersonTileWidget(
                          profile: selectmemberController.seletedMember.value)
                      : selectmemberController.searchtype.value ==
                              SearchType.empty
                          ? selectmemberController
                                  .nickNameController.text.isNotEmpty
                              ? Center(
                                  child: RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                      text: selectmemberController
                                          .nickNameController.text,
                                      style: kSubtitleStyle4,
                                    ),
                                    TextSpan(
                                      text: ' (이)라는 친구가 같은 학교에 없어요',
                                      style: kSubtitleStyle4.copyWith(
                                          color: kMainBlack.withOpacity(0.4)),
                                    )
                                  ])),
                                )
                              : const SizedBox.shrink()
                          : selectmemberController.searchtype.value ==
                                  SearchType.loading
                              ? Center(
                                  child: Image.asset(
                                    'assets/icons/loading.gif',
                                    scale: 15,
                                  ),
                                )
                              : const SizedBox.shrink()))
              // Text(selectmemberController.seletedMember.value.nickname))
            ],
          ),
        ),
      ),
    );
  }
}
