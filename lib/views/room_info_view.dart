import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
import 'package:universiting/widgets/white_textfield_widget.dart';

import '../widgets/background_textfield_widget.dart';

class RoomInfoView extends StatelessWidget {
  RoomInfoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    RoomInfoController createRoomController = Get.put(RoomInfoController());
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
                    style: kSubtitleStyle1,
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 10),
                  WhiteTextfieldWidget(
                    controller: createRoomController.roomTitleController,
                    hinttext: '다른 학교 친구들이 관심있어 할 매력있는 방 제목을 입력해보세요 (최대 20글자)',
                    maxLine: 2,
                    maxlenght: 20,
                    height: 2.1,
                  ),
                  const SizedBox(height: 20),
                  const Text('방 소개', style: kSubtitleStyle1),
                  const SizedBox(height: 10),
                  WhiteTextfieldWidget(
                    controller: createRoomController.introController,
                    hinttext: '이 방 구성원의 특별한 점을 소개해 보세요 (최대 50글자)',
                    maxLine: 2,
                    maxlenght: 50,
                    height: 2.1,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    '인원 ${createRoomController.seletedMembers.length} 명',
                    style: kSubtitleStyle1,
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 17),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: createRoomController.allmembertile.value,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => SelectFriendView(type: AddFriends.myRoom));
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.add_circle_outline,
                          size: 50,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          '함께할 친구 초대하기',
                          style: kSubtitleStyle2,
                        ),
                      ],
                    ),
                  ),
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
                        if (createRoomController.allmembertile.length > 1) {
                          makeRoom();
                          Get.back();
                        } else {
                          showCustomDialog('인원은 최소 2명 이상이어야 해요', 1200);
                        }
                      },
                      child: PrimaryButton(text: '방 만들기')),
                  const SizedBox(height: 10),
                  Text(
                    '함께할 친구들이 모두 수락하면 방이 우리 학교 방 목록에 올라가요\n내 방 탭에서 내가 만든 방을 확인할 수 있어요',
                    style: kSmallCaptionStyle.copyWith(
                        color: kMainBlack.withOpacity(0.4)),
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
