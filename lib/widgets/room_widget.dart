import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/models/room_model.dart';
import 'package:universiting/views/room_detail_view.dart';
import 'package:universiting/widgets/profile_image_widget.dart';
import 'package:universiting/widgets/state_management_widget.dart';

class RoomWidget extends StatelessWidget {
  RoomWidget(
      {Key? key,
      required this.room,
      required this.hosts,
      required this.isChief})
      : super(key: key);
  Room room;
  List<ProfileImageWidget> hosts;
  bool isChief;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Get.to(() => RoomDetailView(
                  roomid: room.id.toString(),
                ));
          },
          child: Container(
            height: Get.width / 1.6,
            width: double.infinity,
            decoration: BoxDecoration(
                color: kLightGrey, borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(children: hosts),
                    const SizedBox(height: 12),
                    Text(room.title, style: kSubtitleStyle2),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text('평균 나이',
                            style: kBodyStyle2.copyWith(
                                color: kMainBlack.withOpacity(0.6))),
                        const SizedBox(width: 4),
                        Text(
                          room.avgAge.toString(),
                          style: kSubtitleStyle3,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          '·',
                          style: kInActiveButtonStyle,
                        ),
                        const SizedBox(width: 4),
                        Text('성별',
                            style: kBodyStyle2.copyWith(
                                color: kMainBlack.withOpacity(0.6))),
                        const SizedBox(width: 4),
                        Text(room.gender!, style: kSubtitleStyle3)
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text('인원수',
                            style: kBodyStyle2.copyWith(
                                color: kMainBlack.withOpacity(0.6))),
                        const SizedBox(width: 4),
                        Text('${room.totalMember} : ${room.totalMember}',
                            style: kSubtitleStyle3)
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        isChief
                            ? Container(
                                height: Get.width / 21,
                                width: Get.width / 13,
                                decoration: BoxDecoration(
                                    color: kMainBlack.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(4)),
                                child: Center(
                                  child: Text('방장',
                                      style: kSmallBadgeStyle.copyWith(
                                          color: kMainWhite),
                                      textAlign: TextAlign.center),
                                ))
                            : Container(),
                        StateManagementWidget(state: room.type ? StateManagement.roomActivated : StateManagement.waitingFriend)
                      ],
                    )
                  ]),
            ),
          ),
        ),
        const SizedBox(height: 16)
      ],
    );
  }
}
