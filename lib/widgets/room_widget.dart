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
      this.joinmember,
      required this.hosts,
      required this.isChief,
      required this.roomType})
      : super(key: key);
  Room room;
  List<ProfileImageWidget>? joinmember;
  List<ProfileImageWidget> hosts;
  bool isChief;
  RoomType roomType;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (roomType != RoomType.statusReceiveView) {
              Get.to(() => RoomDetailView(
                    roomid: room.id.toString(),
                  ));
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: kLightGrey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(children: hosts),
                    const SizedBox(height: 12),
                    if (roomType != RoomType.statusReceiveView)
                      Text(room.title, style: kSubtitleStyle1),
                    if (roomType == RoomType.otherView)
                      const SizedBox(height: 12),
                    if (roomType != RoomType.otherView)
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
                          if (roomType != RoomType.otherView)
                          Text(room.university!)
                        ],
                      ),

                    if (roomType != RoomType.otherView)
                      const SizedBox(height: 12),
                    Row(
                      children: [
                        Text('평균 나이',
                            style: kBodyStyle2.copyWith(
                                color: kMainBlack.withOpacity(0.6))),
                        const SizedBox(width: 4),
                        Text(
                          room.avgAge.toString() + '세',
                          style: kSubtitleStyle3,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '·',
                          style: kBodyStyle2.copyWith(
                              color: kMainBlack.withOpacity(0.6)),
                        ),
                        const SizedBox(width: 4),
                        Text('성별',
                            style: kBodyStyle2.copyWith(
                                color: kMainBlack.withOpacity(0.6))),
                        const SizedBox(width: 4),
                        Text(room.gender!, style: kSubtitleStyle3)
                      ],
                    ),
                    if (roomType == RoomType.statusSendView)
                      const SizedBox(height: 16),
                    if (roomType == RoomType.statusSendView)
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: joinmember!),
                    if (roomType == RoomType.otherView)
                      const SizedBox(height: 12),
                    if (roomType == RoomType.otherView)
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
                                padding: EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                    color: kMainBlack.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(4)),
                                child: Center(
                                  child: Text('방장',
                                      style: kSmallBadgeStyle.copyWith(
                                          color: kMainWhite),
                                      textAlign: TextAlign.center),
                                ))
                            : SizedBox.shrink(),
                        if (roomType == RoomType.otherView)
                          StateManagementWidget(
                              state: room.type!
                                  ? StateManagement.roomActivated
                                  // : room.isModify != null
                                  //     ? room.isModify == 0
                                  //         ? StateManagement.waitingFriend
                                  //         : StateManagement.friendReject
                                      : StateManagement.waitingFriend)
                      ],
                    )
                  ]),
            ),
          ),
        ),
        const SizedBox(height: 20)
      ],
    );
  }
}
