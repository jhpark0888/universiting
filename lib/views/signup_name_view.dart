import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/utils/check_validator.dart';
import 'package:universiting/views/signup_age_view.dart';
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
        resizeToAvoidBottomInset: false,
        body: Column(children: [
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
                        '유니버시팅은 개인정보를 보호해요',
                        style: kHeaderStyle1,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  FadeTransition(
                    opacity: _animationController.loadValue,
                    child: SlideTransition(
                        position: _animationController.secondOffsetValue,
                        child: Text('실명 대신 특별한 닉네임을 입력해주세요',
                            style: kHeaderStyle1)),
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
                              controller: signupController.nameController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '아무것도 입력하지 않았어요';
                                }
                              },
                              hinttext: '최대 8자',
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '닉네임을 통해 유니버시팅 내 활동이 이루어져요',
                        style: kBodyStyle2.copyWith(
                            color: kMainBlack.withOpacity(0.4)),
                      ),
                      Text(
                        '기억하기 쉬운 닉네임을 설정해주세요',
                        style: kBodyStyle2.copyWith(
                            color: kMainBlack.withOpacity(0.4)),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Obx(
            () => SignupButtonWidget(
                onTap: () async {
                  if (signupController.nameController.text.isEmpty) {
                    showCustomDialog('아무것도 입력하지 않았어요', 1200);
                  } else if (signupController.nameController.text.length >= 8) {
                    showCustomDialog('8자 이하로 적어주세요', 1200);
                  } else {
                    checkNickName();
                  }
                },
                isback: true,
                isButtonActive: signupController.isname.value,
                signuptype: 'name'),
          ),
        ]),
      ),
    );
  }
}
