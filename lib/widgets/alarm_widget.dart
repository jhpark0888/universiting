import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/api/status_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/status_controller.dart';
import 'package:universiting/models/alarm_model.dart';
import 'package:universiting/models/profile_model.dart';
import 'package:universiting/widgets/custom_button_widget.dart';
import 'package:universiting/widgets/profile_image_widget.dart';
import 'package:universiting/widgets/room_widget.dart';

class AlarmReceiveWidget extends StatelessWidget {
  AlarmReceiveWidget({Key? key, required this.alarmreceive}) : super(key: key);
  AlarmReceive alarmreceive;
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
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
                        serverUrl + alarmreceive.profile.profileImage,
                        height: Get.width / 7.5,
                        width: Get.width / 7.5,
                        fit: BoxFit.cover,
                      )),
          if (alarmreceive.type == 1 || alarmreceive.type == 2) const SizedBox(width: 12),
          if (alarmreceive.type == 1)
            Expanded(
                child: Text(
              '${alarmreceive.profile.nickname}님이 회원님을 ${alarmreceive.content.title}방에 초대했어요',
              maxLines: null,
              style: kSubtitleStyle2,
            )),
          if (alarmreceive.type == 2)
            Expanded(
                child: Text(
                    '${alarmreceive.profile.nickname}님이 회원님을 ${alarmreceive.content.title}방에 참여하길 원해요',
                    maxLines: null,
                    style: kSubtitleStyle2)),
        ],
      ),
      if (alarmreceive.type == 3)
        RoomWidget(
            room: alarmreceive.content,
            roomType: RoomType.statusReceiveView,
            hosts: StatusController.to.receiveHostprofileImage,
            isChief: false),
      const SizedBox(height: 12),
      Row(
        children: [
          Expanded(
            child: CustomButtonWidget(
                buttonTitle: '거절하기',
                buttonState: ButtonState.negative,
                onTap: () {
                  hostMemberAlarm(alarmreceive.targetId.toString(), 'reject');
                  deleteAlarm(alarmreceive.id.toString());
                }),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: CustomButtonWidget(
                buttonTitle: '수락하기',
                buttonState: ButtonState.primary,
                onTap: () async {
                  if (alarmreceive.type == 1) {
                    await hostMemberAlarm(alarmreceive.targetId.toString(), 'join')
                        .then((value) => deleteAlarm(alarmreceive.id.toString()));
                  } else if (alarmreceive.type == 2) {
                    await okJoinAlarm(alarmreceive.targetId.toString(),
                            alarmreceive.profile.userId.toString(), 'join')
                        .then((value) => deleteAlarm(alarmreceive.id.toString()));
                  }
                }),
          ),
        ],
      ),
      const SizedBox(height: 24)
    ]);
  }
}

class AlarmSendWidget extends StatelessWidget {
  AlarmSendWidget({ Key? key, required this.alarmSend, required this.joinMember}) : super(key: key);
  AlarmSend alarmSend;
  List<ProfileImageWidget> joinMember;
  @override
  Widget build(BuildContext context) {
    return Column(
     children :   [RoomWidget(hosts: StatusController.to.sendHostprofileImage, room: alarmSend.room,roomType: RoomType.statusSendView, isChief: false , joinmember: joinMember,)]
    );
  }
}