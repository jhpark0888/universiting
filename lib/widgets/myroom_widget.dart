import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/api/room_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/custom_animation_controller.dart';
import 'package:universiting/controllers/management_controller.dart';
import 'package:universiting/controllers/map_controller.dart';
import 'package:universiting/controllers/univ_room_controller.dart';
import 'package:universiting/models/room_model.dart';
import 'package:universiting/utils/global_variable.dart';
import 'package:universiting/views/myroom_request_view.dart';
import 'package:universiting/views/room_detail_view.dart';
import 'package:universiting/widgets/button_widget.dart';
import 'package:universiting/widgets/custom_button_widget.dart';
import 'package:universiting/widgets/myroom_request_widget.dart';
import 'package:universiting/widgets/profile_image_widget.dart';
import 'package:universiting/widgets/reject_button.dart';
import 'package:universiting/widgets/room_profile_image_widget.dart';
import 'package:universiting/widgets/scroll_noneffect_widget.dart';
import 'package:universiting/widgets/state_management_widget.dart';

class MyRoomWidget extends StatelessWidget {
  MyRoomWidget({
    Key? key,
    required this.room,
    this.joinmember,
    this.roomMember,
    this.hosts,
    required this.isChief,
  }) : super(key: key);
  Room room;
  List<Widget>? roomMember;
  List<ProfileImageWidget>? joinmember;
  List<ProfileImageWidget>? hosts;
  RxBool isRequestList = false.obs;
  bool isChief;
  final CustomAnimationController _animationController =
      CustomAnimationController();

  late Widget requesttext = RichText(
      text: TextSpan(children: [
    const TextSpan(text: '이 방이 받은 신청 ', style: k16Medium),
    TextSpan(
        text: '${room.requestcount}개',
        style: k16Medium.copyWith(color: kPrimary)),
    const TextSpan(text: ' 확인하기', style: k16Medium)
  ]));

  void textswitch() {
    if (isRequestList.value) {
      requesttext = Obx(
        () => RichText(
            text: TextSpan(children: [
          const TextSpan(text: '이 방이 받은 신청 ', style: k16Medium),
          TextSpan(
              text: '${room.requestcount}개',
              style: k16Medium.copyWith(color: kPrimary)),
          const TextSpan(text: ' 확인하기', style: k16Medium)
        ])),
      );
    } else {
      requesttext = Text(
        '이 방이 받은 신청 접기',
        style: kSubtitleStyle3.copyWith(color: kMainBlack.withOpacity(0.4)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Get.to(
              () => RoomDetailView(
                    roomid: room.id.toString(),
                  ),
              opaque: false);
        },
        splashColor: kSplashColor,
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const SizedBox(
            height: 18,
          ),
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
          Obx(
            () =>
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 18),
                    Text(room.title,
                        style: kSubtitleStyle5.copyWith(height: 1.5)),
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
                  ],
                ),
              ),
              if (room.roomstate!.value != StateManagement.sendme)
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
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
                      const SizedBox(height: 18),
                      StateManagementWidget(
                        state: room.roomstate!.value,
                        type: 'MyRoom',
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Divider(
                        thickness: 0.5,
                        color: kMainBlack.withOpacity(0.1),
                      ),
                    ],
                  ),
                ),
              if (room.roomstate!.value == StateManagement.sendme)
                Column(
                  children: [
                    const SizedBox(height: 18),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: '\'${room.hosts!.first.nickname}\'',
                          style:
                              k16Medium.copyWith(color: kPrimary, height: 1.5)),
                      const TextSpan(text: '님이 방에 초대했어요', style: k16Medium),
                    ])),
                    const Text('초대를 수락하고 방에 참여해 주세요', style: k16Medium),
                    const SizedBox(height: 18),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: GestureDetector(
                                  onTap: () async {
                                    await roomparticipate(room.id!, 'reject')
                                        .then((httpresponse) {
                                      if (httpresponse.isError == false) {
                                        room.roomstate!(
                                            StateManagement.friendReject);
                                      }
                                    });
                                  },
                                  child: const RejectButton())),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                roomparticipate(room.id!, 'join')
                                    .then((httpresponse) {
                                  if (httpresponse.isError == false) {
                                    if (room.hosts
                                            ?.where((member) =>
                                                member.hostType == false)
                                            .isEmpty ==
                                        true) {
                                      room.roomstate!(
                                          StateManagement.roomActivated);
                                    } else {
                                      room.roomstate!(
                                          StateManagement.waitingFriend);
                                    }
                                  }
                                });
                              },
                              child: PrimaryButton(
                                  text: '수락하기', isactive: true.obs),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 18,
                          ),
                          Divider(
                            thickness: 2.5,
                            color: kMainBlack.withOpacity(0.1),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              if (room.requestcount != 0)
                AnimatedBuilder(
                  animation:
                      _animationController.myRoomWidgetAnimationController.view,
                  builder: (BuildContext context, Widget? child) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ClipRect(
                          child: Align(
                            alignment: Alignment.topCenter,
                            heightFactor:
                                _animationController.expandFactor.value,
                            child: child,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            if (isRequestList.value) {
                              textswitch();
                              isRequestList(false);
                              _animationController
                                  .myRoomWidgetAnimationController
                                  .reverse();
                            } else {
                              await getMyRoomRequestlist('all', 0, room.id!)
                                  .then((httpresponse) {
                                if (httpresponse.isError == false) {
                                  room.requestlist!.value = httpresponse.data;
                                } else {}
                              });
                              textswitch();
                              isRequestList(true);
                              _animationController
                                  .myRoomWidgetAnimationController
                                  .forward();
                            }
                          },
                          splashColor: kSplashColor,
                          borderRadius: BorderRadius.circular(10),
                          child: ClipRect(
                            child: Align(
                              alignment: Alignment.topCenter,
                              heightFactor: 1,
                              child: Column(children: [
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 500),
                                  child: requesttext,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                RotationTransition(
                                  turns: _animationController.iconTurns,
                                  child: SvgPicture.asset(
                                    'assets/icons/down_arrow.svg',
                                  ),
                                ),
                                const SizedBox(
                                  height: 18,
                                ),
                              ]),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        alignment: Alignment.centerRight,
                        child: InkWell(
                            onTap: () {
                              Get.to(() => MyRoomRequestView(
                                    title: room.title,
                                    roomId: room.id!,
                                    requestlist: room.requestlist!,
                                  ));
                            },
                            child: Text(
                              '전체 보기',
                              style: k16Medium.copyWith(color: kPrimary),
                            )),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Obx(
                        () => Center(
                          child: SizedBox(
                            height: 190,
                            child: ScrollNoneffectWidget(
                              child: ListView.separated(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) =>
                                      MyroomRequestWidget(
                                        roomId: room.id!,
                                        isrequestinfo: false,
                                        request: room.requestlist![index],
                                        width: 322,
                                      ),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        width: 8,
                                      ),
                                  itemCount: room.requestlist!.length),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                    ],
                  ),
                ),
              if (room.requestcount != 0)
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    children: [
                      Divider(
                        thickness: 2.5,
                        color: kMainBlack.withOpacity(0.1),
                      ),
                    ],
                  ),
                )
            ]),
          ),
        ]));
  }
}
