
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:universiting/utils/global_variable.dart';
import 'package:universiting/widgets/button_widget.dart';

import '../api/login_api.dart';
import '../constant.dart';
import '../controllers/login_controller.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/textformfield_widget.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: kMainWhite),
          height: Get.width / 1,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                Get.width / 20, Get.width / 15, Get.width / 20, Get.width / 9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  '로그인',
                  style: kHeaderStyle2,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: Get.width / 20),
                // TextFormField(
                //     controller: LoginController.to.emailController,
                //     decoration: InputDecoration(
                //         isDense: true,
                //         contentPadding: EdgeInsets.all(Get.width / 30),
                //         fillColor: const Color(0xffF4F4F4),
                //         filled: true,
                //         hintText: '학교 이메일 주소',
                //         hintStyle: kBodyStyle2.copyWith(
                //           color: kMainBlack.withOpacity(0.38),
                //         ),
                //         enabledBorder: const OutlineInputBorder(
                //             borderRadius: BorderRadius.all(Radius.circular(16))),
                //         focusedBorder: const OutlineInputBorder(
                //           borderRadius: BorderRadius.all(Radius.circular(16)),
                //           borderSide: BorderSide(color: Color(0x00000000)),
                //         ))),
                CustomTextFormField(controller: loginController.emailController, hinttext: '학교 이메일 주소'),
                SizedBox(height: Get.width / 30),
                CustomTextFormField(controller: loginController.passwordController, hinttext: '비밀번호', obsecure: true,),
                SizedBox(height: Get.height / 30),
                Center(
                    child: Text(
                  '비밀번호를 잊어버렸어요',
                  style: kBodyStyle2.copyWith(
                      color: kMainBlack.withOpacity(0.6)),
                )),
                SizedBox(
                  height: Get.height / 30,
                ),
                GestureDetector(
                  onTap: () async {
                    String? a = await FlutterSecureStorage().read(key: loginController.emailController.text);
                    LoginController.to.passwordValidate.value &&
                            LoginController.to.emailValidate.value
                        ? login()
                        : showCustomDialog('이메일 주소 또는 비밀번호를 다시 확인해주세요', 1400);
                  },
                  // child: Container(
                  //     decoration: BoxDecoration(
                  //         color: LoginController.to.passwordValidate.value &&
                  //                 LoginController.to.emailValidate.value
                  //             ? kMainBlack
                  //             : const Color(0xffE7E7E7),
                  //         borderRadius: BorderRadius.circular(16)),
                  //     child: Padding(
                  //       padding: EdgeInsets.all(Get.width / 30),
                  //       child: Text(
                  //         '로그인하기',
                  //         style: kActiveButtonStyle.copyWith(
                  //             color: LoginController.to.passwordValidate.value &&
                  //                     LoginController.to.emailValidate.value
                  //                 ? Colors.white
                  //                 : Colors.white.withOpacity(0.38)),
                  //         textAlign: TextAlign.center,
                  //       ),
                  //     )),
                  child: PrimaryButton(text: '로그인하기',backColor: kPrimary),
                )
              ],
            ),
          ),
        ),
      );
  }
}
