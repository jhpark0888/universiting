import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../controllers/signup_controller.dart';
import '../utils/global_variable.dart';
import '../views/signup_profile_view.dart';
import '../widgets/appbar_widget.dart';

import '../constant.dart';

class SignupCheckEmailView extends StatelessWidget {
  const SignupCheckEmailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: '회원 가입',
        actions: [
          Obx(
            () => IconButton(
                onPressed: () {
                  if (SignupController.to.isEmailCheck.value) {
                    Get.to(() => SignupProfileView());
                  }
                },
                icon: Text(
                  '다음',
                  style: kStyleAppbar.copyWith(
                      color: SignupController.to.isEmailCheck.value
                          ? Colors.blue
                          : Colors.black.withOpacity(0.6)),
                )),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: height(context) / 20),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                      text: '메일',
                      style: kStyleHeader.copyWith(color: Colors.blue)),
                  const TextSpan(text: '을 확인해주세요', style: kStyleHeader)
                ])),
            SizedBox(height: height(context) / 20),
            Obx(
              () => TextFormField(
                readOnly: true,
                initialValue: SignupController.to.emailController.text +
                    SignupController.to.univLink.value,
                maxLines: 1,
                style: kStyleContent.copyWith(
                    color: Colors.black.withOpacity(0.6)),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(top: Get.height / 100),
                      child: (SignupController.to.isEmailCheck.value)
                          ? SvgPicture.asset(
                              'assets/icons/Check_Active_blue.svg')
                          : Text(
                              '인증중..',
                              style: kStyleContent.copyWith(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 14),
                            ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                        borderSide: const BorderSide(color: Colors.black)),
                    errorBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                        borderSide: const BorderSide(color: Colors.black)),
                    enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                        borderSide: const BorderSide(color: Colors.black))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
