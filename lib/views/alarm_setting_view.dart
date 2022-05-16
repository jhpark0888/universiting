import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/views/setting_view.dart';
import 'package:universiting/widgets/appbar_widget.dart';

import '../constant.dart';

class AlarmSettingView extends StatefulWidget {
  @override
  State<AlarmSettingView> createState() => _AlarmSettingViewState();
}

class _AlarmSettingViewState extends State<AlarmSettingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: '알림',
      ),
      body: Column(
        children: [
          SettingList(
            onTap: () async {
              await AppSettings.openNotificationSettings();
            },
            title: '시스템 알림 설정',
            isIcon: true,
          ),
          // Padding(
          //   padding: EdgeInsets.symmetric(
          //     vertical: 20,
          //     horizontal: 16,
          //   ),
          // child: Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     const Text('프로모션 알림 설정', style: k16Normal),
          // if (Platform.isAndroid)
          //   Switch(
          //       activeColor: kPrimary,
          //       inactiveTrackColor: kLightGrey,
          //       value: _localDataController.isUserAgreeProNoti,
          //       onChanged: (bool val) {
          //         setState(() {
          //           _localDataController.agreeProNoti(val);
          //           _notificationController.changePromotionAlarmState(
          //               _localDataController.isUserAgreeProNoti);
          //           if (_localDataController.isUserAgreeProNoti) {
          //             showCustomDialog(
          //                 '프로모션 알림 수신에 동의하셨습니다\n' +
          //                     '(${DateFormat('yy.MM.dd').format(DateTime.now())})',
          //                 1000);
          //           }
          //         });
          //       }),
          // if (Platform.isIOS)
          //   CupertinoSwitch(
          //       activeColor: kPrimary,
          //       value: _localDataController.isUserAgreeProNoti,
          //       onChanged: (bool val) {
          //         setState(() {
          //           _localDataController.agreeProNoti(val);
          //           _notificationController.changePromotionAlarmState(
          //               _localDataController.isUserAgreeProNoti);
          //           if (_localDataController.isUserAgreeProNoti) {
          //             showCustomDialog(
          //                 '프로모션 알림 수신에 동의하셨습니다\n' +
          //                     '(${DateFormat('yy.MM.dd').format(DateTime.now())})',
          //                 1000);
          //           }
          //         });
          //       }),
          //     ],
          //   ),
          // ),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\u2219 ',
                      style: kSmallCaptionStyle.copyWith(
                          color: kMainBlack.withOpacity(0.6)),
                    ),
                    Expanded(
                      child: Text(
                        '알림이 제대로 오지 않는다면, 로그아웃 후 다시 로그인을 시도해주세요.',
                        style: kSmallCaptionStyle.copyWith(
                            color: kMainBlack.withOpacity(0.6)),
                      ),
                    ),
                  ],
                ),
                // SizedBox(
                //   height: 8,
                // ),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Text(
                //       '\u2219 ',
                //       style: kSmallCaptionStyle.copyWith(
                //           color: kMainBlack.withOpacity(0.6)),
                //     ),
                //     Expanded(
                //       child: Text(
                //         '프로모션 알림을 설정해도 알림이 오지 않는다면, 시스템 알림 설정을 확인해보세요.',
                //         style: kSmallCaptionStyle.copyWith(
                //             color: kMainBlack.withOpacity(0.6)),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
