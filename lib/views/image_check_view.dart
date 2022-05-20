import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:universiting/api/profile_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/home_controller.dart';
import 'package:universiting/controllers/profile_controller.dart';
import 'package:universiting/utils/custom_profile.dart';
import 'package:universiting/widgets/button_widget.dart';

class ImageCheckView extends StatelessWidget {
  const ImageCheckView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Obx(
        () => Scaffold(
          body: Padding(
            padding: EdgeInsets.fromLTRB(
                30, MediaQuery.of(context).padding.top + 40, 30, 17),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('잠깐! 유니버시팅이 처음이시네요', style: kHeaderStyle2),
                  const SizedBox(height: 10),
                  const Text('친구들을 위해 프로필 사진이 필요해요', style: kHeaderStyle2),
                  const SizedBox(height: 60),
                  GestureDetector(
                    onTap: () {
                      changeProfileImage();
                    },
                    child: Center(
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: const BoxDecoration(
                            color: Color(0xffF7F7F7),
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        child:
                            ProfileController.to.profile.value.profileImage ==
                                    ''
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                          'assets/icons/image_update.svg')
                                    ],
                                  )
                                : CustomCachedNetworkImage(
                                    imageUrl: ProfileController
                                        .to.profile.value.profileImage
                                        .replaceAll('https', 'http'),
                                  ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '본인을 잘 나타낼 수 있는 사진이 필요해요',
                    style: k16Normal.copyWith(
                        color: kMainBlack.withOpacity(0.4), height: 1.5),
                    textAlign: TextAlign.center,
                  ),
                  Text('얼굴 사진이 아니어도 괜찮아요',
                      style: k16Normal.copyWith(
                          color: kMainBlack.withOpacity(0.4), height: 1.5),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 20),
                  Text('부적적할 사진을 게시할 경우',
                      style: kSmallCaptionStyle.copyWith(
                          color: kMainBlack.withOpacity(0.4), height: 1.5),
                      textAlign: TextAlign.center),
                  Text('이유를 불문한 계정 제재 및 민형사적 책임을 질 수 있습니다.',
                      style: kSmallCaptionStyle.copyWith(
                          color: kMainBlack.withOpacity(0.4), height: 1.5),
                      textAlign: TextAlign.center),
                  const Spacer(),
                  GestureDetector(
                      onTap: () {
                        if (ProfileController.to.profile.value.profileImage !=
                            '') {
                          HomeController.to.isImagecheck.value = true;
                          HomeController.to.getLoad();
                        } else {}
                      },
                      child:
                          PrimaryButton(text: '친구 만나러 가기', isactive: true.obs))
                ]),
          ),
        ),
      ),
    );
  }

  void changeProfileImage() async {
    XFile? check_image =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (check_image != null) {}
    print('클릭했습니다.');
    updateMyProfile(ProfileType.image, File(check_image!.path));
  }
}

void changeDefaultImage() async {
  updateMyProfile(ProfileType.image, null);
}
