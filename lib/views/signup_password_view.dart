import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/utils/check_validator.dart';
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
  final _key = GlobalKey<FormState>();
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
            Text('이제 거의 끝나가요.', style: kStyleHeader),
            SizedBox(
              height: Get.width / 30,
            ),
            const Text('사용할 비밀번호를 입력해주세요.', style: kStyleHeader),
            SizedBox(height: Get.height / 20),
            Form(
              key: _key,
              child: CustomTextFormField(
                controller: signupController.passwordController,
                obsecuretext: true,
                validator: (value) {
                  if(value!.isEmpty){return '비밀번호를 입력하세요';}
                },
                hinttext: '비밀번호 6자 이상',
              ),
            ),
            Expanded(
              child: Stack(children: [
                  Positioned(
                    bottom: Get.width / 15,
                    right: Get.width / 20,
                    child: GestureDetector(
                      onTap: () async {
                        if (_key.currentState!.validate()) {
                          Get.to(() => SignupPasswordCheckView());
                        }
                      },
                      child: Obx(
                        () => BottomButtonWidget(
                            color: signupController.isage.value
                                ? mainblack
                                : Color(0xffe7e7e7)),
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