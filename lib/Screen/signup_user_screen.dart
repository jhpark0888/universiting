import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/Api/signup_api.dart';
import 'package:universiting/Screen/signup_check_email_screen.dart';
import 'package:universiting/Screen/signup_profile_screen.dart';
import 'package:universiting/controller/signup_controller.dart';
import 'package:universiting/function/check_validator.dart';
import 'package:universiting/function/global_variable.dart';
import 'package:universiting/widget/appbar_widget.dart';
import 'package:universiting/widget/textformfield_widget.dart';

class SignupUserScreen extends StatelessWidget {
  SignupUserScreen({Key? key}) : super(key: key);
  SignupController signupController = Get.find();
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: '회원 가입',
        actions: [
          IconButton(
              onPressed: () async {
                if (_key.currentState!.validate()) {
                  resultOfConnection().then(
                    (value) {
                      if(value){
                      checkEmail();
                      Get.to(() => SignupCheckEmailScreen());}
                      else{showCustomDialog('네트워크를 확인해주세요', 3000);}
                    },
                  );
                }
              },
              icon: Text('다음',
                  style: _key.currentState?.validate() != null &&
                          _key.currentState?.validate() == true
                      ? TstyleAppbar.copyWith(color: Colors.blue)
                      : TstyleAppbar.copyWith(
                          color: Colors.black.withOpacity(0.6))))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: height(context) / 20),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: '계정',
                          style: TstyleHeader.copyWith(color: Colors.blue)),
                      const TextSpan(text: '을 만들어주세요', style: TstyleHeader)
                    ]),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: height(context) / 20),
                  Text(
                    '${signupController.universityController.text} 이메일 주소',
                    style: TstyleContent.copyWith(fontSize: 14),
                    textAlign: TextAlign.start,
                  ),
                  Row(children: [
                    Expanded(
                        child: CustomTextFormField(
                            controller: signupController.emailController)),
                    Text(signupController.univLink.value)
                  ]),
                  SizedBox(height: height(context) / 20),
                  Text(
                    '비밀번호',
                    style: TstyleContent.copyWith(fontSize: 14),
                    textAlign: TextAlign.start,
                  ),
                  CustomTextFormField(
                    controller: signupController.passwordController,
                    obsecuretext: true,
                    validator: ((value) =>
                        CheckValidate().validatePassword(value!)),
                  ),
                  SizedBox(height: height(context) / 20),
                  Text(
                    '비밀번호 확인',
                    style: TstyleContent.copyWith(fontSize: 14),
                    textAlign: TextAlign.start,
                  ),
                  CustomTextFormField(
                    controller: signupController.passwordCheckController,
                    obsecuretext: true,
                    validator: ((value) =>
                        CheckValidate().validatePasswordCheck(value!)),
                  ),
                  SizedBox(height: height(context) / 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
