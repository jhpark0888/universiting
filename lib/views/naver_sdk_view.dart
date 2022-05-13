import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/api/login_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/setting_controller.dart';
import 'package:universiting/views/image_check_view.dart';
import 'package:universiting/widgets/appbar_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NaverSdkView extends StatelessWidget {
  NaverSdkView({Key? key}) : super(key: key);
  SettingController settingController = Get.put(SettingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'NAVER MAP SDK'),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
        child: Column(children: [
          GestureDetector(
              onTap: () async {
                await launchUrlString(
                    'https://navermaps.github.io/android-map-sdk/reference/com/naver/maps/map/app/LegalNoticeActivity.html');
              },
              child: SettingList(
                title: '네이버 지도 SDK',
                isIcon: true,
              )),
          GestureDetector(
              onTap: () async {
                await launchUrlString(
                    'https://navermaps.github.io/android-map-sdk/reference/com/naver/maps/map/app/OpenSourceLicenseActivity.html');
              },
              child: SettingList(
                title: '오픈 라이선스',
                isIcon: true,
              )),
        ]),
      ),
    );
  }
}

class SettingList extends StatelessWidget {
  SettingList({Key? key, required this.title, required this.isIcon})
      : super(key: key);
  String title;
  bool isIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 26, 16, 26),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: kSubtitleStyle4),
          isIcon
              ? SvgPicture.asset('assets/icons/arrow_right.svg')
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}

//네이버 지도 sdk 법적 공지
//오픈 라이선스