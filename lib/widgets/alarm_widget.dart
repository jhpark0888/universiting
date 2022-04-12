import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:universiting/Api/status_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/alarm_list_controller.dart';
import 'package:universiting/controllers/app_controller.dart';
import 'package:universiting/controllers/map_controller.dart';
import 'package:universiting/controllers/my_room_controller.dart';
import 'package:universiting/controllers/profile_controller.dart';
import 'package:universiting/controllers/status_controller.dart';
import 'package:universiting/controllers/status_room_tab_controller.dart';
import 'package:universiting/models/alarm_model.dart';
import 'package:universiting/models/host_model.dart';
import 'package:universiting/models/profile_model.dart';
import 'package:universiting/views/message_detail_screen.dart';
import 'package:universiting/views/room_detail_view.dart';
import 'package:universiting/widgets/custom_button_widget.dart';
import 'package:universiting/widgets/profile_image_widget.dart';
import 'package:universiting/widgets/room_widget.dart';

import '../Api/status_api.dart';

class AlarmReceiveWidget extends StatelessWidget {
  AlarmReceiveWidget({Key? key, required this.alarmreceive, this.host})
      : super(key: key);
  AlarmReceive alarmreceive;
  List<ProfileImageWidget>? host;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(20),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Row(
            //   children: alarmreceive.content!.hosts!
            //       .map((host) => ProfileImageWidget(
            //             type: ViewType.statusReceiveView,
            //             width: 30,
            //             height: 30,
            //           ))
            //       .toList(),
            // ),
            const SizedBox(height: 12),
            if (alarmreceive.type >= 1 && alarmreceive.type <= 3)
              Row(
                children: [
                  Expanded(
                    child: CustomButtonWidget(
                        contentPadding: EdgeInsets.fromLTRB(40, 14, 40, 14),
                        height: 42,
                        width: 129,
                        buttonTitle: '거절하기',
                        buttonState: ButtonState.enabled,
                        onTap: () async {
                          if (alarmreceive.type == 1) {
                            hostMemberAlarm(
                                    alarmreceive.targetId.toString(), 'reject')
                                .then((value) {
                              deleteAlarm(alarmreceive.id.toString());
                              AlarmListController.to.alarmList.value =
                                  AlarmListController.to.alarmList
                                      .where((element) =>
                                          element.alarmreceive != alarmreceive)
                                      .toList();
                            });
                          } else if (alarmreceive.type == 2) {
                            okJoinAlarm(
                                    alarmreceive.targetId.toString(),
                                    alarmreceive.profile.userId.toString(),
                                    'reject')
                                .then((value) {
                              deleteAlarm(alarmreceive.id.toString());
                              AlarmListController.to.alarmList.value =
                                  AlarmListController.to.alarmList
                                      .where((element) =>
                                          element.alarmreceive != alarmreceive)
                                      .toList();
                            });
                          } else if (alarmreceive.type == 3) {
                            await rejectToChat(alarmreceive).then((value) {
                              deleteAlarm(alarmreceive.id.toString());
                            });
                            StatusController.to.allReceiveList.value =
                                StatusController.to.allReceiveList
                                    .where((widget) =>
                                        widget.alarmreceive != alarmreceive)
                                    .toList();
                          }
                        }),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomButtonWidget(
                        height: 42,
                        width: 129,
                        buttonTitle: '수락하기',
                        buttonState: ButtonState.primary,
                        onTap: () async {
                          if (alarmreceive.type == 1) {
                            await hostMemberAlarm(
                                    alarmreceive.targetId.toString(), 'join')
                                .then((value) =>
                                    deleteAlarm(alarmreceive.id.toString()));
                            AlarmListController.to.alarmList.value =
                                AlarmListController.to.alarmList
                                    .where((element) =>
                                        element.alarmreceive != alarmreceive)
                                    .toList();
                            MyRoomController.to.getRoomList();
                          } else if (alarmreceive.type == 2) {
                            await okJoinAlarm(
                                    alarmreceive.targetId.toString(),
                                    alarmreceive.profile.userId.toString(),
                                    'join')
                                .then((value) =>
                                    deleteAlarm(alarmreceive.id.toString()));
                            AlarmListController.to.alarmList.value =
                                AlarmListController.to.alarmList
                                    .where((element) =>
                                        element.alarmreceive != alarmreceive)
                                    .toList();
                            MyRoomController.to.getRoomList();
                          } else if (alarmreceive.type == 3) {
                            await joinToChat(alarmreceive).then((value) =>
                                deleteAlarm(alarmreceive.id.toString()));
                            StatusController.to.allReceiveList.value =
                                StatusController.to.allReceiveList
                                    .where((widget) =>
                                        widget.alarmreceive != alarmreceive)
                                    .toList();
                          }

                          // print(alarmreceive.type);
                        }),
                  ),
                ],
              ),
            // const SizedBox(height: 24)
          ],
        ),
      ),
    );
  }

  Widget selectTypeText(AlarmReceive alarmreceive) {
    if (alarmreceive.type == 1) {
      return RichText(
          text: TextSpan(children: [
        TextSpan(
            text:
                "${alarmreceive.profile.nickname}님이 회원님을 '${alarmreceive.roomInformation}'",
            style: kBodyStyle1),
        TextSpan(
            text: ' 방에 초대했어요', style: kBodyStyle1.copyWith(color: kPrimary))
      ]));
    } else if (alarmreceive.type == 2) {
      return RichText(
          text: TextSpan(children: [
        TextSpan(
            text:
                "'${alarmreceive.roomInformation}'방에 ${alarmreceive.profile.nickname}님이",
            style: kBodyStyle1),
        TextSpan(
            text: ' 회원님과 함께 참여하고 싶어해요',
            style: kBodyStyle1.copyWith(color: kPrimary))
      ]));
    } else if (alarmreceive.type == 4) {
      return RichText(
          text: TextSpan(children: [
        TextSpan(
            text: "'${alarmreceive.roomInformation}'방의 친구들이 함께하기를",
            style: kBodyStyle1),
        TextSpan(
            text: ' 모두 수락하여 지도에 표시돼요',
            style: kBodyStyle1.copyWith(color: kPrimary))
      ]));
    } else if (alarmreceive.type == 5) {
      return RichText(
          text: TextSpan(children: [
        TextSpan(
            text: "'${alarmreceive.roomInformation}'방에", style: kBodyStyle1),
        TextSpan(
            text: ' 함께 갈 친구들이 모두 수락하여 신청이 완료되었어요',
            style: kBodyStyle1.copyWith(color: kPrimary))
      ]));
    } else if (alarmreceive.type == 6) {
      return RichText(
          text: TextSpan(children: [
        TextSpan(
            text: "'${alarmreceive.roomInformation}'방의 친구 중 함께 하기를",
            style: kBodyStyle1),
        TextSpan(
            text: ' 거절한 친구가 있어 방 만들기가 취소되었어요',
            style: kBodyStyle1.copyWith(color: kPrimary))
      ]));
    } else if (alarmreceive.type == 7) {
      return RichText(
          text: TextSpan(children: [
        TextSpan(
            text: "'${alarmreceive.roomInformation}'방에", style: kBodyStyle1),
        TextSpan(
            text: ' 함께 갈 친구들이 모두 수락하여 신청이 완료되었어요',
            style: kBodyStyle1.copyWith(color: kPrimary))
      ]));
    } else if (alarmreceive.type == 8) {
      return RichText(
          text: TextSpan(children: [
        TextSpan(
            text: "'${alarmreceive.roomInformation}'의 채팅방이",
            style: kBodyStyle1),
        TextSpan(
            text: ' 생성되었어요! 지금 바로 친구들과 채팅해보세요',
            style: kBodyStyle1.copyWith(color: kPrimary))
      ]));
    } else if (alarmreceive.type == 9) {
      return RichText(
          text: TextSpan(children: [
        TextSpan(
            text: "'${alarmreceive.roomInformation}'방이", style: kBodyStyle1),
        TextSpan(
            text: ' 신청을 거절했어요', style: kBodyStyle1.copyWith(color: kPrimary))
      ]));
    } else if (alarmreceive.type == 10) {
      return RichText(
          text: TextSpan(children: [
        TextSpan(
            text: "'${alarmreceive.roomInformation}'방의 친구 중 함께 하기를",
            style: kBodyStyle1),
        TextSpan(
            text: ' 거절 한 친구가 있어 방 만들기가 취소되었어요',
            style: kBodyStyle1.copyWith(color: kPrimary))
      ]));
    }
    return RichText(
        text: TextSpan(children: [
      TextSpan(text: "'${alarmreceive.roomInformation}'방에", style: kBodyStyle1),
      TextSpan(
          text: ' 새로운 신청이 들어왔어요', style: kBodyStyle1.copyWith(color: kPrimary))
    ]));
  }

  void onTap() {
    if (alarmreceive.type == 1) {
      Get.to(() => RoomDetailView(roomid: alarmreceive.targetId.toString()));
    } else if (alarmreceive.type == 2) {
    } else if (alarmreceive.type == 3) {
      Get.back();
      AppController.to.currentIndex.value = 2;
      StatusRoomTabController.to.currentIndex.value = 0;
    } else if (alarmreceive.type == 4) {
      int pos = MapController.to.markers.indexWhere((element) =>
          element.captionText == ProfileController.to.profile.value.university);
      Get.back();
      MapController.to.getUnivDetailRoom(pos);
    } else if (alarmreceive.type == 5) {
      Get.back();
      AppController.to.currentIndex.value = 2;
      StatusRoomTabController.to.currentIndex.value = 1;
    } else if (alarmreceive.type == 6) {
      Get.to(() => RoomDetailView(roomid: alarmreceive.targetId.toString()));
    } else if (alarmreceive.type == 7) {
      Get.to(() => RoomDetailView(roomid: alarmreceive.targetId.toString()));
    } else if (alarmreceive.type == 8) {
      Get.back();
      AppController.to.currentIndex.value = 3;
      MessageDetailScreen(groupId: alarmreceive.targetId.toString());
    } else if (alarmreceive.type == 9) {
      Get.back();
      AppController.to.currentIndex.value = 2;
      StatusRoomTabController.to.currentIndex.value = 1;
    } else if (alarmreceive.type == 10) {
    } else if (alarmreceive.type == 11) {
      Get.back();
      AppController.to.currentIndex.value = 2;
      StatusRoomTabController.to.currentIndex.value = 0;
    }
  }
}

// class AlarmReceiveWidget extends StatelessWidget {
//   AlarmReceiveWidget({Key? key, required this.alarmreceive, this.host})
//       : super(key: key);
//   AlarmReceive alarmreceive;
//   List<ProfileImageWidget>? host;
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 10),
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//             color: kBackgroundWhite,
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(
//                       color: const Color(0x000000).withOpacity(0.1),
//                       blurRadius: 3,
//                       spreadRadius: 0,
//                       offset: const Offset(0.0, 1.0))
//             ]),
//         child:
//             Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
//           // Row(
//           //   children: [
//           //     // if (alarmreceive.type == 1 || alarmreceive.type == 2)
//           //     //   ClipOval(
//           //     //       child: alarmreceive.profile.profileImage == ''
//           //     //           ? SvgPicture.asset(
//           //     //               'assets/illustrations/default_profile.svg',
//           //     //               height: Get.width / 7.5,
//           //     //               width: Get.width / 7.5,
//           //     //               fit: BoxFit.cover,
//           //     //             )
//           //     //           : Image.network(
//           //     //               alarmreceive.profile.profileImage,
//           //     //               height: Get.width / 7.5,
//           //     //               width: Get.width / 7.5,
//           //     //               fit: BoxFit.cover,
//           //     //             )),
//           //     // if (alarmreceive.type == 1 || alarmreceive.type == 2)
//           //     //   const SizedBox(width: 12),
//           //     if (alarmreceive.type == 1)
//           //       RichText(
//           //           text: TextSpan(children: [
//           //         TextSpan(
//           //             text:
//           //                 '${alarmreceive.profile.nickname}님이 회원님을 "${alarmreceive.content!.title}"',
//           //             style: kBodyStyle1),
//           //         TextSpan(
//           //             text: '방에 초대했어요',
//           //             style: kBodyStyle1.copyWith(color: kPrimary))
//           //       ])),
//           //     if (alarmreceive.type == 2)
//           //       Text(
//           //           '${alarmreceive.profile.nickname}님이 회원님을 ${alarmreceive.content!.title}방에 참여하길 원해요',
//           //           maxLines: null,
//           //           style: kBodyStyle1),
//           //   ],
//           // ),
//           if (alarmreceive.type != 3) selectTypeText(alarmreceive),
//           if (alarmreceive.type == 3)
//             RoomWidget(
//                 room: alarmreceive.content!,
//                 roomType: ViewType.statusReceiveView,
//                 hosts: host!,
//                 isChief: false),
//           const SizedBox(height: 12),
//           if (alarmreceive.type >= 1 && alarmreceive.type <= 3)
//             Row(
//               children: [
//                 Expanded(
//                   child: CustomButtonWidget(
//                       contentPadding: EdgeInsets.fromLTRB(40, 14, 40, 14),
//                       height: 42,
//                       width: 129,
//                       buttonTitle: '거절하기',
//                       buttonState: ButtonState.enabled,
//                       onTap: () async {
//                         if (alarmreceive.type == 1) {
//                           hostMemberAlarm(
//                                   alarmreceive.targetId.toString(), 'reject')
//                               .then((value) {
//                             deleteAlarm(alarmreceive.id.toString());
//                             AlarmListController.to.alarmList.value =
//                                 AlarmListController.to.alarmList
//                                     .where((element) =>
//                                         element.alarmreceive != alarmreceive)
//                                     .toList();
//                           });
//                         } else if (alarmreceive.type == 2) {
//                           okJoinAlarm(
//                                   alarmreceive.targetId.toString(),
//                                   alarmreceive.profile.userId.toString(),
//                                   'reject')
//                               .then((value) {
//                             deleteAlarm(alarmreceive.id.toString());
//                             AlarmListController.to.alarmList.value =
//                                 AlarmListController.to.alarmList
//                                     .where((element) =>
//                                         element.alarmreceive != alarmreceive)
//                                     .toList();
//                           });
//                         } else if (alarmreceive.type == 3) {
//                           await rejectToChat(alarmreceive).then((value) {
//                             deleteAlarm(alarmreceive.id.toString());
//                           });
//                           StatusController.to.allReceiveList.value =
//                               StatusController.to.allReceiveList
//                                   .where((widget) =>
//                                       widget.alarmreceive != alarmreceive)
//                                   .toList();
//                         }
//                       }),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: CustomButtonWidget(
//                       height: 42,
//                       width: 129,
//                       buttonTitle: '수락하기',
//                       buttonState: ButtonState.primary,
//                       onTap: () async {
//                         if (alarmreceive.type == 1) {
//                           await hostMemberAlarm(
//                                   alarmreceive.targetId.toString(), 'join')
//                               .then((value) =>
//                                   deleteAlarm(alarmreceive.id.toString()));
//                           AlarmListController.to.alarmList.value =
//                               AlarmListController.to.alarmList
//                                   .where((element) =>
//                                       element.alarmreceive != alarmreceive)
//                                   .toList();
//                           MyRoomController.to.getRoomList();
//                         } else if (alarmreceive.type == 2) {
//                           await okJoinAlarm(
//                                   alarmreceive.targetId.toString(),
//                                   alarmreceive.profile.userId.toString(),
//                                   'join')
//                               .then((value) =>
//                                   deleteAlarm(alarmreceive.id.toString()));
//                           AlarmListController.to.alarmList.value =
//                               AlarmListController.to.alarmList
//                                   .where((element) =>
//                                       element.alarmreceive != alarmreceive)
//                                   .toList();
//                           MyRoomController.to.getRoomList();
//                         } else if (alarmreceive.type == 3) {
//                           await joinToChat(alarmreceive).then((value) =>
//                               deleteAlarm(alarmreceive.id.toString()));
//                           StatusController.to.allReceiveList.value =
//                               StatusController.to.allReceiveList
//                                   .where((widget) =>
//                                       widget.alarmreceive != alarmreceive)
//                                   .toList();
//                         }

//                         // print(alarmreceive.type);
//                       }),
//                 ),
//               ],
//             ),
//           // const SizedBox(height: 24)
//         ]),
//       ),
//     );
//   }

//   Widget selectTypeText(AlarmReceive alarmreceive) {
//     if (alarmreceive.type == 1) {
//       return RichText(
//           text: TextSpan(children: [
//         TextSpan(
//             text:
//                 "${alarmreceive.profile.nickname}님이 회원님을 '${alarmreceive.roomInformation}'",
//             style: kBodyStyle1),
//         TextSpan(
//             text: ' 방에 초대했어요', style: kBodyStyle1.copyWith(color: kPrimary))
//       ]));
//     } else if (alarmreceive.type == 2) {
//       return RichText(
//           text: TextSpan(children: [
//         TextSpan(
//             text:
//                 "'${alarmreceive.roomInformation}'방에 ${alarmreceive.profile.nickname}님이",
//             style: kBodyStyle1),
//         TextSpan(
//             text: ' 회원님과 함께 참여하고 싶어해요',
//             style: kBodyStyle1.copyWith(color: kPrimary))
//       ]));
//     } else if (alarmreceive.type == 4) {
//       return RichText(
//           text: TextSpan(children: [
//         TextSpan(
//             text: "'${alarmreceive.roomInformation}'방의 친구들이 함께하기를",
//             style: kBodyStyle1),
//         TextSpan(
//             text: ' 모두 수락하여 지도에 표시돼요',
//             style: kBodyStyle1.copyWith(color: kPrimary))
//       ]));
//     } else if (alarmreceive.type == 5) {
//       return RichText(
//           text: TextSpan(children: [
//         TextSpan(
//             text: "'${alarmreceive.roomInformation}'방에", style: kBodyStyle1),
//         TextSpan(
//             text: ' 함께 갈 친구들이 모두 수락하여 신청이 완료되었어요',
//             style: kBodyStyle1.copyWith(color: kPrimary))
//       ]));
//     } else if (alarmreceive.type == 6) {
//       return RichText(
//           text: TextSpan(children: [
//         TextSpan(
//             text: "'${alarmreceive.roomInformation}'방의 친구 중 함께 하기를",
//             style: kBodyStyle1),
//         TextSpan(
//             text: ' 거절한 친구가 있어 방 만들기가 취소되었어요',
//             style: kBodyStyle1.copyWith(color: kPrimary))
//       ]));
//     } else if (alarmreceive.type == 7) {
//       return RichText(
//           text: TextSpan(children: [
//         TextSpan(
//             text: "'${alarmreceive.roomInformation}'방에", style: kBodyStyle1),
//         TextSpan(
//             text: ' 함께 갈 친구들이 모두 수락하여 신청이 완료되었어요',
//             style: kBodyStyle1.copyWith(color: kPrimary))
//       ]));
//     } else if (alarmreceive.type == 8) {
//       return RichText(
//           text: TextSpan(children: [
//         TextSpan(
//             text: "'${alarmreceive.roomInformation}'의 채팅방이",
//             style: kBodyStyle1),
//         TextSpan(
//             text: ' 생성되었어요! 지금 바로 친구들과 채팅해보세요',
//             style: kBodyStyle1.copyWith(color: kPrimary))
//       ]));
//     } else if (alarmreceive.type == 9) {
//       return RichText(
//           text: TextSpan(children: [
//         TextSpan(
//             text: "'${alarmreceive.roomInformation}'방이", style: kBodyStyle1),
//         TextSpan(
//             text: ' 신청을 거절했어요', style: kBodyStyle1.copyWith(color: kPrimary))
//       ]));
//     } else if (alarmreceive.type == 10) {
//       return RichText(
//           text: TextSpan(children: [
//         TextSpan(
//             text: "'${alarmreceive.roomInformation}'방의 친구 중 함께 하기를",
//             style: kBodyStyle1),
//         TextSpan(
//             text: ' 거절 한 친구가 있어 방 만들기가 취소되었어요',
//             style: kBodyStyle1.copyWith(color: kPrimary))
//       ]));
//     }
//     return RichText(
//         text: TextSpan(children: [
//       TextSpan(text: "'${alarmreceive.roomInformation}'방에", style: kBodyStyle1),
//       TextSpan(
//           text: ' 새로운 신청이 들어왔어요', style: kBodyStyle1.copyWith(color: kPrimary))
//     ]));
//   }

//   void onTap() {
//     if (alarmreceive.type == 1) {
//       Get.to(() => RoomDetailView(roomid: alarmreceive.targetId.toString()));
//     } else if (alarmreceive.type == 2) {
//     } else if (alarmreceive.type == 3) {
//       Get.back();
//       AppController.to.currentIndex.value = 2;
//       StatusRoomTabController.to.currentIndex.value = 0;
//     } else if (alarmreceive.type == 4) {
//       int pos = MapController.to.markers.indexWhere((element) =>
//           element.captionText == ProfileController.to.profile.value.university);
//       Get.back();
//       MapController.to.getUnivDetailRoom(pos);
//     } else if (alarmreceive.type == 5) {
//       Get.back();
//       AppController.to.currentIndex.value = 2;
//       StatusRoomTabController.to.currentIndex.value = 1;
//     } else if (alarmreceive.type == 6) {
//       Get.to(() => RoomDetailView(roomid: alarmreceive.targetId.toString()));
//     } else if (alarmreceive.type == 7) {
//       Get.to(() => RoomDetailView(roomid: alarmreceive.targetId.toString()));
//     } else if (alarmreceive.type == 8) {
//       Get.back();
//       AppController.to.currentIndex.value = 3;
//       MessageDetailScreen(groupId: alarmreceive.targetId.toString());
//     } else if (alarmreceive.type == 9) {
//       Get.back();
//       AppController.to.currentIndex.value = 2;
//       StatusRoomTabController.to.currentIndex.value = 1;
//     } else if (alarmreceive.type == 10) {
//     } else if (alarmreceive.type == 11) {
//       Get.back();
//       AppController.to.currentIndex.value = 2;
//       StatusRoomTabController.to.currentIndex.value = 0;
//     }
//   }
// }

class AlarmSendWidget extends StatelessWidget {
  AlarmSendWidget(
      {Key? key,
      required this.alarmSend,
      required this.host,
      required this.joinMember})
      : super(key: key);
  AlarmSend alarmSend;
  List<ProfileImageWidget> host;
  List<ProfileImageWidget> joinMember;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      RoomWidget(
        hosts: host,
        room: alarmSend.room,
        roomType: ViewType.statusSendView,
        isChief: false,
        joinmember: joinMember,
      )
    ]);
  }
}
