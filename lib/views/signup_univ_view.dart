import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

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
        body: Stack(children: [
          Padding(
            padding: const EdgeInsets.only(
              right: 20,
              left: 20,
              top: 64,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FadeTransition(
                  opacity: _animationController.loadValue,
                  child: SlideTransition(
                    position: _animationController.offsetValue,
                    child: Text(
                      '여긴 대학생들을 위한 공간이에요.',
                      style: kHeaderStyle1,
                    ),
                  ),
                ),
                SizedBox(height: 12),
                FadeTransition(
                  opacity: _animationController.loadValue,
                  child: SlideTransition(
                      position: _animationController.secondOffsetValue,
                      child:
                          Text('현재 다니고 계시는 학교가 어디신가요?', style: kHeaderStyle1)),
                ),
                Obx(
                  () => AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    curve: Curves.easeInOut,
                    height: _keyboardController.isVisible.value ? 100 : 140,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: FadeTransition(
                        opacity: _animationController.loadValue,
                        child: SlideTransition(
                          position: _animationController.secondOffsetValue,
                          child: EmptyBackTextfieldWidget(
                            controller: signupController.universityController,
                            hinttext: '학교 이름',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Obx(
                    () => ListView(
                        shrinkWrap: true,
                        children: signupController.univSearchList
                            .map((element) => GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    signupController.universityController.text =
                                        element;
                                    Get.to(() => SignupNameView(),
                                        transition: Transition.noTransition);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                        ),
                                        child: Text(
                                          element,
                                          style: kBodyStyle2,
                                        ),
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
          Obx(
            () => AnimatedPositioned(
              duration: Duration(milliseconds: 400),
              curve: Curves.easeIn,
              bottom: _keyboardController.isVisible.value ? 20 : 60,
              right: 20,
              child: FadeTransition(
                opacity: _animationController.loadValue,
                child: CustomButtonWidget(
                  onTap: () async {
                    if (signupController.isUniv.value) {
                      signupController.selectuniv(
                          signupController.universityController.text);
                      // print(signupController.uni.value.id);
                      // await getDepartList(
                      //     signupController.uni.value.id);
                      Get.to(() => SignupNameView(),
                          transition: Transition.noTransition);
                    } else {
                      showCustomDialog('다니고 계시는 학교를 선택해주세요', 1200);
                    }
                  },
                  buttonState: ButtonState.primary,
                  buttonTitle: '다음',
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
