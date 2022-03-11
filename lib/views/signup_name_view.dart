import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/utils/check_validator.dart';
import 'package:universiting/views/signup_age_view.dart';
import 'package:universiting/views/signup_profile_view.dart';
import 'package:universiting/widgets/bottombutton.dart';
import '../api/signup_api.dart';
import '../constant.dart';
import '../controllers/signup_controller.dart';
import '../utils/global_variable.dart';
import '../views/signup_user_view.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/textformfield_widget.dart';

class SignupNameView extends StatelessWidget {
  SignupNameView({Key? key}) : super(key: key);

  SignupController signupController = Get.find();
  final _key = GlobalKey<FormState>();
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
            const Text('좋아요!', style: kHeaderStyle1),
            SizedBox(
              height: 12,
            ),
            const Text('친구들이 당신을 뭐라고 불러야할까요?', style: kHeaderStyle1),
            SizedBox(height: Get.width / 30),
            Form(
              key: _key,
              child: SignUpTextFormField(
                controller: signupController.nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return '아무것도 입력하지 않았어요';
                  }
                },
                hinttext: '최대 8자',
              ),
            ),
            Expanded(
              child: Stack(children: [
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: GestureDetector(
                    onTap: () async {
                      // if (_key.currentState!.validate()) {
                      //   Get.to(()=> SignupAgeView());
                      // }
                      if (signupController.nameController.text.isEmpty) {
                        showCustomDialog('아무것도 입력하지 않았어요', 1200);
                      } else if (signupController.nameController.text.length >=
                          8) {
                        showCustomDialog('8자 이하로 적어주세요', 1200);
                      } else {
                        checkNickName();
                      }
                    },
                    child: BottomButtonWidget(color: kPrimary),
                  ),
                ),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
