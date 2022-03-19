import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:universiting/api/signup_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/views/signup_name_view.dart';
import 'package:universiting/widgets/bottombutton.dart';
import '../controllers/signup_controller.dart';
import '../utils/global_variable.dart';
import '../views/signup_department_view.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/textformfield_widget.dart';

class SignupUnivView extends StatelessWidget {
  SignupUnivView({Key? key}) : super(key: key);
  SignupController signupController = Get.put(SignupController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 64, 20, 0),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: const TextSpan(children: [
                      TextSpan(
                          text: '여긴 대학생들을 위한 공간이에요.', style: kHeaderStyle1),
                    ])),
                    SizedBox(height: 12),
                    RichText(
                        text: const TextSpan(children: [
                      TextSpan(
                          text: '현재 다니고 계시는 학교가 어디신가요?', style: kHeaderStyle1),
                    ])),
                    SizedBox(
                      height: Get.height / 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SignUpTextFormField(
                            controller: signupController.universityController,
                            hinttext: '학교 이름',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Obx(
                        () => Stack(
                          children: [
                            ListView(
                                children: signupController.univSearchList
                                    .map((element) => GestureDetector(
                                          onTap: () {
                                            signupController
                                                .universityController
                                                .text = element;
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(element),
                                              SizedBox(
                                                height: 16,
                                              ),
                                              const Divider()
                                            ],
                                          ),
                                        ))
                                    .toList()),
                            Positioned(
                                bottom: 20,
                                right: 20,
                                child: GestureDetector(
                                  onTap: () async {
                                    if (signupController.isUniv.value) {
                                      signupController.selectuniv(
                                          signupController
                                              .universityController.text);
                                      // print(signupController.uni.value.id);
                                      // await getDepartList(
                                      //     signupController.uni.value.id);
                                      Get.to(() => SignupNameView());
                                    } else {
                                      showCustomDialog(
                                          '다니고 계시는 학교를 선택해주세요', 1200);
                                    }

                                  },
                                  child: BottomButtonWidget(color: kPrimary),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
