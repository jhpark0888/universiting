import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/api/room_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/check_people_controller.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/controllers/participate_controller.dart';
import 'package:universiting/controllers/profile_controller.dart';
import 'package:universiting/controllers/select_member_controller.dart';
import 'package:universiting/widgets/appbar_widget.dart';
import 'package:universiting/widgets/button_widget.dart';
import 'package:universiting/widgets/room_manager_widget.dart';

class ParticiapteView extends StatelessWidget {
  ParticiapteView({Key? key, required this.roomid, required this.peopleNumber})
      : super(key: key);
  ParticipateController participateController =
      Get.put(ParticipateController());

  String roomid;
  int peopleNumber;
  @override
  Widget build(BuildContext context) {
    CheckPeopleController checkPeopleController = Get.put(CheckPeopleController(
        type: AddFriends.otherRoom, number: peopleNumber));
    return Scaffold(
      appBar: AppBarWidget(title: '같이 갈 친구들'),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('같이 갈 친구들', style: kSubtitleStyle2),
              const SizedBox(height: 12),
              Row(
                children: checkPeopleController.checkPeopleList,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text('학교',
                      style: kBodyStyle2.copyWith(
                          color: kMainBlack.withOpacity(0.6))),
                  const SizedBox(width: 8),
                  Text(ProfileController.to.profile.value.university)
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text('평균 나이',
                      style: kBodyStyle2.copyWith(
                          color: kMainBlack.withOpacity(0.6))),
                  const SizedBox(width: 8),
                  Text(participateController.ageAvg.toString())
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text('성별',
                      style: kBodyStyle2.copyWith(
                          color: kMainBlack.withOpacity(0.6))),
                  const SizedBox(width: 8),
                  Text(participateController.gender.value)
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text('인원수',
                      style: kBodyStyle2.copyWith(
                          color: kMainBlack.withOpacity(0.6))),
                  const SizedBox(width: 8),
                  Text(
                      '${participateController.members.length + 1} / ${peopleNumber.toString()}')
                ],
              ),
              const SizedBox(height: 24),
              GestureDetector(
                  onTap: () {
                    if (peopleNumber ==
                        participateController.members.length + 1) {
                      roomJoin(roomid);
                    } else {
                      showCustomDialog('인원수를 채워주세요', 1200);
                    }
                  },
                  child: PrimaryButton(text: '참여 신청하기'))
            ],
          ),
        ),
      ),
    );
  }
}
