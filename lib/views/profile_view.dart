import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:universiting/api/profile_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/app_controller.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/controllers/profile_controller.dart';
import 'package:universiting/views/profile_upadte.dart';
import 'package:universiting/views/setting_view.dart';
import 'package:universiting/widgets/appbar_widget.dart';
import 'package:universiting/widgets/button_widget.dart';
import 'package:universiting/widgets/custom_button_widget.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);
  ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    print(profileController.profile.value.profileImage);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(
            '프로필',
            style: kHeaderStyle3,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: IconButton(
              onPressed: () {Get.to(() => SettingView());},
              icon: SvgPicture.asset('assets/icons/setting.svg'),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          right: 20,
          left: 20,
          top: 16,
          bottom: 40,
        ),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(children: [
                    ClipOval(
                      child: profileController.profile.value.profileImage == ''
                          ? SvgPicture.asset(
                              'assets/illustrations/default_profile.svg',
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              serverUrl +
                                  profileController.profile.value.profileImage,
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                    ),
                    Positioned(
                      child: GestureDetector(
                          onTap: () {
                            showCustomModalPopup(context,
                                value1: '라이브러리에서 선택',
                                value2: '기본 이미지로 변경',
                                func1: changeProfileImage,
                                func2: changeDefaultImage);
                          },
                          child: Container(
                            width: 24,
                            height: 24,
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/icons/image.svg',
                              ),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xffe7e7e7), width: 1),
                                color: kBackgroundWhite,
                                shape: BoxShape.circle),
                          )),
                      left: 56,
                      top: 56,
                    )
                  ]),
                  const SizedBox(height: 12),
                  Text(
                    '${profileController.profile.value.nickname} / ${profileController.profile.value.age}세 / ${profileController.profile.value.gender.replaceAll('자', '')}',
                    style: kHeaderStyle1,
                  ),
                  const SizedBox(height: 8),
                  Text(profileController.profile.value.university!,
                      style: kSubtitleStyle2),
                  const SizedBox(height: 8),
                  (profileController.profile.value.department != '')
                      ? Text(profileController.profile.value.department!,
                          style: kSubtitleStyle3)
                      : Text('아직 학과를 설정하지 않았어요',
                          style: kSubtitleStyle3.copyWith(
                            color: kMainBlack.withOpacity(0.38),
                          )),
                  const SizedBox(height: 16),
                ],
              ),
              Text(
                profileController.profile.value.introduction,
                style: kBodyStyle1,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CustomButtonWidget(
                      buttonTitle: '프로필 수정하기',
                      buttonState: ButtonState.secondary,
                      onTap: () {
                        AppController.to.addPage();
                        Get.to(() => ProfileUpdate());
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text('· 프로필 사진이나 학과, 소개를 작성하면 매칭에 도움이 될 거에요.',
                  style: kSmallCaptionStyle.copyWith(
                      color: kMainBlack.withOpacity(0.6)))
            ],
          ),
        ),
      ),
    );
  }

  void changeProfileImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    print(image);
    updateMyProfile(ProfileType.image, File(image!.path));
    print('클릭했습니다.');
  }

  void changeDefaultImage() async {
    updateMyProfile(ProfileType.image, null);
  }
}
