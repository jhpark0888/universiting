import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:universiting/constant.dart';
import '../api/signup_api.dart';
import '../controllers/signup_controller.dart';
import '../utils/global_variable.dart';
import '../views/signup_department_view.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/textformfield_widget.dart';

class SignupView extends StatefulWidget {
  SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  SignupController signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: '회원 가입',
        actions: [
          IconButton(
              onPressed: () async {
                resultOfConnection().then((value) async {
                  if (value) {
                    if (signupController.isUniv.value) {
                      await getDepartList(
                          signupController.universityController.text);
                      Get.to(() => SignupDepartmentView());
                      signupController
                          .getlink(signupController.universityController.text);
                      print(signupController.univLink);
                    } else {
                      print(signupController.isUniv.value);
                    }
                  } else {
                    showCustomDialog('네트워크를 확인해주세요', 3000);
                  }
                });
                // ? signupController.isUniv.value
                //     ? Get.to(() => SignupDepartmentScreen(univ: signupController.universityController.text,))
                //     : print(signupController.isUniv.value)
                // : showCustomDialog('네트워크를 확인해주세요', 3000));
              },
              icon: Obx(
                () => Text(
                  '다음',
                  style: kStyleAppbar.copyWith(
                      color: signupController.isUniv.value
                          ? Colors.blue
                          : Colors.black.withOpacity(0.6)),
                ),
              ))
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height(context) / 20,
                  ),
                  RichText(
                      textAlign: TextAlign.right,
                      text: TextSpan(children: [
                        TextSpan(
                            text: '어느 대학',
                            style: TstyleHeader.copyWith(color: Colors.blue)),
                        const TextSpan(
                            text: '에 재학 중이신가요?', style: TstyleHeader),
                      ])),
                  SizedBox(
                    height: height(context) / 20,
                  ),
                  CustomTextFormField(
                      controller: signupController.universityController),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => Expanded(
                      child: ListView(
                          children: signupController.univSearchList
                              .map((element) => GestureDetector(
                                    onTap: () {
                                      signupController
                                          .universityController.text = element;
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(element),
                                        const Divider()
                                      ],
                                    ),
                                  ))
                              .toList()),
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
