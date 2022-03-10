import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/views/signup_name_view.dart';
import 'package:universiting/widgets/bottombutton.dart';
import '../api/signup_api.dart';
import '../constant.dart';
import '../controllers/signup_controller.dart';
import '../utils/global_variable.dart';
import '../views/signup_user_view.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/textformfield_widget.dart';

class SignupDepartmentView extends StatelessWidget {
  SignupDepartmentView({Key? key}) : super(key: key);

  SignupController signupController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 64, 20, 0),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('그렇군요!', style: kHeaderStyle1),
              SizedBox(
                height: Get.width / 30,
              ),
              const Text('그럼 학과는요?', style: kHeaderStyle1),
              SizedBox(height: Get.width / 30),
              Text('괜찮아요 내 학과는 매칭된 친구들끼리만 확인할 수 있어요',
                  style: kLargeCaptionStyle.copyWith(
                      color: kMainBlack.withOpacity(0.6))),
              SizedBox(height: Get.height / 20),
              CustomTextFormField(
                controller: signupController.departmentController,
                hinttext: '학과 이름',
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Obx(
                  () => Stack(children: [
                    ListView(
                        children: signupController.departSearchList
                            .map((element) => GestureDetector(
                                  onTap: () {
                                    signupController.departmentController.text =
                                        element;
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(element),
                                      SizedBox(height: Get.width / 20),
                                      const Divider()
                                    ],
                                  ),
                                ))
                            .toList()),
                    Positioned(
                      bottom: Get.width / 15,
                      right: Get.width / 20,
                      child: GestureDetector(
                        onTap: (){
                          signupController.getDepartId(signupController.departmentController.text);
                          print(signupController.departId);
                          print(signupController.schoolId);
                          if(signupController.isDepart.value)Get.to(() => SignupNameView());},
                        child: BottomButtonWidget(
                            color: signupController.isDepart.value
                                ? kPrimary
                                : kPrimary),
                      ),
                    )
                  ]),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
