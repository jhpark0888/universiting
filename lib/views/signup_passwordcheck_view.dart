import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/utils/check_validator.dart';
import 'package:universiting/views/signup_email_validate_view.dart';
import 'package:universiting/views/signup_gender_view.dart';
import 'package:universiting/views/signup_profile_view.dart';
import 'package:universiting/widgets/bottombutton.dart';
import '../api/signup_api.dart';
import '../constant.dart';
import '../controllers/signup_controller.dart';
import '../utils/global_variable.dart';
import '../views/signup_user_view.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/textformfield_widget.dart';

class SignupPasswordCheckView extends StatelessWidget {
  SignupPasswordCheckView({Key? key}) : super(key: key);

  SignupController signupController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(
            20, 64, 20, 0),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('이제 거의 끝나가요.', style: kHeaderStyle1),
            SizedBox(
              height: Get.width / 30,
            ),
            const Text('사용할 비밀번호를 입력해주세요.', style: kHeaderStyle1),
            SizedBox(height: Get.height / 20),
            Form(
              child: CustomTextFormField(
                obsecuretext: true,
                controller: signupController.passwordCheckController,
                hinttext: '비밀번호 확인',
              ),
            ),
            Expanded(
              child: Stack(children: [
                Positioned(
                  bottom: Get.width / 15,
                  right: Get.width / 20,
                  child: GestureDetector(
                    onTap: () {
                      if(signupController.passwordCheckController.text != signupController.passwordController.text){
                        showCustomDialog('비밀번호가 일치하지 않아요', 1200);
                      }else{
                        Get.to(()=> SignupEmailValidateView());
                      }
                    },
                    child: Obx(
                      () => BottomButtonWidget(
                          color: signupController.isage.value
                              ? kPrimary
                              : kPrimary),
                    ),
                  ),
                ),
                Positioned(
                  bottom: Get.width / 15,
                  left: Get.width / 20,
                  child: GestureDetector(
                    onTap: () async {
                      Get.back();
                    },
                    child: Obx(
                      () => BottomButtonWidget(
                        widget: Icon(Icons.arrow_back, color: Colors.blue,),
                          color: signupController.isage.value
                              ? kPrimary
                              : kPrimary),
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
