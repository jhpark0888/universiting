import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:universiting/Api/signup_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/widgets/bottombutton.dart';
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
    print(Get.width);
    return Scaffold(
      // bottomSheet: GestureDetector(
      //     onTap: () {Get.to(() => SignupDepartmentView());},
      //     child: BottomSheetWidget(
      //       color: signupController.isUniv.value ? Colors.black : buttonColor,
      //     )),
      // appBar: AppBarWidget(
      //   title: '회원 가입',
      //   actions: [
      //     IconButton(
      //         onPressed: () async {
      //           resultOfConnection().then((value) async {
      //             if (value) {
      //               if (signupController.isUniv.value) {
      //                 await getDepartList(
      //                     signupController.universityController.text);
      //                 Get.to(() => SignupDepartmentView());
      //                 signupController
      //                     .getlink(signupController.universityController.text);
      //                 print(signupController.univLink);
      //               } else {
      //                 print(signupController.isUniv.value);
      //               }
      //             } else {
      //               showCustomDialog('네트워크를 확인해주세요', 3000);
      //             }
      //           });
      //           // ? signupController.isUniv.value
      //           //     ? Get.to(() => SignupDepartmentScreen(univ: signupController.universityController.text,))
      //           //     : print(signupController.isUniv.value)
      //           // : showCustomDialog('네트워크를 확인해주세요', 3000));
      //         },
      //         icon: Obx(
      //           () => Text(
      //             '다음',
      //             style: kStyleAppbar.copyWith(
      //                 color: signupController.isUniv.value
      //                     ? Colors.blue
      //                     : Colors.black.withOpacity(0.6)),
      //           ),
      //         ))
      //   ],
      // ),
      body: GestureDetector(
        onTap: (){FocusScope.of(context).unfocus();},
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                Get.width / 20, Get.width / 6, Get.width / 20, 0),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: const TextSpan(children: [
                      TextSpan(text: '여긴 대학생들을 위한 공간이에요.', style: kStyleHeader),
                    ])),
                    SizedBox(height: Get.width / 30),
                    RichText(
                        text: const TextSpan(children: [
                      TextSpan(
                          text: '현재 다니고 계시는 학교가 어디신가요?', style: kStyleHeader),
                    ])),
                    SizedBox(
                      height: Get.height / 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CustomTextFormField(
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
                                            signupController.universityController
                                                .text = element;
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: Get.width / 20,
                                              ),
                                              Text(element),
                                              const Divider()
                                            ],
                                          ),
                                        ))
                                    .toList()),
                            Positioned(
                                bottom: Get.width / 15,
                                right: Get.width / 20,
                                child: GestureDetector(
                                  onTap: () async {
                                    signupController.selectuniv(signupController
                                        .universityController.text);
                                    print(signupController.uni.value.id);
                                    await getDepartList(
                                        signupController.uni.value.id);
                                    Get.to(() => SignupDepartmentView());
                                  },
                                  child: BottomButtonWidget(
                                      color: signupController.isUniv.value
                                          ? mainblack
                                          : Color(0xffe7e7e7)),
                                ))
                            // GestureDetector(
                            //     onTap: () {
                            //       // signupController.selectuniv(
                            //       //     signupController.universityController.text);
                            //       //     print(signupController.uni.value.schoolname);
                            //     },
                            //     child: BottomButtonWidget(
                            // color: signupController.isUniv.value
                            //     ? mainblack
                            //     :
                            //     color : Color(0xffe7e7e7)))
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
