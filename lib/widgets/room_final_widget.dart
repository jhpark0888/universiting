import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/map_controller.dart';
import 'package:universiting/controllers/univ_room_controller.dart';
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
    return GestureDetector(
        onTap: () {
          print(MapController.to.isDetailClick);
          print(roomType);
          if (roomType == ViewType.univRoom) {
            if (MapController.to.isDetailClick.value == true) {
              Get.to(
                  () => RoomDetailView(
                        roomid: room.id.toString(),
                      ),
                  opaque: false);
            }else{
              UnivRoomController.to.changeHeight.value = Get.height;
              MapController.to.isDetailClick(true);
            }
          } else if (roomType != ViewType.statusReceiveView) {
            Get.to(
                () => RoomDetailView(
                      roomid: room.id.toString(),
                    ),
                opaque: false);
          }
        },
        behavior: HitTestBehavior.translucent,
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          ScrollNoneffectWidget(
              child: SizedBox(
                  height: 130,
                  width: Get.width,
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        roomMember != null ? roomMember!.length : hosts!.length,
                    itemBuilder: (context, index) {
                      return roomMember != null
                          ? roomMember![index]
                          : hosts![index];
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 8,
                      );
                    },
                  ))),
          Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 18),
                    if (roomType != ViewType.statusReceiveView)
                      Text(room.title,
                          style: kSubtitleStyle5.copyWith(height: 1.5)),
                    if (roomType == ViewType.otherView)
                      const SizedBox(height: 12),
                    if (roomType != ViewType.otherView &&
                        roomType != ViewType.myRoom)
                      Row(
                        children: [
                          Text(
                            '학교',
                            style: kBodyStyle2.copyWith(
                                color: kMainBlack.withOpacity(0.6)),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          if (roomType != ViewType.otherView)
                            Text(room.university!)
                        ],
                      ),
                    if (roomType != ViewType.otherView)
                      const SizedBox(height: 12),
                    Row(
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
                    if (roomType == ViewType.statusSendView)
                      const SizedBox(height: 16),
                    if (roomType == ViewType.statusSendView)
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: joinmember!),
                    if (roomType == ViewType.otherView ||
                        roomType == ViewType.myRoom)
                      const SizedBox(height: 12),
                    if (roomType == ViewType.otherView)
                      Row(
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
                    SizedBox(
                      height: 18,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Divider(
                        thickness: 1.5,
                        color: kMainBlack.withOpacity(0.05),
                      ),
                    )
                  ]))
        ]));
  }
}
