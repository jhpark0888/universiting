import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/api/room_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/check_people_controller.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/controllers/profile_controller.dart';
import 'package:universiting/controllers/room_info_controller.dart';
import 'package:universiting/views/select_friend_view.dart';
import 'package:universiting/widgets/appbar_widget.dart';
import 'package:universiting/widgets/button_widget.dart';
import 'package:universiting/widgets/check_number_of_people_widget.dart';
import 'package:universiting/widgets/custom_button_widget.dart';
import 'package:universiting/widgets/friend_to_go_with_widget.dart';
import 'package:universiting/widgets/new_person_widget.dart';
import 'package:universiting/widgets/room_manager_widget.dart';
import 'package:universiting/widgets/empty_back_textfield_widget.dart';
import 'package:universiting/widgets/room_person_widget.dart';
import 'package:universiting/widgets/room_profile_image_widget.dart';
import 'package:universiting/widgets/scroll_noneffect_widget.dart';
import 'package:universiting/widgets/white_textfield_widget.dart';

import '../widgets/background_textfield_widget.dart';

class RoomInfoView extends StatelessWidget {
  RoomInfoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    RoomInfoController createRoomController = Get.put(RoomInfoController());
    return KeyboardDismissOnTap(
      child: Scaffold(
        appBar: AppBarWidget(
          title: '방 만들기',
          leading: IconButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                Get.back();
              },
              icon: SvgPicture.asset(
                'assets/icons/close.svg',
                width: 16,
                height: 16,
              )),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 18,
                ),
                SizedBox(
                  height: 130,
                  width: Get.width,
                  child: Obx(
                    () => ScrollNoneffectWidget(
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        itemCount:
                            createRoomController.memberProfile.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          print(createRoomController
                              .memberProfile[0].profileImage);
                          return index == 0
                              ? GestureDetector(
                                  onTap: () {
                                    Get.to(() => SelectFriendView(
                                        type: AddFriends.myRoom));
                                  },
                                  child: Container(
                                    height: 130,
                                    width: 130,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: kCardColor.withOpacity(0.3)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  width: 2, color: kPrimary)),
                                          child: const Icon(
                                            Icons.add,
                                            color: kPrimary,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Text(
                                          '친구 초대하기',
                                          style: k16Medium.copyWith(
                                              color: kPrimary),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : RoomProfileImageWidget(
                                  profile: createRoomController
                                      .memberProfile[index - 1],
                                );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            width: 8,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 28,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '방 제목',
                        style: k16Medium,
                      ),
                      const SizedBox(height: 2),
                      EmptyBackTextfieldWidget(
                        textStyle: k16Light,
                        controller: createRoomController.roomTitleController,
                        hinttext: '이 방을 나타내는 특별한 제목을 적어주세요 (최대 30글자)',
                        hintstyle: k16Light.copyWith(
                          color: kMainBlack.withOpacity(0.4),
                          height: 1.5,
                        ),
                        hintMaxLines: 2,
                        textalign: TextAlign.start,
                        maxLength: 30,
                      ),
                      const SizedBox(height: 28),
                      const Text(
                        '방 소개',
                        style: k16Medium,
                      ),
                      const SizedBox(height: 2),
                      EmptyBackTextfieldWidget(
                        textStyle: k16Light,
                        controller: createRoomController.introController,
                        hinttext:
                            '처음 만나는 친구들을 위해 이 방에 대한 상세한 설명을 적어주세요 (최대 200글자)',
                        hintstyle: k16Light.copyWith(
                          color: kMainBlack.withOpacity(0.4),
                          height: 1.5,
                        ),
                        hintMaxLines: 2,
                        textalign: TextAlign.start,
                        maxLength: 200,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/mini_univ.svg',
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            ProfileController.to.profile.value.university!,
                            style: k16Medium,
                          )
                        ],
                      ),
                      const SizedBox(height: 12),
                      Obx(
                        () => RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: '평균 나이 ',
                                style: k16Medium.copyWith(
                                    color: kMainBlack.withOpacity(0.4))),
                            TextSpan(
                                text: createRoomController.ageAvg.toString(),
                                style: k16Medium),
                            TextSpan(
                                text: ' · 성별 ',
                                style: k16Medium.copyWith(
                                    color: kMainBlack.withOpacity(0.4))),
                            TextSpan(
                                text: createRoomController.gender.value,
                                style: k16Medium),
                            TextSpan(
                                text: ' · 인원 ',
                                style: k16Medium.copyWith(
                                    color: kMainBlack.withOpacity(0.4))),
                            TextSpan(
                                text: '${createRoomController.members.length}명',
                                style: k16Medium),
                          ]),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // const SizedBox(height: 12),
                      // Row(children: createRoomController.checkNumberPeopleList),
                      // const SizedBox(height: 24),
                      // const Text(
                      //   '같이 갈 친구들',
                      //   style: kSubtitleStyle1,
                      // ),
                      // const SizedBox(height: 12),
                      // Row(
                      //   children: CheckPeopleController.to.checkPeopleList,
                      // ),
                      const SizedBox(height: 10),
                      GestureDetector(
                          onTap: () {
                            if (createRoomController.memberProfile.length > 1) {
                              showButtonDialog(
                                  title: '방을 만드시겠어요?',
                                  content:
                                      '친구들이 초대를 모두 수락하면 방이 완성되며,\n내 방 탭에서 만든 방을 확인할 수 있어요',
                                  leftFunction: () => Get.back(),
                                  leftText: '닫기',
                                  rightFunction: () {
                                    makeRoom();
                                  },
                                  rightText: '방 만들기');
                            } else {
                              showCustomDialog('인원은 최소 2명 이상이어야 해요', 1200);
                            }
                          },
                          child: PrimaryButton(
                            text: '방 만들기',
                            isactive:
                                createRoomController.memberProfile.length > 1
                                    ? true.obs
                                    : false.obs,
                          )),
                      const SizedBox(height: 10),
                      Center(
                        child: Text(
                          '친구들이 모두 수락하면 지도에 방이 표시돼요\n관리 - 내 방 탭에서 방을 관리할 수 있어요',
                          style: kLargeCaptionStyle.copyWith(
                              color: kMainBlack.withOpacity(0.4)),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
