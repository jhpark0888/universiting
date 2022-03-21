import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/utils/check_validator.dart';
import 'package:universiting/views/signup_age_view.dart';
import 'package:universiting/views/signup_profile_view.dart';
import 'package:universiting/widgets/bottombutton.dart';
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

class SignupNameView extends StatelessWidget {
  SignupNameView({Key? key}) : super(key: key);

  SignupController signupController = Get.find();
  final KeyboardController _keyboardController = Get.find();
  final CustomAnimationController _animationController =
      Get.put(CustomAnimationController(), tag: 'name');
  final _key = GlobalKey<FormState>();
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
                      '좋아요!',
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
                          Text('친구들이 당신을 뭐라고 불러야할까요?', style: kHeaderStyle1)),
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
                            controller: signupController.nameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return '아무것도 입력하지 않았어요';
                              }
                            },
                            hinttext: '최대 8자',
                          ),
                        ),
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
                    if (signupController.nameController.text.isEmpty) {
                      showCustomDialog('아무것도 입력하지 않았어요', 1200);
                    } else if (signupController.nameController.text.length >=
                        8) {
                      showCustomDialog('8자 이하로 적어주세요', 1200);
                    } else {
                      checkNickName();
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
