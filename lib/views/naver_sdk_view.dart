import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/api/login_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/setting_controller.dart';
import 'package:universiting/views/image_check_view.dart';
import 'package:universiting/views/setting_view.dart';
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
          SettingList(
            onTap: () async {
              await launchUrlString(
                  'https://navermaps.github.io/android-map-sdk/reference/com/naver/maps/map/app/LegalNoticeActivity.html');
            },
            title: '네이버 지도 SDK',
            isIcon: true,
          ),
          SettingList(
            onTap: () async {
              await launchUrlString(
                  'https://navermaps.github.io/android-map-sdk/reference/com/naver/maps/map/app/OpenSourceLicenseActivity.html');
            },
            title: '오픈 라이선스',
            isIcon: true,
          ),
        ]),
      ),
    );
  }
}

//네이버 지도 sdk 법적 공지
//오픈 라이선스