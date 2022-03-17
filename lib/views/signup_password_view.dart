import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/utils/check_validator.dart';
import 'package:universiting/views/signup_email_validate_view.dart';
import 'package:universiting/views/signup_gender_view.dart';
import 'package:universiting/views/signup_passwordcheck_view.dart';
import 'package:universiting/views/signup_profile_view.dart';
import 'package:universiting/widgets/bottombutton.dart';
import '../api/signup_api.dart';
import '../constant.dart';
import '../controllers/signup_controller.dart';
import '../utils/global_variable.dart';
import '../views/signup_user_view.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/textformfield_widget.dart';

class SignupPasswordView extends StatelessWidget {
  SignupPasswordView({Key? key}) : super(key: key);

  SignupController signupController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 64, 20, 0),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('이제 거의 끝나가요.', style: kHeaderStyle2),
            const SizedBox(
              height: 12,
            ),
            const Text('사용할 비밀번호를 입력해주세요.', style: kHeaderStyle2),
            SizedBox(height: Get.height / 20),
            Obx(
              () => Form(
                child: SignUpTextFormField(
                  controller: signupController.isPasswordCheck.value ? signupController.passwordCheckController : signupController.passwordController,
                  obsecuretext: true,
                  hinttext: signupController.isPasswordCheck.value ? '비밀번호 확인' :'비밀번호 6자 이상',
                ),
              ),
            ),
            Obx(
              () => Expanded(
                child: Stack(children: [
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: GestureDetector(
                      onTap: () async {
                        if(!signupController.isPasswordCheck.value){
                          signupController.isPasswordCheck(true);
                        }else{
                        if(signupController.passwordCheckController.text != signupController.passwordController.text){
                        showCustomDialog('비밀번호가 일치하지 않아요', 1200);
                      }else{
                        Get.to(()=> SignupEmailValidateView());
                      }
                        }
                      },
                      child: BottomButtonWidget(color: kPrimary),
                      
                    ),
                  ),
                  if(signupController.isPasswordCheck.value)
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: GestureDetector(
                      onTap: () async {
                        signupController.isPasswordCheck(false);
                      },
                      child: BottomButtonWidget(widget: const Icon(Icons.arrow_back, color: kPrimary,),color: kMainWhite, borderColor: kPrimary,),
                      
                    ),
                  )
                ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
