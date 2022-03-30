import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/api/login_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/setting_controller.dart';
import 'package:universiting/widgets/appbar_widget.dart';

class SettingView extends StatelessWidget {
  SettingView({ Key? key }) : super(key: key);
  SettingController settingController = Get.put(SettingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: '설정'),
      body: Column(children: [
        SettingList(title: '알림설정', isIcon: true,),
        SettingList(title: '서비스 이용 약관', isIcon: true),
        SettingList(title: '개인정보 처리방침', isIcon: true),
        SettingList(title: '문의하기', isIcon: true),
        SettingList(title: '비밀번호 변경', isIcon: true),
        GestureDetector(onDoubleTap: (){logout();}, child: SettingList(title: '로그아웃', isIcon: false)),
        SettingList(title: '회원탈퇴', isIcon: false)
      ]),
    );
  }
}


class SettingList extends StatelessWidget {
  SettingList({ Key? key, required this.title, required this.isIcon}) : super(key: key);
  String title;
  bool isIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16,26,16,26),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(title,style: kSubtitleStyle4), isIcon ? SvgPicture.asset('assets/icons/arrow_right.svg') : const SizedBox.shrink()],
      ),
    );
  }
}