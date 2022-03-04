import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/login_api.dart';
import '../constant.dart';
import '../controllers/login_controller.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/textformfield_widget.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key, required this.isSignup}) : super(key: key);
  LoginController loginController = Get.put(LoginController());
  bool isSignup;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          title: '로그인',
          leading: isSignup
              ? IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Get.back();
                  },
                )
              : null),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '학교 이메일 주소',
                style: TstyleContent,
                textAlign: TextAlign.start,
              ),
              CustomTextFormField(controller: loginController.emailController),
              SizedBox(
                height: Get.height / 20,
              ),
              Text(
                '비밀번호',
                style: TstyleContent,
                textAlign: TextAlign.start,
              ),
              CustomTextFormField(
                  controller: loginController.passwordController),
              SizedBox(height: Get.height / 15),
              ElevatedButton(
                  onPressed: () async {
                    await login();
                  },
                  child: Text('로그인'))
            ],
          ),
        ),
      ),
    );
  }
}
