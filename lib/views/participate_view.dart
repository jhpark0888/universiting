import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/api/room_api.dart';
import 'package:universiting/api/status_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/app_controller.dart';
import 'package:universiting/controllers/check_people_controller.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/controllers/participate_controller.dart';
import 'package:universiting/controllers/profile_controller.dart';
import 'package:universiting/controllers/select_member_controller.dart';
import 'package:universiting/controllers/status_controller.dart';
import 'package:universiting/controllers/status_room_tab_controller.dart';
import 'package:universiting/views/select_friend_view.dart';
import 'package:universiting/widgets/appbar_widget.dart';
import 'package:universiting/widgets/button_widget.dart';
import 'package:universiting/widgets/new_person_widget.dart';
import 'package:universiting/widgets/room_manager_widget.dart';
import 'package:universiting/widgets/shadow_textfield_widget.dart';

class ParticiapteView extends StatelessWidget {
  ParticiapteView({Key? key, required this.roomid, required this.peopleNumber})
      : super(key: key);
  ParticipateController participateController =
      Get.put(ParticipateController());

  String roomid;
  int peopleNumber;

  Widget participateinfo(String label, String content) {
    return Row(
      children: [
        Text(label,
            style: kBodyStyle2.copyWith(color: kMainBlack.withOpacity(0.4))),
        const SizedBox(width: 10),
        Text(
          content,
          style: kBodyStyle2,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // CheckPeopleController checkPeopleController = Get.put(CheckPeopleController(
    //     type: AddFriends.otherRoom, number: peopleNumber));
    return Scaffold(
      appBar: AppBarWidget(title: '함께 갈 친구들'),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(20.0),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  NewPersonTileWidget(
                    profile: ProfileController.to.profile.value,
                  ),
                  Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: participateController.memberProfile
                          .map((member) => NewPersonTileWidget(profile: member))
                          .toList(),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => SelectFriendView(
                          peoplenum: peopleNumber, type: AddFriends.otherRoom));
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: kMainWhite,
                            border: Border.all(width: 1),
                          ),
                          child: Icon(Icons.add),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Text(
                          '함께할 친구 초대하기',
                          style: kSubtitleStyle2,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  participateinfo(
                      '학교', ProfileController.to.profile.value.university!),
                  const SizedBox(height: 20),
                  participateinfo(
                      '평균 나이', participateController.ageAvg.toString()),
                  const SizedBox(height: 20),
                  participateinfo('성별', participateController.gender.value),
                  const SizedBox(height: 20),
                  participateinfo('인원수',
                      '${participateController.members.length + 1} / ${peopleNumber.toString()}'),
                  const SizedBox(height: 20),
                  ShadowTextfieldWidget(
                    controller: participateController.introController,
                    hintText: '해당 방에 보낼 간단한 소개 메세지를 적어보세요',
                    maxLines: 2,
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 42),
                  GestureDetector(
                      onTap: () {
                        if (peopleNumber ==
                            participateController.members.length + 1) {
                          showButtonDialog(
                              title: '참여 신청하시겠어요?',
                              content:
                                  '친구들이 함께 가기를 모두 수락하면 신청이 완료되며,\n내 신청은 신청 현황 탭에서 확인할 수 있어요',
                              leftFunction: () => Get.back(),
                              leftText: '닫기',
                              rightFunction: () {
                                roomJoin(roomid);
                              },
                              rightText: '신청하기');
                        } else {
                          showCustomDialog('인원수를 채워주세요', 1200);
                        }
                      },
                      child: PrimaryButton(text: '참여 신청하기')),
                  const SizedBox(height: 10),
                  Text(
                    '친구들이 모두 수락하면 이 방에 참여 신청이 완료돼요\n신청 현황 탭에서 내 신청을 확인할 수 있어요',
                    style: kSmallCaptionStyle.copyWith(
                        height: 1.5, color: kMainBlack.withOpacity(0.4)),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
