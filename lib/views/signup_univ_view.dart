import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:universiting/api/signup_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/custom_animation_controller.dart';
import 'package:universiting/controllers/keyboard_controller.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/views/signup_name_view.dart';
import 'package:universiting/widgets/bottombutton.dart';
import 'package:universiting/widgets/custom_button_widget.dart';
import 'package:universiting/widgets/signup_bottombutton_widget.dart';
import '../controllers/signup_controller.dart';
import '../utils/global_variable.dart';
import '../views/signup_department_view.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/empty_back_textfield_widget.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class SignupUnivView extends StatelessWidget {
  SignupUnivView({Key? key}) : super(key: key);
  SignupController signupController = Get.put(SignupController());
  final KeyboardController _keyboardController = Get.put(KeyboardController());
  final CustomAnimationController _animationController =
      Get.put(CustomAnimationController(), tag: 'univ');
  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 80, 30, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FadeTransition(
                      opacity: _animationController.loadValue,
                      child: SlideTransition(
                        position: _animationController.offsetValue,
                        child: Text(
                          '유니버시팅은 대학생 전용 공간이에요.',
                          style: kHeaderStyle1,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    FadeTransition(
                      opacity: _animationController.loadValue,
                      child: SlideTransition(
                          position: _animationController.secondOffsetValue,
                          child: Text('재학중인 대학이 어디신가요?', style: kHeaderStyle1)),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: FadeTransition(
                            opacity: _animationController.loadValue,
                            child: SlideTransition(
                              position: _animationController.secondOffsetValue,
                              child: EmptyBackTextfieldWidget(
                                controller:
                                    signupController.universityController,
                                hinttext: '대학교 이름',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: Text(
                      '대학 인증을 위해 정확한 정보를 입력해주세요',
                      style: kBodyStyle2.copyWith(
                          color: kMainBlack.withOpacity(0.4)),
                    )),
                    Expanded(
                      child: Obx(
                        () => ListView(
                            shrinkWrap: true,
                            children: signupController.univSearchList
                                .map((element) => GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        signupController.universityController
                                            .text = element;
                                        // Get.to(() => SignupNameView(),
                                        //     transition:
                                        //         Transition.noTransition);
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 20,
                                            ),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    element,
                                                    style: kBodyStyle2,
                                                  ),
                                                  SvgPicture.asset(
                                                      'assets/icons/check_nactive.svg'),
                                                  // Container(
                                                  //   height: 30,
                                                  //   width: 30,
                                                  //   decoration: BoxDecoration(
                                                  //       color: kMainBlack
                                                  //           .withOpacity(0.6),
                                                  //       borderRadius:
                                                  //           BorderRadius
                                                  //               .circular(30)),
                                                  // )
                                                ]),
                                          ),
                                          const Divider(
                                            color: Color(0xffe7e7e7),
                                          ),
                                        ],
                                      ),
                                    ))
                                .toList()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Obx(
              () => SignupButtonWidget(
                  onTap: () async {
                    if (signupController.isUniv.value) {
                      signupController.selectuniv(
                          signupController.universityController.text);
                      print(signupController.uni.value.email);
                      // await getDepartList(
                      //     signupController.uni.value.id);
                      Get.to(() => SignupNameView(),
                          transition: Transition.noTransition);
                    } else {
                      showCustomDialog('재학중인 대학을 선택해주세요', 1200);
                    }
                  },
                  isback: true,
                  isButtonActive: signupController.isUniv.value,
                  signuptype: 'univ'),
            ),
          ],
        ),
      ),
    );
  }
}

class UniversityWidget extends StatelessWidget {
  UniversityWidget({Key? key, required this.univ}) : super(key: key);
  String univ;
  RxBool isselected = false.obs;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        SignupController.to.universityController.text = univ;
        // Get.to(() => SignupNameView(),
        //     transition:
        //         Transition.noTransition);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    univ,
                    style: kBodyStyle2,
                  ),
                  Obx(
                    () => isselected.value == false
                        ? SvgPicture.asset('assets/icons/check_nactive.svg')
                        : SvgPicture.asset('assets/icons/check_active.svg'),
                  )
                  // Container(
                  //   height: 30,
                  //   width: 30,
                  //   decoration: BoxDecoration(
                  //       color: kMainBlack
                  //           .withOpacity(0.6),
                  //       borderRadius:
                  //           BorderRadius
                  //               .circular(30)),
                  // )
                ]),
          ),
          const Divider(
            color: Color(0xffe7e7e7),
          ),
        ],
      ),
    );
  }
}
