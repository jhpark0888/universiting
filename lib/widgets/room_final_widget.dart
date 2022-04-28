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
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Row(
              children: [
                ScrollNoneffectWidget(child: SizedBox(height: 150,width: Get.width,child: ListView(scrollDirection: Axis.horizontal,children: roomMember ?? hosts!))),
              ],
            ),
            const SizedBox(height: 18),
            if (roomType != ViewType.statusReceiveView)
              Padding(
                padding: const EdgeInsets.only(left : 20, right : 20),
                child: Text(room.title, style: kSubtitleStyle5.copyWith(height: 1.5)),
              ),
            if (roomType == ViewType.otherView) const SizedBox(height: 12),
            if (roomType != ViewType.otherView && roomType != ViewType.myRoom)
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
                  if (roomType != ViewType.otherView) Text(room.university!)
                ],
              ),
            if (roomType != ViewType.otherView) const SizedBox(height: 12),
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
            if (roomType == ViewType.statusSendView) const SizedBox(height: 16),
            if (roomType == ViewType.statusSendView)
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: joinmember!),
            if (roomType == ViewType.otherView || roomType == ViewType.myRoom)
              const SizedBox(height: 15),
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
                    // getBoxColor(room.date!),
                    // const SizedBox(width: 8),
                    Text(calculateDate(room.date!),
                        style: kSubtitleStyle2.copyWith(
                            color: kMainBlack.withOpacity(0.4)))
                  ],
                ),
              ),
            if (roomType == ViewType.myRoom)
              Row(
                children: [
                  Text('인원',
                      style: kSmallCaptionStyle.copyWith(
                          color: kMainBlack.withOpacity(0.6))),
                  const SizedBox(width: 4),
                  Text('${room.totalMember} : ${room.totalMember}',
                      style: kSmallCaptionStyle),
                  const Spacer(),
                  StateManagementWidget(
                      state: room.type!
                          ? StateManagement.roomActivated
                          // : room.isModify != null
                          //     ? room.isModify == 0
                          //         ? StateManagement.waitingFriend
                          //         : StateManagement.friendReject
                          : StateManagement.waitingFriend)
                ],
              ),
            if (isChief) const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isChief
                    ? Text(
                        '회원님이 방장으로 신청 현황을 관리할 수 있어요',
                        style: kSmallCaptionStyle.copyWith(color: kPrimary),
                      )
                    : SizedBox.shrink(),
                // if (roomType == ViewType.otherView)
                //   StateManagementWidget(
                //       state: room.type!
                //           ? StateManagement.roomActivated
                //           // : room.isModify != null
                //           //     ? room.isModify == 0
                //           //         ? StateManagement.waitingFriend
                //           //         : StateManagement.friendReject
                //               : StateManagement.waitingFriend)
              ],
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Divider(thickness: 2.5, color: kMainBlack.withOpacity(0.1),),
            )
          ]),
        ),
        const SizedBox(height: 20)
      ],
    );
  }
}
