import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:universiting/Api/status_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/my_room_controller.dart';
import 'package:universiting/controllers/status_controller.dart';
import 'package:universiting/models/alarm_model.dart';
import 'package:universiting/models/profile_model.dart';
import 'package:universiting/widgets/custom_button_widget.dart';
import 'package:universiting/widgets/profile_image_widget.dart';
import 'package:universiting/widgets/room_widget.dart';

import '../Api/status_api.dart';

class AlarmReceiveWidget extends StatelessWidget {
  AlarmReceiveWidget({Key? key, required this.alarmreceive, required this.host})
      : super(key: key);
  AlarmReceive alarmreceive;
  List<ProfileImageWidget> host;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(host);
      },
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(
          children: [
            if (alarmreceive.type == 1 || alarmreceive.type == 2)
              ClipOval(
                  child: alarmreceive.profile.profileImage == ''
                      ? SvgPicture.asset(
                          'assets/illustrations/default_profile.svg',
                          height: Get.width / 7.5,
                          width: Get.width / 7.5,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          alarmreceive.profile.profileImage,
                          height: Get.width / 7.5,
                          width: Get.width / 7.5,
                          fit: BoxFit.cover,
                        )),
            if (alarmreceive.type == 1 || alarmreceive.type == 2)
              const SizedBox(width: 12),
            if (alarmreceive.type == 1)
              Expanded(
                  child: Text(
                '${alarmreceive.profile.nickname}님이 회원님을 ${alarmreceive.content!.title}방에 초대했어요',
                maxLines: null,
                style: kSubtitleStyle2,
              )),
            if (alarmreceive.type == 2)
              Expanded(
                  child: Text(
                      '${alarmreceive.profile.nickname}님이 회원님을 ${alarmreceive.content!.title}방에 참여하길 원해요',
                      maxLines: null,
                      style: kSubtitleStyle2)),
          ],
        ),
        if (alarmreceive.type == 3)
          RoomWidget(
              room: alarmreceive.content!,
              roomType: ViewType.statusReceiveView,
              hosts: host,
              isChief: false),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: CustomButtonWidget(
                  buttonTitle: '거절하기',
                  buttonState: ButtonState.negative,
                  onTap: () async {
                    if (alarmreceive.type == 1) {
                      hostMemberAlarm(
                              alarmreceive.targetId.toString(), 'reject')
                          .then((value) {
                        deleteAlarm(alarmreceive.id.toString());
                      });
                    } else if (alarmreceive.type == 2) {
                      okJoinAlarm(alarmreceive.targetId.toString(),
                              alarmreceive.profile.userId.toString(), 'reject')
                          .then((value) {
                        deleteAlarm(alarmreceive.id.toString());
                      });
                    } else if (alarmreceive.type == 3) {
                      await rejectToChat(alarmreceive).then((value) {
                        deleteAlarm(alarmreceive.id.toString());
                      });
                    }
                    StatusController.to.allReceiveList.value = StatusController
                        .to.allReceiveList
                        .where((widget) => widget.alarmreceive != alarmreceive)
                        .toList();
                  }),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomButtonWidget(
                  buttonTitle: '수락하기',
                  buttonState: ButtonState.primary,
                  onTap: () async {
                    if (alarmreceive.type == 1) {
                      await hostMemberAlarm(
                              alarmreceive.targetId.toString(), 'join')
                          .then((value) =>
                              deleteAlarm(alarmreceive.id.toString()));
                      MyRoomController.to.getRoomList();
                    } else if (alarmreceive.type == 2) {
                      await okJoinAlarm(alarmreceive.targetId.toString(),
                              alarmreceive.profile.userId.toString(), 'join')
                          .then((value) =>
                              deleteAlarm(alarmreceive.id.toString()));
                      MyRoomController.to.getRoomList();
                    } else if (alarmreceive.type == 3) {
                      await joinToChat(alarmreceive).then(
                          (value) => deleteAlarm(alarmreceive.id.toString()));
                    }
                    StatusController.to.allReceiveList.value = StatusController
                        .to.allReceiveList
                        .where((widget) => widget.alarmreceive != alarmreceive)
                        .toList();
                    print(alarmreceive.type);
                  }),
            ),
          ],
        ),
        const SizedBox(height: 24)
      ]),
    );
  }
}

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
