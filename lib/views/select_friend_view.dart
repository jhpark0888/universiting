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
import 'package:universiting/models/profile_model.dart';
import 'package:universiting/utils/global_variable.dart';
import 'package:universiting/widgets/appbar_widget.dart';
import 'package:universiting/widgets/new_person_widget.dart';
import 'package:universiting/widgets/selected_name_widget.dart';
import 'package:universiting/widgets/empty_back_textfield_widget.dart';
import 'package:universiting/widgets/profile_image_widget.dart';
import 'package:universiting/widgets/scroll_noneffect_widget.dart';
import 'package:universiting/widgets/white_textfield_widget.dart';

import '../widgets/background_textfield_widget.dart';

class SelectFriendView extends StatelessWidget {
  SelectFriendView(
      {Key? key,
      this.peoplenum,
      required this.type,
      required this.membersProfile})
      : super(key: key);
  late SelectMemberController selectmemberController =
      Get.put(SelectMemberController(membersProfile: membersProfile.value.obs));
  int? peoplenum;
  AddFriends type;
  RxList<Profile> membersProfile = <Profile>[].obs;
  @override
  Widget build(BuildContext context) {
    print(selectmemberController.seletedMember);
    return Scaffold(
      appBar: AppBarWidget(
        title: '함께 갈 친구',
        actions: [
          Obx(
            () => TextButton(
                onPressed: () {
                  if (type == AddFriends.myRoom) {
                    if (selectmemberController.membersProfile.length > 1) {
                      List<int> membersid = selectmemberController
                          .membersProfile
                          .map((profile) => profile.userId)
                          .toList();
                      membersid.removeAt(0);
                      RoomInfoController.to.members(membersid);

                      RoomInfoController.to.memberProfile(
                          selectmemberController.membersProfile.value);
                      Get.back();
                    } else {
                      showCustomDialog('방을 만들기 위해서 2명 이상이 필요해요', 1200);
                    }
                  } else {
                    if (selectmemberController.membersProfile.length ==
                        peoplenum) {
                      List<int> membersid = selectmemberController
                          .membersProfile
                          .map((profile) => profile.userId)
                          .toList();
                      membersid.removeAt(0);
                      ParticipateController.to.members(membersid);

                      ParticipateController.to.memberProfile(
                          selectmemberController.membersProfile.value);

                      Get.back();
                    } else {
                      showCustomDialog('인원수를 모두 채워주세요', 1200);
                    }
                  }
                },
                child: Text(
                  '완료',
                  style: kSubtitleStyle2.copyWith(
                      color: type == AddFriends.myRoom
                          ? selectmemberController.membersProfile.length > 1
                              ? kPrimary
                              : kMainBlack.withOpacity(0.4)
                          : selectmemberController.membersProfile.length ==
                                  peoplenum
                              ? kPrimary
                              : kMainBlack.withOpacity(0.4)),
                )),
          )
        ],
      ),
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                '함께 갈 친구들 ${type == AddFriends.myRoom ? '${selectmemberController.membersProfile.length}명 (최대 5명)' : '(${selectmemberController.membersProfile.length} / ${peoplenum.toString()})'}',
                style: k16Medium,
              ),
            ),
            SizedBox(
              height: 36,
              width: Get.width,
              child: ScrollNoneffectWidget(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return SelectedNameWidget(
                      type: type,
                      selectMember:
                          selectmemberController.membersProfile[index],
                      roomManager: index == 0 ? true : false,
                    );
                  },
                  itemCount: selectmemberController.membersProfile.length,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                            if (selectmemberController.membersProfile
                                .where((profile) =>
                                    profile.userId ==
                                    selectmemberController
                                        .seletedMember.value.userId)
                                .isEmpty) {
                              if (5 >
                                  selectmemberController
                                      .membersProfile.length) {
                                selectmemberController.membersProfile.add(
                                    selectmemberController.seletedMember.value);
                                selectmemberController.nickNameController
                                    .clear();
                              } else {
                                showCustomDialog('방 구성 최대 인원은 5명이에요', 1200);
                              }
                            } else {
                              showCustomDialog('이미 등록되었어요', 1200);
                            }
                          } else {
                            if (selectmemberController.membersProfile
                                .where((profile) =>
                                    profile.userId ==
                                    selectmemberController
                                        .seletedMember.value.userId)
                                .isEmpty) {
                              if (peoplenum! >
                                  selectmemberController
                                      .membersProfile.length) {
                                selectmemberController.membersProfile.add(
                                    selectmemberController.seletedMember.value);
                                selectmemberController.nickNameController
                                    .clear();
                              } else {
                                showCustomDialog('이미 인원이 다 찼어요', 1200);
                              }
                            } else {
                              showCustomDialog('이미 등록되었어요', 1200);
                            }
                          }
                        }
                      },
                      child: Obx(() => selectmemberController
                                  .searchtype.value ==
                              SearchType.success
                          ? NewPersonTileWidget(
                              profile:
                                  selectmemberController.seletedMember.value)
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
                                              color:
                                                  kMainBlack.withOpacity(0.4)),
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
          ],
        ),
      ),
    );
  }
}
