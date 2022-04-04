import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/app.dart';

import 'package:universiting/views/signup_password_view.dart';
import 'package:universiting/widgets/signup_bottombutton_widget.dart';
import '../constant.dart';
import '../controllers/custom_animation_controller.dart';
import '../controllers/keyboard_controller.dart';
import '../controllers/signup_controller.dart';

class SignupSuccessView extends StatelessWidget {
  SignupSuccessView({
    Key? key,
    required this.lat,
    required this.lng,
  }) : super(key: key);
  final SignupController signupController = Get.find();
  final KeyboardController _keyboardController = Get.find();
  final CustomAnimationController _animationController =
      Get.put(CustomAnimationController(), tag: 'success');

  double lat;
  double lng;
  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 80, 30, 0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      FadeTransition(
                        opacity: _animationController.loadValue,
                        child: SlideTransition(
                          position: _animationController.offsetValue,
                          child: const Text('인증이 완료됐어요', style: kHeaderStyle1),
                        ),
                      ),
                      const SizedBox(height: 10),
                      FadeTransition(
                        opacity: _animationController.loadValue,
                        child: SlideTransition(
                          position: _animationController.secondOffsetValue,
                          child: const Text('이제 다양한 친구를 만나보세요',
                              style: kHeaderStyle1),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Image.asset('assets/illustrations/signup_success.png')
                    ]),
              ),
            ),
            SignupButtonWidget(
                onTap: () {
                  Get.offAll(() => App(lat: lat, lng: lng));
                },
                isback: false,
                isButtonActive: true,
                nextword: '유니버시팅 시작하기',
                signuptype: 'success'),
          ],
        ),
      ),
    );
  }
}
