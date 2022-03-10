import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/utils/check_validator.dart';
import 'package:universiting/views/signup_password_view.dart';
import 'package:universiting/views/signup_profile_view.dart';
import 'package:universiting/widgets/bottombutton.dart';
import '../api/signup_api.dart';
import '../constant.dart';
import '../controllers/signup_controller.dart';
import '../utils/global_variable.dart';
import '../views/signup_user_view.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/textformfield_widget.dart';

class SignupGenderView extends StatelessWidget {
  SignupGenderView({Key? key, required this.content}) : super(key: key);
  String content;
  SignupController signupController = Get.find();
  List mcontents = ['남자인가요?', '남자셨군요!'];
  List wcontents = ['여자인가요?', '여자셨군요!'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              20, 64, 20, 0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${signupController.ageController.text}살, $content',
                    style: kHeaderStyle1),
                SizedBox(
                  height: Get.width / 30,
                ),
                Text('근데 ${signupController.nameController.text}님은...',
                    style: kHeaderStyle1),
                SizedBox(height: Get.width / 30),
                Text('괜찮아요. 성별는 매칭된 친구들만 확인할 수 있어요',
                    style: kLargeCaptionStyle.copyWith(
                        color: kMainBlack.withOpacity(0.6))),
                SizedBox(height: Get.height / 10),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                    Column(children: [
                      signupController.isgender.value == 'M'
                          ? Text(
                              mcontents[1],
                              style: kSubtitleStyle2,
                            )
                          : Text(
                              mcontents[0],
                              style: kSubtitleStyle2.copyWith(
                                  color: kMainBlack.withOpacity(0.38)),
                            ),
                      SizedBox(
                        height: Get.height / 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          signupController.isgender.value = 'M';
                        },
                        child: Container(
                          height: Get.width / 4,
                          width: Get.width / 4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              color: signupController.isgender.value == 'M'
                                  ? const Color(0xff747272)
                                  : const Color(0x00c4c4c4).withOpacity(0.38)),
                        ),
                      )
                    ]),
                    Column(
                      children: [
                        signupController.isgender.value == 'F'
                            ? Text(
                                wcontents[1],
                                style: kSubtitleStyle2,
                              )
                            : Text(
                                wcontents[0],
                                style: kSubtitleStyle2.copyWith(
                                    color: kMainBlack.withOpacity(0.38)),
                              ),
                        SizedBox(
                          height: Get.height / 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            signupController.isgender.value = 'F';
                          },
                          child: Container(
                            height: Get.width / 4,
                            width: Get.width / 4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(60),
                                color: signupController.isgender.value == 'F'
                                    ? const Color(0xff747272)
                                    : const Color(0x00C4C4C4)
                                        .withOpacity(0.38)),
                          ),
                        ),
                      ],
                    )
                  ]),
                ),
                Expanded(
                  child: Stack(children: [
                    Positioned(
                      bottom: Get.width / 15,
                      right: Get.width / 20,
                      child: GestureDetector(
                        onTap: () {Get.to(() => SignupPasswordView());},
                        child: Obx(
                          () => BottomButtonWidget(
                              color: (signupController.isgender.value.isNotEmpty)
                                  ? kPrimary
                                  : kPrimary),
                        ),
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
