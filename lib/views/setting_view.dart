import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/api/login_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/app_controller.dart';
import 'package:universiting/controllers/chat_list_controller.dart';
import 'package:universiting/controllers/home_controller.dart';
import 'package:universiting/controllers/management_controller.dart';
import 'package:universiting/controllers/map_controller.dart';
import 'package:universiting/controllers/profile_controller.dart';
import 'package:universiting/controllers/setting_controller.dart';
import 'package:universiting/controllers/status_controller.dart';
import 'package:universiting/utils/global_variable.dart';
import 'package:universiting/views/alarm_setting_view.dart';
import 'package:universiting/views/home_view.dart';
import 'package:universiting/views/image_check_view.dart';
import 'package:universiting/views/inquary_view.dart';
import 'package:universiting/views/naver_sdk_view.dart';
import 'package:universiting/views/pw_change_view.dart';
import 'package:universiting/views/withdrawal_view.dart';
import 'package:universiting/widgets/appbar_widget.dart';
import 'package:universiting/widgets/loading_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingView extends StatelessWidget {
  SettingView({Key? key}) : super(key: key);
  SettingController settingController = Get.put(SettingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarWidget(title: '설정'),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
        child: Column(children: [
          SettingList(
            onTap: () {
              Get.to(() => AlarmSettingView());
            },
            title: '알림설정',
            isIcon: true,
          ),
          SettingList(onTap: () {}, title: '서비스 이용 약관', isIcon: true),
          SettingList(onTap: () {}, title: '개인정보 처리방침', isIcon: true),
          SettingList(
              onTap: () {
                Get.to(() => InquaryView());
              },
              title: '문의하기',
              isIcon: true),
          SettingList(
              onTap: () {
                Get.to(() => PwChangeView());
              },
              title: '비밀번호 변경',
              isIcon: true),
          SettingList(
              onTap: () async {
                Get.to(() => const LoadingWidget(), opaque: true);
                await logout().then((httpresponse) {
                  Get.back();
                  if (httpresponse.isError == false) {
                    const FlutterSecureStorage().delete(key: "token");
                    const FlutterSecureStorage().delete(key: "id");
                    const FlutterSecureStorage().delete(key: "lng");
                    const FlutterSecureStorage().delete(key: "lat");
                    Get.delete<HomeController>(tag: '다음 화면');
                    Get.delete<HomeController>(tag: '첫 화면');
                    Get.delete<ManagementController>();
                    Get.delete<StatusController>();
                    Get.delete<ChatListController>();
                    Get.delete<ProfileController>();
                    Get.delete<MapController>();
                    Get.offAll(() => HomeView(
                          login: false,
                          tag: '첫 화면',
                          lat: 37.563600,
                          lng: 126.962370,
                        ));
                    Get.put(HomeController(), tag: '첫 화면');
                    AppController.to.currentIndex.value = 0;
                  } else {
                    errorSituation(httpresponse);
                  }
                });
              },
              title: '로그아웃',
              isIcon: false),
          SettingList(
              onTap: () {
                Get.to(() => WithDrawalView());
              },
              title: '회원탈퇴',
              isIcon: false),
          const Spacer(),
          InkWell(
              splashColor: kSplashColor,
              onTap: () {
                Get.to(() => NaverSdkView());
              },
              child: Container(
                  width: 200,
                  child:
                      Image.asset('assets/png/2-1. NAVER OpenAPI_c_hor.png')))
        ]),
      ),
    );
  }
}

class SettingList extends StatelessWidget {
  SettingList(
      {Key? key,
      required this.onTap,
      required this.title,
      required this.isIcon})
      : super(key: key);
  Function() onTap;
  String title;
  bool isIcon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: kSplashColor,
      onTap: onTap,
      child: Padding(
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
      ),
    );
  }
}
