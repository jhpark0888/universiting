import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/status_controller.dart';
import 'package:universiting/models/alarm_model.dart';
import 'package:universiting/models/profile_model.dart';
import 'package:universiting/widgets/custom_button_widget.dart';

class AlarmWidget extends StatelessWidget {
  AlarmWidget({Key? key, required this.alarm}) : super(key: key);
  Alarm alarm;
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(
        children: [
          ClipOval(
              child: alarm.profile.profileImage == ''
                  ? SvgPicture.asset(
                      'assets/illustrations/default_profile.svg',
                      height: Get.width / 7.5,
                      width: Get.width / 7.5,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      serverUrl + alarm.profile.profileImage,
                      height: Get.width / 7.5,
                      width: Get.width / 7.5,
                      fit: BoxFit.cover,
                    )),
          const SizedBox(width: 12),
          if (alarm.type == 1)
            Expanded(
                child: Text(
              '${alarm.profile.nickname}님이 회원님을 ${alarm.content}방에 초대했어요',
              maxLines: null,
              style: kSubtitleStyle2,
            )),
          if (alarm.type == 2)
            Expanded(
                child: Text(
                    '${alarm.profile.nickname}님이 회원님을 ${alarm.content}방에 참여하길 원해요',
                    maxLines: null,
                    style: kSubtitleStyle2))
        ],
      ),
      const SizedBox(height: 12),
      Row(
        children: [
          Expanded(
            child: CustomButtonWidget(
                buttonTitle: '거절하기',
                buttonState: ButtonState.negative,
                onTap: () {}),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: CustomButtonWidget(
                buttonTitle: '수락하기',
                buttonState: ButtonState.primary,
                onTap: () {}),
          ), 
        ],
      ),
      const SizedBox(height: 24)
    ]);
  }
}
