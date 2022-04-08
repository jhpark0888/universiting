import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/utils/check_validator.dart';
import 'package:universiting/views/signup_password_view.dart';
import 'package:universiting/views/signup_profile_view.dart';
import 'package:universiting/widgets/bottombutton.dart';
import 'package:universiting/widgets/signup_bottombutton_widget.dart';
import '../api/signup_api.dart';
import '../constant.dart';
import '../controllers/custom_animation_controller.dart';
import '../controllers/keyboard_controller.dart';
import '../controllers/signup_controller.dart';
import '../utils/global_variable.dart';
import '../views/signup_user_view.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/custom_button_widget.dart';
import '../widgets/empty_back_textfield_widget.dart';

class SignupGenderView extends StatelessWidget {
  SignupGenderView({Key? key, required this.content}) : super(key: key);
  String content;
  final SignupController signupController = Get.find();
  final KeyboardController _keyboardController = Get.find();
  final CustomAnimationController _animationController =
      Get.put(CustomAnimationController(), tag: 'gender');
  // final List mcontents = ['남자인가요?', '남자셨군요!'];
  // final List wcontents = ['여자인가요?', '여자셨군요!'];
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
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: '${signupController.age}살, ',
                                style: kHeaderStyle1.copyWith(color: kPrimary)),
                            TextSpan(text: content, style: kHeaderStyle1)
                          ])),
                        ),
                      ),
                      const SizedBox(height: 10),
                      FadeTransition(
                        opacity: _animationController.loadValue,
                        child: SlideTransition(
                          position: _animationController.secondOffsetValue,
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: signupController.nameController.text,
                                style: kHeaderStyle1.copyWith(color: kPrimary)),
                            const TextSpan(
                                text: '님의 성별을 선택해주세요', style: kHeaderStyle1)
                          ])),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Obx(
                          () => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(children: [
                                  FadeTransition(
                                    opacity: _animationController.loadValue,
                                    child: GestureDetector(
                                      onTap: () {
                                        signupController.isgender.value = 'M';
                                      },
                                      child: SvgPicture.asset(
                                        signupController.isgender.value == 'M'
                                            ? 'assets/illustrations/male_active.svg'
                                            : 'assets/illustrations/male_inactive.svg',
                                        height: 100,
                                        width: 100,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  signupController.isgender.value == 'M'
                                      ? FadeTransition(
                                          opacity:
                                              _animationController.loadValue,
                                          child: Text(
                                            "남성",
                                            style: kSubtitleStyle2.copyWith(
                                                color: kPrimary),
                                          ),
                                        )
                                      : FadeTransition(
                                          opacity:
                                              _animationController.loadValue,
                                          child: Text(
                                            "남성",
                                            style: kSubtitleStyle2.copyWith(
                                                color: kMainBlack
                                                    .withOpacity(0.38)),
                                          ),
                                        ),
                                ]),
                                Column(
                                  children: [
                                    FadeTransition(
                                      opacity: _animationController.loadValue,
                                      child: GestureDetector(
                                        onTap: () {
                                          signupController.isgender.value = 'F';
                                        },
                                        child: SvgPicture.asset(
                                          signupController.isgender.value == 'F'
                                              ? 'assets/illustrations/female_active.svg'
                                              : 'assets/illustrations/female_inactive.svg',
                                          height: 100,
                                          width: 100,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    signupController.isgender.value == 'F'
                                        ? FadeTransition(
                                            opacity:
                                                _animationController.loadValue,
                                            child: Text(
                                              "여성",
                                              style: kSubtitleStyle2.copyWith(
                                                  color: kPrimary),
                                            ),
                                          )
                                        : FadeTransition(
                                            opacity:
                                                _animationController.loadValue,
                                            child: Text(
                                              "여성",
                                              style: kSubtitleStyle2.copyWith(
                                                  color: kMainBlack
                                                      .withOpacity(0.38)),
                                            ),
                                          ),
                                  ],
                                )
                              ]),
                        ),
                      ),
                    ]),
              ),
            ),
            Obx(
              () => SignupButtonWidget(
                  onTap: () {
                    if (signupController.isgender.isNotEmpty) {
                      Get.to(() => SignupPasswordView(),
                          transition: Transition.noTransition);
                    }
                  },
                  isback: true,
                  isButtonActive: signupController.isgender.isNotEmpty,
                  signuptype: 'gender'),
            ),
          ],
        ),
      ),
    );
  }
}
