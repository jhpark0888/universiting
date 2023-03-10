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
                        '?????????????????? ??????????????? ????????????',
                        style: kHeaderStyle1,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  FadeTransition(
                    opacity: _animationController.loadValue,
                    child: SlideTransition(
                        position: _animationController.secondOffsetValue,
                        child: Text('?????? ?????? ????????? ???????????? ??????????????????',
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
                                  return '???????????? ???????????? ????????????';
                                }
                              },
                              hinttext: '?????? 8???',
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
                        '???????????? ?????? ??????????????? ??? ????????? ???????????????',
                        style: kBodyStyle2.copyWith(
                            color: kMainBlack.withOpacity(0.4)),
                      ),
                      Text(
                        '???????????? ?????? ???????????? ??????????????????',
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
                    showCustomDialog('???????????? ???????????? ????????????', 1200);
                  } else if (signupController.nameController.text.length >= 8) {
                    showCustomDialog('8??? ????????? ???????????????', 1200);
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
