import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/models/room_model.dart';
import 'package:universiting/utils/global_variable.dart';
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
          child: Container(
            decoration: BoxDecoration(
                color: kBackgroundWhite,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                      color: const Color(0x000000).withOpacity(0.1),
                      blurRadius: 3,
                      spreadRadius: 0,
                      offset: const Offset(0.0, 1.0))
                ]),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(children: hosts),
                    const SizedBox(height: 11),
                    if (roomType != ViewType.statusReceiveView)
                      Text(room.title, style: kBodyStyle1),
                    if (roomType == ViewType.otherView)
                      const SizedBox(height: 15),
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
                          if (roomType != ViewType.otherView)
                            Text(room.university!)
                        ],
                      ),

                    if (roomType != ViewType.otherView)
                      const SizedBox(height: 12),
                    Row(
                      children: [
                        Text('평균 나이',
                            style: kSmallCaptionStyle.copyWith(
                                color: kMainBlack.withOpacity(0.6))),
                        const SizedBox(width: 4),
                        Text(
                          room.avgAge.toString() + '세',
                          style: kSmallCaptionStyle,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '·',
                          style: kSmallCaptionStyle.copyWith(
                              color: kMainBlack.withOpacity(0.6)),
                        ),
                        const SizedBox(width: 4),
                        Text('성별',
                            style: kSmallCaptionStyle.copyWith(
                                color: kMainBlack.withOpacity(0.6))),
                        const SizedBox(width: 4),
                        Text(room.gender!, style: kSmallCaptionStyle)
                      ],
                    ),
                    if (roomType == ViewType.statusSendView)
                      const SizedBox(height: 16),
                    if (roomType == ViewType.statusSendView)
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: joinmember!),
                    if (roomType == ViewType.otherView || roomType == ViewType.myRoom)
                      const SizedBox(height: 15),
                    if (roomType == ViewType.otherView) 
                      Row(
                        children: [
                          Text('인원',
                              style: kSmallCaptionStyle.copyWith(
                                  color: kMainBlack.withOpacity(0.6))),
                          const SizedBox(width: 4),
                          Text('${room.totalMember} : ${room.totalMember}',
                              style: kSmallCaptionStyle),
                          const Spacer(),
                          getBoxColor(room.date!),
                          const SizedBox(width: 8),
                          Text(calculateDate(room.date!),
                              style: kSmallCaptionStyle.copyWith(
                                  color: kMainBlack.withOpacity(0.4)))
                        ],
                      ),
                    if(roomType == ViewType.myRoom)
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
                      if(isChief)
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isChief
                            ? Text('회원님이 방장으로 신청 현황을 관리할 수 있어요', style: kSmallCaptionStyle.copyWith(color: kPrimary),)
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
