import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:universiting/api/profile_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/controllers/profile_controller.dart';
import 'package:universiting/views/profile_upadte.dart';
import 'package:universiting/widgets/button_widget.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);
  ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    print(profileController.profile.value.profileImage);
    return Scaffold(
        backgroundColor: kMainWhite,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 26, 20, 0),
            child: Obx(
              () => Stack(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: Get.width / 15,
                            width: Get.width / 3,
                            decoration: BoxDecoration(
                                color: Color(0xffE1E1E1),
                                borderRadius: BorderRadius.circular(20)),
                            child: const Center(child: Text('내 코드 ewqe')),
                          ),
                          const Icon(Icons.settings)
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          ClipOval(
                            child:
                                profileController.profile.value.profileImage ==
                                        ''
                                    ? Image.asset(
                                        'assets/icons/marker.png',
                                        height: Get.width / 4.5,
                                        width: Get.width / 4.5,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        serverUrl +
                                            profileController
                                                .profile.value.profileImage,
                                        height: Get.width / 4.5,
                                        width: Get.width / 4.5,
                                        fit: BoxFit.cover,
                                      ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${profileController.profile.value.nickname} / ${profileController.profile.value.age.toString()} / ${profileController.profile.value.gender}',
                                style: kHeaderStyle2,
                              ),
                              SizedBox(height: 8),
                              Text(profileController.profile.value.university,
                                  style: kBodyStyle2.copyWith(
                                      color: kMainBlack.withOpacity(0.6))),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                profileController.profile.value.department,
                                style: kBodyStyle2.copyWith(
                                    color: kMainBlack.withOpacity(0.6)),
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: Get.width,
                        child: Text(
                            profileController.profile.value.introduction,
                            style: kBodyStyle2),
                      ),
                      const SizedBox(height: 24),
                      GestureDetector(
                          onTap: () {
                            Get.to(() => ProfileUpdate());
                          },
                          child: PrimaryButton(text: '프로필 수정하기')),
                      const SizedBox(height: 12),
                      Text('프로필 사진과 소개를 작성하면 더 좋지 않을까요?',
                          style: kSmallCaptionStyle.copyWith(
                              color: kMainBlack.withOpacity(0.6)))
                    ],
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
                        child: const Icon(Icons.photo_camera)),
                    left: Get.width / 6,
                    top: Get.width / 4,
                  )
                ],
              ),
            ),
          ),
        ));
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
