import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/api/room_api.dart';
import 'package:universiting/api/status_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/app_controller.dart';
import 'package:universiting/controllers/check_people_controller.dart';
import 'package:universiting/controllers/management_controller.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/controllers/myroomrequest_controller.dart';
import 'package:universiting/controllers/participate_controller.dart';
import 'package:universiting/controllers/profile_controller.dart';
import 'package:universiting/controllers/select_member_controller.dart';
import 'package:universiting/controllers/status_controller.dart';
import 'package:universiting/controllers/status_room_tab_controller.dart';
import 'package:universiting/utils/global_variable.dart';
import 'package:universiting/views/select_friend_view.dart';
import 'package:universiting/widgets/appbar_widget.dart';
import 'package:universiting/widgets/button_widget.dart';
import 'package:universiting/widgets/empty_back_textfield_widget.dart';
import 'package:universiting/widgets/loading_widget.dart';
import 'package:universiting/widgets/new_person_widget.dart';
import 'package:universiting/widgets/room_manager_widget.dart';
import 'package:universiting/widgets/scroll_noneffect_widget.dart';
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

  String getavgage() {
    int agesum = 0;
    double avgage = 0;
    for (var profile in participateController.memberProfile) {
      agesum += profile.age;
    }
    avgage = agesum / participateController.memberProfile.length;
    return avgage.toStringAsFixed(1);
  }

  String getgender() {
    String gender = ProfileController.to.profile.value.gender;
    for (var profile in participateController.memberProfile) {
      if (gender != profile.gender) {
        gender = '혼성';
      }
    }
    return gender;
  }

  @override
  Widget build(BuildContext context) {
    // CheckPeopleController checkPeopleController = Get.put(CheckPeopleController(
    //     type: AddFriends.otherRoom, number: peopleNumber));
    return Scaffold(
      appBar: AppBarWidget(title: '신청하기'),
      body: Obx(
        () => GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ScrollNoneffectWidget(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: participateController.memberProfile
                            .map((member) =>
                                NewPersonTileWidget(profile: member))
                            .toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => SelectFriendView(
                              peoplenum: peopleNumber,
                              type: AddFriends.otherRoom,
                              membersProfile:
                                  participateController.memberProfile,
                            ));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(
                            () => participateController.memberProfile.length ==
                                    peopleNumber
                                ? Container()
                                : SvgPicture.asset(
                                    'assets/icons/circle_add.svg',
                                    color: kPrimary,
                                  ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Obx(
                            () => Text(
                              participateController.memberProfile.length ==
                                      peopleNumber
                                  ? '함께 갈 친구 수정하기'
                                  : '함께 갈 ${(peopleNumber - 1).toString()}명의 친구 초대하기',
                              style: k16Medium.copyWith(color: kPrimary),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    const Text(
                      '신청 메세지',
                      style: k16Normal,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    EmptyBackTextfieldWidget(
                      textStyle: k16Normal.copyWith(height: 1.5),
                      controller: participateController.introController,
                      hinttext: '상대방이 관심있어 할 친구들만의 특별한 점을 입력해보세요.(최대 200글자)',
                      hintstyle: k16Normal.copyWith(
                        color: kMainBlack.withOpacity(0.4),
                        height: 1.5,
                      ),
                      hintMaxLines: 2,
                      textalign: TextAlign.start,
                      maxLength: 200,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
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
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: '평균 나이 ',
                            style: k16Medium.copyWith(
                                color: kMainBlack.withOpacity(0.4))),
                        TextSpan(text: getavgage(), style: k16Medium),
                        TextSpan(
                            text: ' · 성별 ',
                            style: k16Medium.copyWith(
                                color: kMainBlack.withOpacity(0.4))),
                        TextSpan(text: getgender(), style: k16Medium),
                        TextSpan(
                            text: ' · 인원 ',
                            style: k16Medium.copyWith(
                                color: kMainBlack.withOpacity(0.4))),
                        TextSpan(
                            text:
                                '${participateController.memberProfile.length} : ${peopleNumber.toString()}',
                            style: k16Medium),
                      ]),
                    ),
                    const SizedBox(height: 24),
                    Obx(
                      () => GestureDetector(
                          onTap: () {
                            if (peopleNumber !=
                                participateController.memberProfile.length) {
                              showCustomDialog('친구들 인원에 맞게 초대해 주세요', 1200);
                            } else if (participateController.intro.value
                                    .trim() ==
                                '') {
                              showCustomDialog('신청 메세지를 작성해 주세요', 1200);
                            } else {
                              showButtonDialog(
                                  title: '참여 신청하시겠어요?',
                                  content:
                                      '친구들이 함께 가기를 모두 수락하면 \n신청이 완료되며,\n신청은 관리 - 신청 현황 탭에서 확인할 수 있어요',
                                  leftFunction: () => Get.back(),
                                  leftText: '닫기',
                                  rightFunction: () async {
                                    Get.to(() => const LoadingWidget(),
                                        opaque: false);
                                    await roomJoin(roomid).then((httpresponse) {
                                      Get.back();
                                      if (httpresponse.isError == false) {
                                        getbacks(3);
                                        ManagementController.to
                                            .getrequestlist(0);
                                        AppController.to.changePageIndex(1);
                                        ManagementController
                                            .to.managetabController.index = 1;
                                      } else {
                                        errorSituation(httpresponse);
                                      }
                                    });
                                  },
                                  rightText: '신청하기');
                            }
                          },
                          child: PrimaryButton(
                            text: '참여 신청하기',
                            isactive: (peopleNumber ==
                                        participateController
                                            .memberProfile.length &&
                                    participateController.intro.value.trim() !=
                                        '')
                                .obs,
                          )),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '친구들이 모두 수락하면 이 방에 참여 신청이 완료돼요\n관리 - 신청 현황 탭에서 내 신청을 확인할 수 있어요',
                      style: kLargeCaptionStyle.copyWith(
                          height: 1.5, color: kMainBlack.withOpacity(0.4)),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
