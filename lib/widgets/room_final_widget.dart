import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/models/room_model.dart';
import 'package:universiting/utils/global_variable.dart';
import 'package:universiting/views/room_detail_view.dart';
import 'package:universiting/widgets/profile_image_widget.dart';
import 'package:universiting/widgets/room_profile_image_widget.dart';
import 'package:universiting/widgets/scroll_noneffect_widget.dart';
import 'package:universiting/widgets/state_management_widget.dart';

class RoomFinalWidget extends StatelessWidget {
  RoomFinalWidget(
      {Key? key,
      required this.room,
      this.joinmember,
      this.roomMember,
      this.hosts,
      required this.isChief,
      required this.roomType})
      : super(key: key);
  Room room;
  List<Widget>? roomMember;
  List<ProfileImageWidget>? joinmember;
  List<ProfileImageWidget>? hosts;
  bool isChief;
  ViewType roomType;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (roomType != ViewType.statusReceiveView) {
              Get.to(() => RoomDetailView(
                    roomid: room.id.toString(),
                  ));
            } else {
              print(hosts);
            }
          },
          child:
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Row(
                children: [
                  ScrollNoneffectWidget(
                      child: Container(
                          height: 130,
                          width: Get.width,
                          child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: roomMember ?? hosts!))),
                ],
            ),
            const SizedBox(height: 18),
            if (roomType != ViewType.statusReceiveView)
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                      room.title,
                      style: kSubtitleStyle5.copyWith(height: 1.5)),
                ),
            if (roomType == ViewType.otherView) const SizedBox(height: 12),
            
            Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    Text('평균 나이',
                        style: kSubtitleStyle2.copyWith(
                            color: kMainBlack.withOpacity(0.6))),
                    const SizedBox(width: 4),
                    Text(
                      room.avgAge.toString() + '세',
                      style: kSubtitleStyle2,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '·',
                      style: kSubtitleStyle2.copyWith(
                          color: kMainBlack.withOpacity(0.6)),
                    ),
                    const SizedBox(width: 4),
                    Text('성별',
                        style: kSubtitleStyle2.copyWith(
                            color: kMainBlack.withOpacity(0.6))),
                    const SizedBox(width: 4),
                    Text(room.gender!, style: kSubtitleStyle2),
                    const SizedBox(width: 4),
                    Text(
                      '·',
                      style: kSubtitleStyle2.copyWith(
                          color: kMainBlack.withOpacity(0.6)),
                    ),
                    const SizedBox(width: 4),
                    Text('인원',
                        style: kSubtitleStyle2.copyWith(
                            color: kMainBlack.withOpacity(0.6))),
                    const SizedBox(width: 4),
                    Text('${room.totalMember} : ${room.totalMember}',
                        style: kSubtitleStyle2),
                  ],
                ),
            ),
            SizedBox(height: 12),
            if (roomType == ViewType.otherView)
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      Text('조회수',
                          style: kSubtitleStyle2.copyWith(
                              color: kMainBlack.withOpacity(0.6))),
                      const SizedBox(width: 4),
                      Text('${room.views}',
                          style: kSubtitleStyle2.copyWith(
                              color: kMainBlack.withOpacity(0.6))),
                      const Spacer(),
                      Text(calculateDate(room.date!),
                          style: kSubtitleStyle2.copyWith(
                              color: kMainBlack.withOpacity(0.4)))
                    ],
                  ),
                ),
                SizedBox(height: 18,),
            Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Divider(
                  thickness: 1.5,
                  color: kMainBlack.withOpacity(0.05),
                ),
            )
          ]),
              ),
        ),
      ],
    );
  }
}
