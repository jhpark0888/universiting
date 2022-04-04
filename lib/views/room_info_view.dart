import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/api/room_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/check_people_controller.dart';
import 'package:universiting/controllers/room_info_controller.dart';
import 'package:universiting/widgets/appbar_widget.dart';
import 'package:universiting/widgets/button_widget.dart';
import 'package:universiting/widgets/check_number_of_people_widget.dart';
import 'package:universiting/widgets/custom_button_widget.dart';
import 'package:universiting/widgets/friend_to_go_with_widget.dart';
import 'package:universiting/widgets/room_manager_widget.dart';
import 'package:universiting/widgets/empty_back_textfield_widget.dart';

import '../widgets/background_textfield_widget.dart';

class RoomInfoView extends StatelessWidget {
  RoomInfoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    RoomInfoController createRoomController =
        Get.put(RoomInfoController());
    return Scaffold(
      appBar: AppBarWidget(title: '방 만들기'),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
          child: SingleChildScrollView(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    '방 제목',
                    style: kSubtitleStyle2,
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 12),
                  BackgroundTextfieldWidget(
                    controller: createRoomController.roomTitleController,
                    hinttext: '방 제목을 적어주세요',
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    '총 인원 수',
                    style: kSubtitleStyle2,
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 12),
                  Row(children: createRoomController.checkNumberPeopleList),
                  const SizedBox(height: 24),
                  const Text(
                    '같이 갈 친구들',
                    style: kSubtitleStyle2,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: CheckPeopleController.to.checkPeopleList,
                  ),
                  const SizedBox(height: 24),
                  const Text('간단한 방 소개', style: kSubtitleStyle2),
                  const SizedBox(height: 12),
                  BackgroundTextfieldWidget(
                    controller: createRoomController.introController,
                    hinttext: '친구들의 특징이나 선호나는 약속 시간, 장소 등을 간략하게 적어보세요',
                    maxLine: 2,
                    height: Get.height / 8,
                  ),
                  const SizedBox(height: 24),

                  GestureDetector(
                          onTap: () {
                            makeRoom();
                            Get.back();
                          },
                          child: PrimaryButton(text: '방 만들기')),
                     
                  SizedBox(height: 12),
                  Text(
                    '만든 방은 내가 속한 학교의 방 리스트에 추가돼요',
                    style: kSmallCaptionStyle.copyWith(
                        color: kMainBlack.withOpacity(0.6)),
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
