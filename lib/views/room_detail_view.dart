import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/api/room_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/controllers/my_room_controller.dart';
import 'package:universiting/controllers/room_detail_controller.dart';
import 'package:universiting/utils/global_variable.dart';
import 'package:universiting/views/participate_view.dart';
import 'package:universiting/views/room_info_view.dart';
import 'package:universiting/widgets/appbar_widget.dart';
import 'package:universiting/widgets/button_widget.dart';
import 'package:universiting/widgets/custom_button_widget.dart';
import 'package:universiting/widgets/room_person_widget.dart';

class RoomDetailView extends StatelessWidget {
  RoomDetailView({Key? key, required this.roomid}) : super(key: key);
  String roomid;

  @override
  Widget build(BuildContext context) {
    RoomDetailController roomDetailController =
        Get.put(RoomDetailController(roomid: roomid), tag: '$roomid번 방');
    return Obx(
      () => Scaffold(
        appBar: AppBarWidget(
          title: roomDetailController.detailRoom.value.title,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () {
                  if (roomDetailController.detailRoom.value.isJoin == null &&
                      roomDetailController.detailRoom.value.isCreater == null) {
                    showCustomModalPopup(context, value1: '이 방 신고하기',
                        func1: () {
                      Get.back();
                      showRoomDialog(
                          controller: roomDetailController.reportController,
                          roomid: roomid,
                          moretype: MoreType.report);
                    }, textStyle: kSubtitleStyle3.copyWith(color: kErrorColor));
                  } else {
                    showCustomModalPopup(context, value1: '이 방 나가기', func1: () {
                      Get.back();
                      showRoomDialog(
                          controller: roomDetailController.reportController,
                          roomid: roomid,
                          moretype: MoreType.delete);
                    }, textStyle: kSubtitleStyle3.copyWith(color: kErrorColor));
                  }
                },
                child: Icon(
                  Icons.more_horiz,
                  color: kMainBlack,
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    const Text('방 소개', style: kSubtitleStyle5),
                    const Spacer(
                      flex: 1,
                    ),
                    getBoxColor(roomDetailController.detailRoom.value.date!),
                    const SizedBox(width: 8),
                    Text(
                        calculateDate(
                            roomDetailController.detailRoom.value.date!),
                        style: kSmallCaptionStyle.copyWith(
                            color: kMainBlack.withOpacity(0.4)))
                  ],
                ),
                const SizedBox(height: 10),
                Text(roomDetailController.detailRoom.value.title,
                    style: kBodyStyle1),
                const SizedBox(height: 30),
                Text(
                    '구성원 ${roomDetailController.detailRoom.value.totalMember}명',
                    style: kSubtitleStyle5),
                const SizedBox(height: 17),
                Column(children: roomDetailController.roomPersonList),
                const SizedBox(height: 35),
                if (roomDetailController.detailRoom.value.isJoin == null &&
                    roomDetailController.detailRoom.value.isCreater == null)
                  CustomButtonWidget(
                    buttonTitle: '이 방에 함께 갈 친구들 초대하기',
                    buttonState: ButtonState.primary,
                    onTap: () {
                      Get.to(() => ParticiapteView(
                            roomid: roomid,
                            peopleNumber: roomDetailController
                                .detailRoom.value.totalMember!,
                          ));
                    },
                  ),
                if (roomDetailController.detailRoom.value.isJoin == null &&
                    roomDetailController.detailRoom.value.isCreater == null)
                  const SizedBox(height: 12),
                if (roomDetailController.detailRoom.value.isJoin == null &&
                    roomDetailController.detailRoom.value.isCreater == null)
                  Center(
                    child: Text(
                      '함께 갈 친구들을 초대하고,\n 친구들이 모두 수락하면 이 방에 참여 신청이 완료돼요.',
                      style: kSmallCaptionStyle.copyWith(
                          color: kMainBlack.withOpacity(0.4), height: 1.5),
                      textAlign: TextAlign.center,
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
