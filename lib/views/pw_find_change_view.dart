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
                            '????????? ??????????????????',
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
                                    ? '????????? ??????????????? ??????????????????'
                                    : '?????? ??? ??? ??????????????? ??????????????????',
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
                                ? '???????????? ??????'
                                : '???????????? 6??? ??????',
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
                          showCustomDialog('??????????????? ???????????? ?????????', 1200);
                        } else {
                          pwfindchange();
                        }
                      },
                      onBack: () async {
                        pwController.isPasswordCheck(false);
                      },
                      isback: true,
                      nextword: '???????????? ????????????',
                      isButtonActive: pwController.isPasswordchecklength.value,
                      signuptype: 'pw'),
            ),
          ],
        ),
      ),
    );
  }
}
