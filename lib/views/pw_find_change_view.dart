import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/api/profile_api.dart';
import 'package:universiting/controllers/custom_animation_controller.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/controllers/pw_find_controller.dart';
import 'package:universiting/utils/check_validator.dart';
import 'package:universiting/views/signup_email_validate_view.dart';
import 'package:universiting/views/signup_gender_view.dart';
import 'package:universiting/views/signup_passwordcheck_view.dart';
import 'package:universiting/views/signup_profile_view.dart';
import 'package:universiting/widgets/bottombutton.dart';
import 'package:universiting/widgets/signup_bottombutton_widget.dart';
import '../api/signup_api.dart';
import '../constant.dart';
import '../controllers/signup_controller.dart';
import '../utils/global_variable.dart';
import '../views/signup_user_view.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/empty_back_textfield_widget.dart';

class PwFindChangeView extends StatelessWidget {
  PwFindChangeView({Key? key}) : super(key: key);

  PwController pwController = Get.find();
  final CustomAnimationController _animationController =
      Get.put(CustomAnimationController(), tag: 'pw');

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeTransition(
                        opacity: _animationController.loadValue,
                        child: SlideTransition(
                          position: _animationController.offsetValue,
                          child: const Text(
                            '인증이 완료되었어요',
                            style: kHeaderStyle1,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => FadeTransition(
                          opacity: _animationController.loadValue,
                          child: SlideTransition(
                            position: _animationController.offsetValue,
                            child: Text(
                                !pwController.isPasswordCheck.value
                                    ? '새로운 비밀번호를 입력해주세요'
                                    : '다시 한 번 비밀번호를 입력해주세요',
                                style: kHeaderStyle1),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Obx(
                        () => Form(
                          child: EmptyBackTextfieldWidget(
                            maxLines: 1,
                            controller: pwController.isPasswordCheck.value
                                ? pwController.newpwCheckController
                                : pwController.newpwController,
                            obsecuretext: true,
                            hinttext: pwController.isPasswordCheck.value
                                ? '비밀번호 확인'
                                : '비밀번호 6자 이상',
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
            Obx(
              () => !pwController.isPasswordCheck.value
                  ? SignupButtonWidget(
                      onTap: () async {
                        if (!pwController.isPasswordCheck.value &&
                            pwController.isPasswordlength.value) {
                          pwController.isPasswordCheck(true);
                        }
                      },
                      isback: true,
                      isButtonActive: pwController.isPasswordlength.value,
                      signuptype: 'pw')
                  : SignupButtonWidget(
                      onTap: () async {
                        if (pwController.newpwCheckController.text !=
                            pwController.newpwController.text) {
                          showCustomDialog('비밀번호가 일치하지 않아요', 1200);
                        } else {
                          pwfindchange();
                        }
                      },
                      onBack: () async {
                        pwController.isPasswordCheck(false);
                      },
                      isback: true,
                      nextword: '비밀번호 변경하기',
                      isButtonActive: pwController.isPasswordchecklength.value,
                      signuptype: 'pw'),
            ),
          ],
        ),
      ),
    );
  }
}
