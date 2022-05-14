import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:universiting/api/profile_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/app_controller.dart';
import 'package:universiting/controllers/home_controller.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/controllers/profile_controller.dart';
import 'package:universiting/models/profile_model.dart';
import 'package:universiting/utils/custom_profile.dart';
import 'package:universiting/views/profile_upadte.dart';
import 'package:universiting/views/setting_view.dart';
import 'package:universiting/widgets/appbar_widget.dart';
import 'package:universiting/widgets/button_widget.dart';
import 'package:universiting/widgets/custom_button_widget.dart';
import 'package:universiting/widgets/empty_back_textfield_widget.dart';
import 'package:universiting/widgets/scroll_noneffect_widget.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);
  ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    print(profileController.profile.value.profileImage);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   centerTitle: false,
      //   elevation: 0,
      //   title: Padding(
      //     padding: const EdgeInsets.only(left: 4.0),
      //     child: Text(
      //       '프로필',
      //       style: kHeaderStyle3,
      //     ),
      //   ),
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.only(right: 4),
      //       child: IconButton(
      //         onPressed: () {
      //           Get.to(() => SettingView());
      //         },
      //         icon: SvgPicture.asset('assets/icons/setting.svg'),
      //       ),
      //     ),
      //   ],
      // ),
      // body: Padding(
      //   padding: const EdgeInsets.only(
      //     right: 20,
      //     left: 20,
      //     top: 16,
      //     bottom: 40,
      //   ),
      //   child: Obx(
      //     () => Column(
      //       crossAxisAlignment: CrossAxisAlignment.stretch,
      //       children: [
      //         Column(
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           children: [
      //             Stack(children: [
      //               ClipOval(
      //                 child: profileController.profile.value.profileImage == ''
      //                     ? SvgPicture.asset(
      //                         'assets/illustrations/default_profile.svg',
      //                         height: 80,
      //                         width: 80,
      //                         fit: BoxFit.cover,
      //                       )
      //                     : CachedNetworkImage(
      //                       imageUrl:
      //                         profileController.profile.value.profileImage,
      //                         height: 80,
      //                         width: 80,
      //                         fit: BoxFit.cover,
      //                       ),
      //               ),
      //               Positioned(
      //                 child: GestureDetector(
      //                     onTap: () {
      //                       showCustomModalPopup(context,
      //                           value1: '라이브러리에서 선택',
      //                           value2: '기본 이미지로 변경',
      //                           func1: changeProfileImage,
      //                           func2: changeDefaultImage);
      //                     },
      //                     child: Container(
      //                       width: 24,
      //                       height: 24,
      //                       child: Center(
      //                         child: SvgPicture.asset(
      //                           'assets/icons/image.svg',
      //                         ),
      //                       ),
      //                       decoration: BoxDecoration(
      //                           border: Border.all(
      //                               color: Color(0xffe7e7e7), width: 1),
      //                           color: kBackgroundWhite,
      //                           shape: BoxShape.circle),
      //                     )),
      //                 left: 56,
      //                 top: 56,
      //               )
      //             ]),
      //             const SizedBox(height: 12),
      //             Text(
      //               '${profileController.profile.value.nickname} / ${profileController.profile.value.age}세 / ${profileController.profile.value.gender.replaceAll('자', '')}',
      //               style: kHeaderStyle1,
      //             ),
      //             const SizedBox(height: 8),
      //             Text(profileController.profile.value.university!,
      //                 style: kSubtitleStyle2),
      //             const SizedBox(height: 8),
      //             (profileController.profile.value.department != '')
      //                 ? Text(profileController.profile.value.department!,
      //                     style: kSubtitleStyle3)
      //                 : Text('아직 학과를 설정하지 않았어요',
      //                     style: kSubtitleStyle3.copyWith(
      //                       color: kMainBlack.withOpacity(0.38),
      //                     )),
      //             const SizedBox(height: 16),
      //           ],
      //         ),
      //         Text(
      //           profileController.profile.value.introduction,
      //           style: kBodyStyle1,
      //           textAlign: TextAlign.start,
      //         ),
      //         const SizedBox(height: 20),
      //         Row(
      //           children: [
      //             Expanded(
      //               child: CustomButtonWidget(
      //                 buttonTitle: '프로필 수정하기',
      //                 buttonState: ButtonState.secondary,
      //                 onTap: () {
      //                   AppController.to.addPage();
      //                   Get.to(() => ProfileUpdate());
      //                 },
      //               ),
      //             ),
      //           ],
      //         ),
      //         const SizedBox(height: 12),
      //         Text('· 프로필 사진이나 학과, 소개를 작성하면 매칭에 도움이 될 거에요.',
      //             style: kSmallCaptionStyle.copyWith(
      //                 color: kMainBlack.withOpacity(0.6)))
      //       ],
      //     ),
      //   ),
      // ),
      body: Obx(
        () => ScrollNoneffectWidget(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(children: [
                  SizedBox(
                    width: Get.width,
                    height: Get.width,
                    child: profileController.profile.value.profileImage != ''?
                             CachedNetworkImage(
                              imageUrl: profileController.profile.value.profileImage
                                  .replaceAll('https', 'http'),
                              fit: BoxFit.cover,
                            )
                        : CachedNetworkImage(
                            imageUrl:
                                'http://media.istockphoto.com/photos/confident-young-man-in-casual-green-shirt-looking-away-standing-with-picture-id1324558913?s=612x612',
                            fit: BoxFit.cover)
                  ),
                  ClipRect(child: ProfileBlur()),
                  if (!profileController.isEdit.value)
                    Positioned(
                        bottom: 0,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 18, left: 20),
                          child: GestureDetector(
                              onTap: () {
                                showCustomModalPopup(context,
                                    value1: '사진 수정하기',
                                    func1: changeProfileImage,
                                    value2: '기본 이미지',
                                    func2: changeDefaultImage);
                              },
                              child: Text('사진 수정하기',
                                  style: k16SemiBold.copyWith(
                                      color: kBackgroundWhite))),
                        )),
                        if (!profileController.isEdit.value)
                    Positioned(top: 16.5 +  profileController.statusBarHeight.value, right: 16.5,child: IconButton(
              onPressed: () {
                Get.to(() => SettingView());
              },
              icon: SvgPicture.asset('assets/icons/setting.svg'),
            ),)
                ]),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/mini_profile.svg',
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            '${profileController.profile.value.nickname} / ${profileController.profile.value.age.toString()} / ${profileController.profile.value.gender}',
                            style: k16SemiBold,
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () async{
                              if (profileController.isEdit.value) {
                                await updateMyProfile(ProfileType.profile, File(''));
                              }
                              profileController.isEdit.value =
                                  !profileController.isEdit.value;
                            },
                            child: profileController.isEdit.value
                                ? Text(
                                    '저장하기',
                                    style: k16SemiBold.copyWith(color: kPrimary),
                                  )
                                : SvgPicture.asset(
                                    'assets/icons/profile_edit.svg',
                                  ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/mini_univ.svg',
                            
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            profileController.profile.value.university!,
                            style: k16SemiBold,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/mini_dept.svg',
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          profileController.isEdit.value
                              ? Expanded(
                                  child: EmptyBackTextfieldWidget(
                                    controller:
                                        profileController.departmentController,
                                    contentPadding: EdgeInsets.zero,
                                    textalign: TextAlign.start,
                                    textStyle: k16Light.copyWith(
                                        height: 1.5, color: kMainBlack),
                                    hinttext: '학과를 입력해주세요',
                                    hintstyle: k16Light.copyWith(
                                        height: 1.5,
                                        color: kMainBlack.withOpacity(0.4)),
                                  ),
                                )
                              : Text(
                                  profileController.profile.value.department != ''
                                      ? profileController
                                          .profile.value.department!
                                      : '-',
                                  style: k16SemiBold,
                                )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        '자기 소개',
                        style: k16Medium,
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      profileController.isEdit.value
                          ? EmptyBackTextfieldWidget(
                              controller: profileController.introController,
                              contentPadding: EdgeInsets.zero,
                              textalign: TextAlign.start,
                              textStyle: k16Light.copyWith(
                                  height: 1.5, color: kMainBlack),
                              hinttext: '자기소개를 입력해주세요',
                              hintstyle: k16Light.copyWith(
                                  height: 1.5,
                                  color: kMainBlack.withOpacity(0.4)),
                            )
                          : Text(
                              profileController.profile.value.introduction == ''
                                  ? '아직 소개글이 없어요'
                                  : profileController.profile.value.introduction,
                              style: k16Light.copyWith(height: 1.5),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void changeProfileImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    print(image);
    if(image != null){
    updateMyProfile(ProfileType.image, File(image.path)).then((value) => Get.back());}
    print('클릭했습니다.');
  }

  void changeDefaultImage() async {
    updateMyProfile(ProfileType.image, null);
  }
}
//사진 수정하기


//네이버 지도 sdk 법적 공지
//오픈 라이선스