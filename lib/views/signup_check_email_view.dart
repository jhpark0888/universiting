import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/Api/signup_api.dart';
import 'package:universiting/utils/check_validator.dart';
import 'package:universiting/views/signup_check_email_view.dart';
import 'package:universiting/views/signup_gender_view.dart';
import 'package:universiting/views/signup_profile_view.dart';
import 'package:universiting/widgets/bottombutton.dart';
import '../constant.dart';
import '../controllers/signup_controller.dart';
import '../utils/global_variable.dart';
import '../views/signup_user_view.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/textformfield_widget.dart';

class SignupCheckEmailView extends StatelessWidget {
  SignupCheckEmailView({Key? key}) : super(key: key);

  SignupController signupController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(
            Get.width / 20, Get.width / 6, Get.width / 20, 0),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('이제 마지막이에요!.', style: kStyleHeader),
            SizedBox(
              height: Get.width / 30,
            ),
            const Text('학교 이메일 인증을 해주세요.', style: kStyleHeader),
            SizedBox(height: Get.height / 30),
            Text('대학생만 이용할 수 있게 하기 위한 절차에요. 번거로우시더라도 양해 부탁드려요',
                style: kStyleContent.copyWith(
                    color: Colors.black.withOpacity(0.6))),
            SizedBox(height: Get.width / 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: Get.width / 3,
                  child: CustomTextFormField(
                    textalign: TextAlign.start,
                    controller: signupController.emailController,
                    hinttext: '학교 이메일',
                  ),
                ),
                Text(
                  '@${signupController.uni.value.email}',
                  style:
                      kStyleHeader.copyWith(color: mainblack.withOpacity(0.6)),
                )
              ],
            ),
            Expanded(
              child: Stack(children: [
                Positioned(
                  bottom: Get.width / 15,
                  right: Get.width / 20,
                  child: Obx(
                    () => GestureDetector(
                      onTap: () async{
                        if (signupController.isEmail.value == true &&
                            signupController.isEmailPress.value == false &&
                            signupController.isEmailCheck.value == false) {
                          signupController.isEmailPress.value = true;
                        }else if(signupController.isEmail.value == true &&
                        signupController.isEmailPress.value == true){
                          await checkEmail();
                        }
                      },
                      child: BottomButtonWidget(
                          widget: (signupController.isEmail.value == true
                              // signupController.isEmailPress.value ==
                              //     false &&
                              // signupController.isEmailCheck.value ==
                              //     false
                              )
                              ? signupController.isEmailPress.value == false
                                  ? Text(
                                      '인증 메일 보내기',
                                      style: kStyleDiolog.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: signupController
                                                  .isEmail.value
                                              ? Colors.white
                                              : mainblack.withOpacity(0.38)),
                                    )
                                  : signupController.isSendEmail.value
                                      ? signupController.isEmailCheck.value
                                          ? Text(
                                              '끝났어요!',
                                              style: kStyleButton,
                                            )
                                          : Text('인증 대기중',
                                              style: kStyleDiolog.copyWith(
                                                  fontWeight:
                                                      FontWeight.w600, color: mainblack.withOpacity(0.38)))
                                      : Icon(
                                          Icons.restart_alt,
                                          color: Colors.white,
                                        )
                              : Text(
                                  '인증 메일 보내기',
                                  style: kStyleDiolog.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: signupController.isEmail.value
                                          ? Colors.white
                                          : mainblack.withOpacity(0.38)),
                                ),
                          width: Get.width / 3,
                          height: Get.width / 8,
                          color: signupController.isEmail.value
                              ? signupController.isEmailPress.value
                                  ? signupController.isSendEmail.value
                                      ? signupController.isEmailCheck.value
                                          ? mainblack
                                          : Color(0xffe7e7e7)
                                      : mainblack
                                  : mainblack
                              : Color(0xffe7e7e7)),
                    ),
                  ),
                ),
                Positioned(
                  bottom: Get.width / 15,
                  left: Get.width / 20,
                  child: GestureDetector(
                    onTap: () async {
                      await checkEmail();
                    },
                    child: Obx(
                      () => (signupController.isEmail.value == true &&
                              signupController.isEmailPress.value == true &&
                              signupController.isSendEmail.value == true)
                          ? BottomButtonWidget(
                              widget: Text('다시 보내기',
                                  style: kStyleDiolog.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white)),
                              width: Get.width / 3,
                              height: Get.width / 8,
                              color: Color(0xff939393))
                          : Container(),
                    ),
                  ),
                )
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
