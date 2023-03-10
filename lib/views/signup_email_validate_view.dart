import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/api/profile_api.dart';
import 'package:universiting/api/signup_api.dart';
import 'package:universiting/app.dart';
import 'package:universiting/controllers/custom_animation_controller.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/utils/check_validator.dart';
import 'package:universiting/views/home_view.dart';
import 'package:universiting/views/inquary_finish_view.dart';
import 'package:universiting/views/inquary_view.dart';
import 'package:universiting/views/signup_email_validate_view.dart';
import 'package:universiting/views/signup_gender_view.dart';
import 'package:universiting/views/signup_profile_view.dart';
import 'package:universiting/views/signup_success_view.dart';
import 'package:universiting/widgets/bottombutton.dart';
import 'package:universiting/widgets/loading_widget.dart';
import 'package:universiting/widgets/signup_bottombutton_widget.dart';
import '../constant.dart';
import '../controllers/signup_controller.dart';
import '../utils/global_variable.dart';
import '../views/signup_user_view.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/empty_back_textfield_widget.dart';

class SignupEmailValidateView extends StatelessWidget {
  SignupEmailValidateView({Key? key}) : super(key: key);

  SignupController signupController = Get.find();
  final CustomAnimationController _animationController =
      Get.put(CustomAnimationController(), tag: 'emailcheck');
  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: Obx(
        () => Stack(
          children: [
            Scaffold(
              resizeToAvoidBottomInset: false,
              body: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 80, 30, 0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FadeTransition(
                              opacity: _animationController.loadValue,
                              child: SlideTransition(
                                position: _animationController.offsetValue,
                                child: Text('?????? ??????????????????', style: kHeaderStyle1),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            FadeTransition(
                              opacity: _animationController.loadValue,
                              child: SlideTransition(
                                position: _animationController.offsetValue,
                                child: Text('?????? ????????? ????????? ??????????????????.',
                                    style: kHeaderStyle1),
                              ),
                            ),
                            const SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: EmptyBackTextfieldWidget(
                                    textalign: TextAlign.center,
                                    controller:
                                        signupController.emailController,
                                    hinttext: '?????? ?????? ????????? ?????????',
                                  ),
                                ),
                                Text(
                                  '@${signupController.uni.value.email}',
                                  style: kHeaderStyle2.copyWith(
                                      color: kMainBlack.withOpacity(0.6)),
                                )
                              ],
                            ),
                            Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Column(
                                  children: [
                                    Text('?????? ????????? ?????? ????????? ?????? ?????? ????????? ??????????????????',
                                        style: kBodyStyle2.copyWith(
                                            color: kPrimary)),
                                    Text(
                                      '?????? ????????? ???????????? ???????????? ???????????? ??????????????????',
                                      style: kBodyStyle2.copyWith(
                                          color: kMainBlack.withOpacity(0.4)),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Expanded(
                            //   child: Stack(children: [
                            //     Positioned(
                            //       bottom: Get.width / 15,
                            //       right: Get.width / 20,
                            //       child: Obx(
                            //         () => GestureDetector(
                            //           onTap: () async {
                            //             if (signupController.isEmail.value == true &&
                            //                 signupController.isEmailPress.value ==
                            //                     false &&
                            //                 signupController.isEmailCheck.value ==
                            //                     false) {
                            //               signupController.isEmailPress.value = true;
                            //               await checkEmail();
                            //             } else if (signupController.isEmail.value ==
                            //                     true &&
                            //                 signupController.isEmailPress.value ==
                            //                     true &&
                            //                 signupController.isSendEmail.value ==
                            //                     true &&
                            //                 signupController.isEmailCheck.value ==
                            //                     true) {
                            //               await postProfile();
                            //             }
                            //           },
                            //           child: BottomButtonWidget(
                            //               widget: (signupController.isEmail.value ==
                            //                       true
                            //                   // signupController.isEmailPress.value ==
                            //                   //     false &&
                            //                   // signupController.isEmailCheck.value ==
                            //                   //     false
                            //                   )
                            //                   ? signupController.isEmailPress.value ==
                            //                           false
                            //                       ? Text(
                            //                           '?????? ?????? ?????????',
                            //                           style: signupController
                            //                                   .isEmail.value
                            //                               ? kActiveButtonStyle.copyWith(
                            //                                   fontWeight:
                            //                                       FontWeight.w600,
                            //                                   color: kMainWhite)
                            //                               : kInActiveButtonStyle
                            //                                   .copyWith(
                            //                                       color: kMainWhite),
                            //                         )
                            //                       : signupController.isSendEmail.value
                            //                           ? signupController
                            //                                   .isEmailCheck.value
                            //                               ? Text(
                            //                                   '????????????!',
                            //                                   style: kActiveButtonStyle
                            //                                       .copyWith(
                            //                                           color:
                            //                                               kMainWhite),
                            //                                 )
                            //                               : Text('?????? ?????????',
                            //                                   style: kActiveButtonStyle
                            //                                       .copyWith(
                            //                                           fontWeight:
                            //                                               FontWeight
                            //                                                   .w600,
                            //                                           color: kMainBlack
                            //                                               .withOpacity(
                            //                                                   0.38)))
                            //                           : Text('?????? ?????? ?????????',
                            //                               style: kActiveButtonStyle
                            //                                   .copyWith(
                            //                                       fontWeight:
                            //                                           FontWeight.w600,
                            //                                       color: kMainWhite))
                            //                   : Text(
                            //                       '?????? ?????? ?????????',
                            //                       style: kActiveButtonStyle.copyWith(
                            //                           fontWeight: FontWeight.w600,
                            //                           color:
                            //                               signupController.isEmail.value
                            //                                   ? kMainWhite
                            //                                   : kMainBlack
                            //                                       .withOpacity(0.38)),
                            //                     ),
                            //               width: Get.width / 3,
                            //               height: Get.width / 8,
                            //               color: signupController.isEmail.value
                            //                   ? signupController.isEmailPress.value
                            //                       ? signupController.isSendEmail.value
                            //                           ? signupController
                            //                                   .isEmailCheck.value
                            //                               ? kPrimary
                            //                               : kLightGrey
                            //                           : kPrimary
                            //                       : kPrimary
                            //                   : kLightGrey),
                            //         ),
                            //       ),
                            //     ),
                            //     Positioned(
                            //       bottom: Get.width / 15,
                            //       left: Get.width / 20,
                            //       child: GestureDetector(
                            //         onTap: () async {
                            //           await checkEmail();
                            //         },
                            //         child: Obx(
                            //           () => (signupController.isEmail.value == true &&
                            //                   signupController.isEmailPress.value ==
                            //                       true &&
                            //                   signupController.isSendEmail.value ==
                            //                       true &&
                            //                   signupController.isEmailCheck.value ==
                            //                       false)
                            //               ? BottomButtonWidget(
                            //                   widget: Text('?????? ?????????',
                            //                       style: kActiveButtonStyle.copyWith(
                            //                           color: kPrimary)),
                            //                   width: Get.width / 3,
                            //                   height: Get.width / 8,
                            //                   color: kMainWhite,
                            //                   borderColor: kPrimary,
                            //                 )
                            //               : Container(),
                            //         ),
                            //       ),
                            //     )
                            //   ]),
                            // ),
                          ]),
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        // showaskDialog(
                        //     controller: SignupController.to.askController,
                        //     centertext: '????????????',
                        //     hinttext:
                        //         '???????????? ????????? ?????????, ????????? ????????? ?????? ??????\n?????? ?????? ????????? ?????? ?????? ????????? ??????????????????.',
                        //     lefttext: '??????',
                        //     leftfunc: () {
                        //       SignupController.to.askController.clear();
                        //       Get.back();
                        //     },
                        //     righttext: '????????????',
                        //     rightfunc: () async {
                        //       customDialog(1);
                        //       await postInquary(
                        //         '',
                        //         SignupController.to.askController.text,
                        //         '?????????',
                        //       ).then((value) {
                        //         if (value.isError == false) {
                        //           Get.back();
                        //           Get.to(() => InquaryFinishView());
                        //           SignupController.to.askController.clear();
                        //         }
                        //       });
                        //     });

                        Get.to(() => InquaryView(viewtype: ViewType.signUp,));
                      },
                      child: Text(
                        '?????? ????????? ????????? ????????? ??????????',
                        style: kInActiveButtonStyle.copyWith(
                            height: 1.5, color: kMainBlack.withOpacity(0.4)),
                        textAlign: TextAlign.center,
                      )),
                  const SizedBox(height: 10),
                  Obx(
                    () => SignupButtonWidget(
                        onTap: () async {
                          if (signupController.emailcheckstate.value ==
                              EmailCheckState.fill) {
                            signupController
                                .emailcheckstate(EmailCheckState.loading);
                            await Future.delayed(Duration(seconds: 2));
                            await checkEmail();
                          }
                        },
                        onBack: () async {
                          if (signupController.emailcheckstate.value ==
                              EmailCheckState.waiting) {
                            signupController
                                .emailcheckstate(EmailCheckState.loading);
                            await Future.delayed(Duration(seconds: 2));
                            await checkEmail();
                          } else {
                            Get.back();
                          }
                        },
                        isback: true,
                        isButtonActive:
                            signupController.emailcheckstate.value ==
                                    EmailCheckState.empty
                                ? false
                                : true,
                        backword: signupController.emailcheckstate.value ==
                                EmailCheckState.waiting
                            ? '?????? ?????????'
                            : '??????',
                        nextword: signupController.emailcheckstate.value ==
                                EmailCheckState.waiting
                            ? '?????? ?????????'
                            : '?????? ?????? ?????????',
                        signuptype: 'emailcheck'),
                  ),
                ],
              ),
            ),
            if (signupController.emailcheckstate.value ==
                EmailCheckState.loading)
              Container(
                height: Get.height,
                width: Get.width,
                color: kMainBlack.withOpacity(0.3),
                child: Image.asset(
                  'assets/icons/loading.gif',
                  scale: 8,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
