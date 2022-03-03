import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/Api/signup_api.dart';
import 'package:universiting/Screen/signup_user_screen.dart';
import 'package:universiting/controller/signup_controller.dart';
import 'package:universiting/function/global_variable.dart';
import 'package:universiting/widget/appbar_widget.dart';
import 'package:universiting/widget/textformfield_widget.dart';

class SignupDepartmentScreen extends StatelessWidget {
  SignupDepartmentScreen({Key? key}) : super(key: key);

  SignupController signupController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: '회원가입',
        leading: IconButton(
              onPressed: () {
                signupController.departmentController.clear();
                signupController.departSearchList.clear();
                Get.back();
              },
              icon: SvgPicture.asset('assets/icons/Arrow.svg')),
        actions: [
          Obx(
            () => IconButton(
                onPressed: () {
                  resultOfConnection().then((value) => value
                      ? signupController.isDepart.value
                          ? Get.to(() => SignupUserScreen())
                          : print(signupController.isDepart.value)
                      : showCustomDialog('네트워크를 확인해주세요', 3000));
                },
                icon: Text(
                  '다음',
                  style: (signupController.isDepart.value)
                      ? TstyleAppbar.copyWith(color: Colors.blue)
                      : TstyleAppbar.copyWith(
                          color: Colors.black.withOpacity(0.6)),
                )),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
        child: GestureDetector(
          onTap: (){FocusScope.of(context).unfocus();},
          child: Center(
              child: Column(children: [
            SizedBox(height: height(context) / 20),
            RichText(
                textAlign: TextAlign.right,
                text: TextSpan(children: [
                  TextSpan(
                      text: '어느 학과',
                      style: TstyleHeader.copyWith(color: Colors.blue)),
                  const TextSpan(text: '를 전공하고 계신가요?', style: TstyleHeader),
                ])),
            SizedBox(height: height(context) / 40),
            Text('내 학과는 : ${signupController.departmentController.text}'),
            SizedBox(height: height(context) / 20),
            CustomTextFormField(
                controller: signupController.departmentController),
            const SizedBox(
              height: 10,
            ),
            Obx(
              () => Expanded(
                child: ListView(
                    children: signupController.departSearchList
                        .map((element) => GestureDetector(
                              onTap: () {
                                signupController.departmentController.text =
                                    element;

                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [Text(element), const Divider()],
                              ),
                            ))
                        .toList()),
              ),
            )
          ])),
        ),
      ),
    );
  }
}
