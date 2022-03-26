import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/utils/check_validator.dart';
import 'package:universiting/views/signup_gender_view.dart';
import 'package:universiting/views/signup_profile_view.dart';
import 'package:universiting/widgets/bottombutton.dart';
import '../api/signup_api.dart';
import '../constant.dart';
import '../controllers/custom_animation_controller.dart';
import '../controllers/keyboard_controller.dart';
import '../controllers/signup_controller.dart';
import '../utils/global_variable.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/custom_button_widget.dart';
import '../widgets/empty_back_textfield_widget.dart';

class SignupAgeView extends StatelessWidget {
  SignupAgeView({Key? key}) : super(key: key);

  SignupController signupController = Get.find();
  final KeyboardController _keyboardController = Get.find();
  final CustomAnimationController _animationController =
      Get.put(CustomAnimationController(), tag: 'age');
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
                    child: RichText(
                        text: TextSpan(children: [
                      const TextSpan(text: '안녕하세요 ', style: kHeaderStyle1),
                      TextSpan(
                          text: signupController.nameController.text,
                          style: kHeaderStyle1.copyWith(color: kPrimary)),
                      const TextSpan(text: '님,', style: kHeaderStyle1)
                    ])),
                  ),
                ),
                SizedBox(height: 12),
                FadeTransition(
                  opacity: _animationController.loadValue,
                  child: SlideTransition(
                      position: _animationController.secondOffsetValue,
                      child: Text('혹시... 나이가 어떻게 되시나요?', style: kHeaderStyle1)),
                ),
                Obx(
                  () => AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    curve: Curves.easeInOut,
                    height: _keyboardController.isVisible.value ? 100 : 140,
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: FadeTransition(
                            opacity: _animationController.loadValue,
                            child: SlideTransition(
                              position: _animationController.secondOffsetValue,
                              child: EmptyBackTextfieldWidget(
                                textInputType: TextInputType.number,
                                controller: signupController.yearController,
                                hinttext: '년',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: FadeTransition(
                            opacity: _animationController.loadValue,
                            child: SlideTransition(
                              position: _animationController.secondOffsetValue,
                              child: EmptyBackTextfieldWidget(
                                textInputType: TextInputType.number,
                                controller: signupController.monthController,
                                hinttext: '월',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: FadeTransition(
                            opacity: _animationController.loadValue,
                            child: SlideTransition(
                              position: _animationController.secondOffsetValue,
                              child: EmptyBackTextfieldWidget(
                                textInputType: TextInputType.number,
                                controller: signupController.dayController,
                                hinttext: '일',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      '예 2000/11/30',
                      style: kSmallCaptionStyle.copyWith(
                        color: kMainBlack.withOpacity(0.6),
                      ),
                    ),
                  ],
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
                    if (signupController.yearController.text.isNotEmpty & signupController.monthController.text.isNotEmpty & signupController.dayController.text.isNotEmpty) {
                      Get.to(
                          () => SignupGenderView(
                                content: signupController.checkAge(),
                              ),
                          transition: Transition.noTransition);
                    } else {
                      showCustomDialog('나이를 입력해주세요', 1200);
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
