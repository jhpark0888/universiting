import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/api/profile_api.dart';
import 'package:universiting/api/signup_api.dart';
import 'package:universiting/app.dart';
import 'package:universiting/controllers/custom_animation_controller.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/controllers/pw_find_controller.dart';
import 'package:universiting/utils/check_validator.dart';
import 'package:universiting/views/home_view.dart';
import 'package:universiting/views/signup_email_validate_view.dart';
import 'package:universiting/views/signup_gender_view.dart';
import 'package:universiting/views/signup_profile_view.dart';
import 'package:universiting/views/signup_success_view.dart';
import 'package:universiting/widgets/bottombutton.dart';
import 'package:universiting/widgets/signup_bottombutton_widget.dart';
import '../constant.dart';
import '../controllers/signup_controller.dart';
import '../utils/global_variable.dart';
import '../views/signup_user_view.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/empty_back_textfield_widget.dart';

class PwFindView extends StatelessWidget {
  PwFindView({Key? key}) : super(key: key);

  final PwController _pwController = Get.put(PwController());

  final CustomAnimationController _animationController =
      Get.put(CustomAnimationController(), tag: 'pwfind');

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: Obx(
        () => Stack(
          children: [
            Scaffold(
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
                                child: const Text('본인 인증을 위해',
                                    style: kHeaderStyle1),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            FadeTransition(
                              opacity: _animationController.loadValue,
                              child: SlideTransition(
                                position: _animationController.offsetValue,
                                child: const Text('학교 이메일 인증을 완료해주세요.',
                                    style: kHeaderStyle1),
                              ),
                            ),
                            const SizedBox(height: 40),
                            EmptyBackTextfieldWidget(
                              textalign: TextAlign.center,
                              controller: _pwController.emailController,
                              hinttext: '본인 대학 이메일 아이디',
                              textInputType: TextInputType.emailAddress,
                              maxLines: 1,
                            ),
                            Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Column(
                                  children: [
                                    Text('본인 인증을 위해 본인의 대학 메일 주소를 입력해주세요',
                                        style: kBodyStyle2.copyWith(
                                            color: kPrimary)),
                                    Text(
                                      '본인 인증이 완료되어야 비밀번호를 변경할 수 있습니다',
                                      style: kBodyStyle2.copyWith(
                                          color: kMainBlack.withOpacity(0.4)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  Obx(
                    () => SignupButtonWidget(
                        onTap: () async {
                          if (_pwController.emailcheckstate.value ==
                              EmailCheckState.fill) {
                            _pwController
                                .emailcheckstate(EmailCheckState.loading);
                            await Future.delayed(Duration(seconds: 2));
                            await pwfindemailcheck();
                          }
                        },
                        onBack: () async {
                          if (_pwController.emailcheckstate.value ==
                              EmailCheckState.waiting) {
                            _pwController
                                .emailcheckstate(EmailCheckState.loading);
                            await Future.delayed(Duration(seconds: 2));
                            await pwfindemailcheck();
                          } else {
                            Get.back();
                          }
                        },
                        isback: true,
                        isButtonActive: _pwController.emailcheckstate.value ==
                                EmailCheckState.empty
                            ? false
                            : true,
                        backword: _pwController.emailcheckstate.value ==
                                EmailCheckState.waiting
                            ? '다시 보내기'
                            : '이전',
                        nextword: _pwController.emailcheckstate.value ==
                                EmailCheckState.waiting
                            ? '인증 대기중'
                            : '인증 메일 보내기',
                        signuptype: 'pwfind'),
                  ),
                ],
              ),
            ),
            if (_pwController.emailcheckstate.value == EmailCheckState.loading)
              Container(
                height: Get.height,
                width: Get.width,
                color: kMainBlack.withOpacity(0.3),
                child: Image.asset(
                  'assets/icons/loading.gif',
                  scale: 8,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
