import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:universiting/controllers/home_controller.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/utils/global_variable.dart';
import 'package:universiting/widgets/button_widget.dart';
import 'package:universiting/widgets/custom_button_widget.dart';

import '../api/login_api.dart';
import '../constant.dart';
import '../controllers/login_controller.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/background_textfield_widget.dart';
import '../widgets/empty_back_textfield_widget.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: kBackgroundWhite,
          border: Border(
            top: BorderSide(
              width: 1.6,
              color: Color(0xffe7e7e7),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            right: 20,
            left: 20,
            top: 28,
            bottom: 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      HomeController.to.islogin.value = false;
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(
                        Icons.arrow_back_ios_new_sharp,
                        color: kMainBlack,
                      ),
                    ),
                  ),
                  const Text(
                    '로그인',
                    style: kHeaderStyle3,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              BackgroundTextfieldWidget(
                  controller: loginController.emailController,
                  hinttext: '학교 이메일 주소'),
              const SizedBox(
                height: 16,
              ),
              BackgroundTextfieldWidget(
                controller: loginController.passwordController,
                hinttext: '비밀번호',
                obsecure: true,
              ),
              const SizedBox(
                height: 16,
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    '비밀번호를 잊어버렸어요',
                    style: kInActiveButtonStyle.copyWith(
                        color: kMainBlack.withOpacity(0.6)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              CustomButtonWidget(
                buttonTitle: '로그인하기',
                buttonState: ButtonState.primary,
                onTap: () async {
                  String? a = await FlutterSecureStorage()
                      .read(key: loginController.emailController.text);
                  LoginController.to.passwordValidate.value &&
                          LoginController.to.emailValidate.value
                      ? login()
                      : showCustomDialog('이메일 주소 또는 비밀번호를 다시 확인해주세요', 1400);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
