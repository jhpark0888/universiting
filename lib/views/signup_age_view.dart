import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/utils/check_validator.dart';
import 'package:universiting/views/signup_gender_view.dart';
import 'package:universiting/views/signup_profile_view.dart';
import 'package:universiting/widgets/bottombutton.dart';
import 'package:universiting/widgets/signup_bottombutton_widget.dart';
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
  // final KeyboardController _keyboardController = Get.find();
  final CustomAnimationController _animationController =
      Get.put(CustomAnimationController(), tag: 'age');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                SizedBox(height: 10),
                FadeTransition(
                  opacity: _animationController.loadValue,
                  child: SlideTransition(
                      position: _animationController.secondOffsetValue,
                      child: Text('본인의 생일을 입력해주세요', style: kHeaderStyle1)),
                ),
                SizedBox(
                  height: 40,
                ),
                Obx(
                  () => InkWell(
                    onTap: () {
                      showdatepicker(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FadeTransition(
                          opacity: _animationController.loadValue,
                          child: SlideTransition(
                              position: _animationController.secondOffsetValue,
                              child: Text(
                                '${signupController.birthdate.value.year.toString()}년',
                                style: kHeaderStyle2,
                              )),
                        ),
                        FadeTransition(
                          opacity: _animationController.loadValue,
                          child: SlideTransition(
                            position: _animationController.secondOffsetValue,
                            child: Text(
                                '${signupController.birthdate.value.month.toString()}월',
                                style: kHeaderStyle2),
                          ),
                        ),
                        FadeTransition(
                          opacity: _animationController.loadValue,
                          child: SlideTransition(
                            position: _animationController.secondOffsetValue,
                            child: Text(
                                '${signupController.birthdate.value.day.toString()}일',
                                style: kHeaderStyle2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SignupButtonWidget(
            onTap: () async {
              Get.to(
                  () => SignupGenderView(
                        content: signupController.checkAge(),
                      ),
                  transition: Transition.noTransition);
            },
            isback: true,
            isButtonActive: true,
            signuptype: 'age'),
      ]),
    );
  }
}
