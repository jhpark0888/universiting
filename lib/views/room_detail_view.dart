import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/api/room_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/controllers/management_controller.dart';
import 'package:universiting/controllers/room_detail_controller.dart';
import 'package:universiting/utils/global_variable.dart';
import 'package:universiting/utils/custom_profile.dart';
import 'package:universiting/views/participate_view.dart';
import 'package:universiting/views/room_info_view.dart';
import 'package:universiting/views/room_profile_view.dart';
import 'package:universiting/widgets/appbar_widget.dart';
import 'package:universiting/widgets/button_widget.dart';
import 'package:universiting/widgets/custom_button_widget.dart';
import 'package:universiting/widgets/loading_widget.dart';
import 'package:universiting/widgets/room_person_widget.dart';
import 'package:universiting/widgets/scroll_noneffect_widget.dart';

class RoomDetailView extends StatelessWidget {
  RoomDetailView({Key? key, required this.roomid}) : super(key: key);
  String roomid;
  late RoomDetailController roomDetailController =
      Get.put(RoomDetailController(roomid: roomid), tag: '$roomid번 방');

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => roomDetailController.screenstate.value == Screenstate.success
          ? Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBarWidget(
                backgroundColor: Colors.transparent,
                title: '',
                leading: IconButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      Get.back();
                    },
                    icon: SvgPicture.asset(
                      'assets/icons/close.svg',
                      color: kBackgroundWhite,
                    )),
                actions: [
                  IconButton(
                    onPressed: () {
                      if (roomDetailController.detailRoom.value.isJoin ==
                              null &&
                          roomDetailController.detailRoom.value.isCreater ==
                              null) {
                        showCustomModalPopup(context, value1: '이 방 신고하기',
                            func1: () {
                          Get.back();
                          showRoomDialog(
                              controller: roomDetailController.reportController,
                              roomid: roomid,
                              moretype: MoreType.report);
                        },
                            textStyle:
                                kSubtitleStyle3.copyWith(color: kErrorColor));
                      } else {
                        showCustomModalPopup(context, value1: '이 방 나가기',
                            func1: () {
                          Get.back();
                          showRoomDialog(
                              controller: roomDetailController.reportController,
                              roomid: roomid,
                              moretype: MoreType.delete);
                        },
                            textStyle:
                                kSubtitleStyle3.copyWith(color: kErrorColor));
                      }
                    },
                    icon: SvgPicture.asset(
                      'assets/icons/more.svg',
                      color: kBackgroundWhite,
                    ),
                  )
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      width: Get.width,
                      height: Get.width,
                      child: ScrollNoneffectWidget(
                        child: PageView.builder(
                          onPageChanged: ((page) {
                            roomDetailController.currentPage = page;
                          }),
                          controller: roomDetailController.pageController,
                          scrollDirection: Axis.horizontal,
                          // itemCount:
                          //     roomDetailController.detailRoom.value.hosts!.length,
                          itemBuilder: (BuildContext context, int index) =>
                              GestureDetector(
                            onTap: () async {
                              roomDetailController.timer!.cancel();
                              await Get.to(() => RoomProfileView(
                                    roomid: roomid,
                                    profile: roomDetailController
                                            .detailRoom.value.hosts![
                                        index %
                                            roomDetailController.detailRoom
                                                .value.hosts!.length],
                                  ));
                              roomDetailController.timerstart();
                            },
                            child: Stack(
                              children: [
                                Image.network(
                                  roomDetailController
                                              .detailRoom
                                              .value
                                              .hosts![index %
                                                  roomDetailController
                                                      .detailRoom
                                                      .value
                                                      .hosts!
                                                      .length]
                                              .profileImage !=
                                          ''
                                      ? roomDetailController
                                          .detailRoom
                                          .value
                                          .hosts![index %
                                              roomDetailController.detailRoom
                                                  .value.hosts!.length]
                                          .profileImage
                                      : 'https://media.istockphoto.com/photos/confident-young-man-in-casual-green-shirt-looking-away-standing-with-picture-id1324558913?s=612x612',
                                  width: Get.width,
                                  height: Get.width,
                                  fit: BoxFit.cover,
                                ),
                                ClipRect(child: ProfileBlur()),
                                Positioned(
                                    bottom: 0,
                                    child: Container(
                                      width: Get.width,
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 20, 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${roomDetailController.detailRoom.value.hosts![index % roomDetailController.detailRoom.value.hosts!.length].nickname} / ${roomDetailController.detailRoom.value.hosts![index % roomDetailController.detailRoom.value.hosts!.length].age.toString()}세 / ${roomDetailController.detailRoom.value.hosts![index % roomDetailController.detailRoom.value.hosts!.length].gender}',
                                            style: k16Medium.copyWith(
                                                color: kBackgroundWhite),
                                          ),
                                          Text(
                                            '${index % roomDetailController.detailRoom.value.hosts!.length + 1}/${roomDetailController.detailRoom.value.hosts!.length}',
                                            style: k16Medium.copyWith(
                                                color: kBackgroundWhite),
                                          )
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            roomDetailController.detailRoom.value.title,
                            style: k16SemiBold.copyWith(height: 1.5),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '조회수 ${roomDetailController.detailRoom.value.views}',
                                style: k16Medium.copyWith(
                                    color: kMainBlack.withOpacity(0.4)),
                              ),
                              Text(
                                calculateDate(roomDetailController
                                    .detailRoom.value.date!),
                                style: k16Medium.copyWith(
                                    color: kMainBlack.withOpacity(0.4)),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text('방 소개', style: k16Medium),
                          const SizedBox(height: 12),
                          Text(
                              roomDetailController
                                      .detailRoom.value.introduction ??
                                  '소개글이 없어요',
                              style: k16Light.copyWith(
                                height: 1.5,
                              )),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/mini_univ.svg',
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                roomDetailController
                                        .detailRoom.value.university ??
                                    '인천대학교',
                                style: k16Medium,
                              )
                            ],
                          ),
                          const SizedBox(height: 12),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: '평균 나이 ',
                                  style: k16Medium.copyWith(
                                      color: kMainBlack.withOpacity(0.4))),
                              TextSpan(
                                  text:
                                      '${roomDetailController.detailRoom.value.avgAge.toString()}세',
                                  style: k16Medium),
                              TextSpan(
                                  text: ' · 성별 ',
                                  style: k16Medium.copyWith(
                                      color: kMainBlack.withOpacity(0.4))),
                              TextSpan(
                                  text: roomDetailController
                                          .detailRoom.value.gender ??
                                      'gender를 안 줌',
                                  style: k16Medium),
                              TextSpan(
                                  text: ' · 인원 ',
                                  style: k16Medium.copyWith(
                                      color: kMainBlack.withOpacity(0.4))),
                              TextSpan(
                                  text:
                                      '${roomDetailController.detailRoom.value.hosts!.length}:${roomDetailController.detailRoom.value.hosts!.length}',
                                  style: k16Medium),
                            ]),
                          ),
                          if (roomDetailController.detailRoom.value.isJoin ==
                                  null &&
                              roomDetailController.detailRoom.value.isCreater ==
                                  null)
                            const SizedBox(height: 35),
                          if (roomDetailController.detailRoom.value.isJoin ==
                                  null &&
                              roomDetailController.detailRoom.value.isCreater ==
                                  null)
                            CustomButtonWidget(
                              buttonTitle: '참여 신청하기',
                              buttonState: ButtonState.primary,
                              onTap: () async {
                                roomDetailController.timer!.cancel();
                                await Get.to(() => ParticiapteView(
                                      roomid: roomid,
                                      peopleNumber: roomDetailController
                                          .detailRoom.value.totalMember!,
                                    ));
                                roomDetailController.timerstart();
                              },
                            ),
                          if (roomDetailController.detailRoom.value.isJoin ==
                                  null &&
                              roomDetailController.detailRoom.value.isCreater ==
                                  null)
                            const SizedBox(height: 12),
                          if (roomDetailController.detailRoom.value.isJoin ==
                                  null &&
                              roomDetailController.detailRoom.value.isCreater ==
                                  null)
                            Center(
                              child: Text(
                                '함께 갈 친구들을 초대하고,\n 친구들이 모두 수락하면 이 방에 참여 신청이 완료돼요.',
                                style: kLargeCaptionStyle.copyWith(
                                    color: kMainBlack.withOpacity(0.4),
                                    height: 1.5),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          if (roomDetailController.detailRoom.value.isCreater ==
                                  0 ||
                              roomDetailController.detailRoom.value.isCreater ==
                                  1)
                            const SizedBox(height: 26),
                          if (roomDetailController.detailRoom.value.isCreater ==
                              1)
                            Text(
                              '회원님이 방장으로 신청 현황을 관리할 수 있어요',
                              style: kSmallCaptionStyle.copyWith(
                                  height: 1.5, color: kPrimary),
                              textAlign: TextAlign.center,
                            ),
                          if (roomDetailController.detailRoom.value.isCreater ==
                              0)
                            Text(
                                "'${roomDetailController.detailRoom.value.hosts!.first.nickname}'님이 방장이에요",
                                style: kSmallCaptionStyle.copyWith(
                                    height: 1.5,
                                    color: kMainBlack.withOpacity(0.4)),
                                textAlign: TextAlign.center)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          : roomDetailController.screenstate.value == Screenstate.loading
              ? const LoadingWidget()
              : Container(),
    );
  }
}

// class RoomDetailView extends StatelessWidget {
//   RoomDetailView({Key? key, required this.roomid}) : super(key: key);
//   String roomid;

//   @override
//   Widget build(BuildContext context) {
//     RoomDetailController roomDetailController =
//         Get.put(RoomDetailController(roomid: roomid), tag: '$roomid번 방');
//     return Obx(
//       () => Scaffold(
//         appBar: AppBarWidget(
//           title: roomDetailController.detailRoom.value.title,
//           actions: [
//             Padding(
//               padding: EdgeInsets.only(right: 20),
//               child: GestureDetector(
//                 onTap: () {
//                   if (roomDetailController.detailRoom.value.isJoin == null &&
//                       roomDetailController.detailRoom.value.isCreater == null) {
//                     showCustomModalPopup(context, value1: '이 방 신고하기',
//                         func1: () {
//                       Get.back();
//                       showRoomDialog(
//                           controller: roomDetailController.reportController,
//                           roomid: roomid,
//                           moretype: MoreType.report);
//                     }, textStyle: kSubtitleStyle3.copyWith(color: kErrorColor));
//                   } else {
//                     showCustomModalPopup(context, value1: '이 방 나가기', func1: () {
//                       Get.back();
//                       showRoomDialog(
//                           controller: roomDetailController.reportController,
//                           roomid: roomid,
//                           moretype: MoreType.delete);
//                     }, textStyle: kSubtitleStyle3.copyWith(color: kErrorColor));
//                   }
//                 },
//                 child: Icon(
//                   Icons.more_horiz,
//                   color: kMainBlack,
//                 ),
//               ),
//             )
//           ],
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Row(
//                   children: [
//                     const Text('방 소개', style: kSubtitleStyle5),
//                     const Spacer(
//                       flex: 1,
//                     ),
//                     getBoxColor(roomDetailController.detailRoom.value.date!),
//                     const SizedBox(width: 8),
//                     Text(
//                         calculateDate(
//                             roomDetailController.detailRoom.value.date!),
//                         style: kSmallCaptionStyle.copyWith(
//                             color: kMainBlack.withOpacity(0.4)))
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//                 Text(roomDetailController.detailRoom.value.title,
//                     style: kBodyStyle1),
//                 const SizedBox(height: 30),
//                 Text(
//                     '구성원 ${roomDetailController.detailRoom.value.totalMember}명',
//                     style: kSubtitleStyle5),
//                 const SizedBox(height: 17),
//                 Column(children: roomDetailController.roomPersonList),
//                 if (roomDetailController.detailRoom.value.isJoin == null &&
//                     roomDetailController.detailRoom.value.isCreater == null)
//                   const SizedBox(height: 35),
//                 if (roomDetailController.detailRoom.value.isJoin == null &&
//                     roomDetailController.detailRoom.value.isCreater == null)
//                   CustomButtonWidget(
//                     buttonTitle: '이 방에 함께 갈 친구들 초대하기',
//                     buttonState: ButtonState.primary,
//                     onTap: () {
//                       Get.to(() => ParticiapteView(
//                             roomid: roomid,
//                             peopleNumber: roomDetailController
//                                 .detailRoom.value.totalMember!,
//                           ));
//                     },
//                   ),
//                 if (roomDetailController.detailRoom.value.isJoin == null &&
//                     roomDetailController.detailRoom.value.isCreater == null)
//                   const SizedBox(height: 12),
//                 if (roomDetailController.detailRoom.value.isJoin == null &&
//                     roomDetailController.detailRoom.value.isCreater == null)
//                   Center(
//                     child: Text(
//                       '함께 갈 친구들을 초대하고,\n 친구들이 모두 수락하면 이 방에 참여 신청이 완료돼요.',
//                       style: kSmallCaptionStyle.copyWith(
//                           color: kMainBlack.withOpacity(0.4), height: 1.5),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 if (roomDetailController.detailRoom.value.isCreater == 0 ||
//                     roomDetailController.detailRoom.value.isCreater == 1)
//                   const SizedBox(height: 26),
//                 if (roomDetailController.detailRoom.value.isCreater == 1)
//                   Text(
//                     '회원님이 방장으로 신청 현황을 관리할 수 있어요',
//                     style: kSmallCaptionStyle.copyWith(
//                         height: 1.5, color: kPrimary),
//                     textAlign: TextAlign.center,
//                   ),
//                 if (roomDetailController.detailRoom.value.isCreater == 0)
//                   Text(
//                     "'${roomDetailController.detailRoom.value.hosts!.first.nickname}'님이 방장이에요",
//                     style: kSmallCaptionStyle.copyWith(
//                         height: 1.5, color: kMainBlack.withOpacity(0.4)),
//                     textAlign: TextAlign.center
//                   )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
