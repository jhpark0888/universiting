import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/utils/check_validator.dart';
import 'package:universiting/views/signup_gender_view.dart';
import 'package:universiting/views/signup_profile_view.dart';
import 'package:universiting/widgets/bottombutton.dart';
import '../api/signup_api.dart';
import '../constant.dart';
import '../controllers/signup_controller.dart';
import '../utils/global_variable.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/textformfield_widget.dart';

class SignupAgeView extends StatelessWidget {
  SignupAgeView({Key? key}) : super(key: key);

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
            RichText(
                text: TextSpan(children: [
              const TextSpan(text: '안녕하세요 ', style: kHeaderStyle1),
              TextSpan(
                  text: signupController.nameController.text,
                  style: kHeaderStyle1.copyWith(color: kPrimary)),
              const TextSpan(text: '님,', style: kHeaderStyle1)
            ])),
            const SizedBox(
              height: 12,
            ),
            const Text('혹시.. 나이가 어떻게 되시나요?', style: kHeaderStyle1),
            const SizedBox(height: 12),
            Text('괜찮아요. 나이는 매칭된 친구들만 확인할 수 있어요',
                style: kLargeCaptionStyle.copyWith(
                    color: Colors.black.withOpacity(0.6))),
            SizedBox(height: Get.height / 30),
            Form(
              child: CustomTextFormField(
                controller: signupController.ageController,
                hinttext: '나이',
              ),
            ),
            Expanded(
              child: Stack(children: [
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: GestureDetector(
                    onTap: () async {
                      if (signupController.ageController.text.isNotEmpty) {
                        Get.to(() => SignupGenderView(
                            content: signupController.checkAge()));
                      }else{
                        showCustomDialog('나이를 입력해주세요', 1200);
                      }
                    },
                    child: Obx(
                      () => BottomButtonWidget(
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
