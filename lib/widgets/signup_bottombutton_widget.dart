import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/controllers/custom_animation_controller.dart';
import 'package:universiting/widgets/custom_button_widget.dart';

class SignupButtonWidget extends StatelessWidget {
  SignupButtonWidget({
    Key? key,
    required this.onTap,
    required this.isButtonActive,
    required this.signuptype,
    required this.isback,
    this.onBack,
    this.backword,
    this.nextword,
  }) : super(key: key);

  late final CustomAnimationController _animationController =
      Get.find(tag: signuptype);

  Function() onTap;
  Function()? onBack;
  bool isback;
  bool isButtonActive;
  String signuptype;
  String? backword;
  String? nextword;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 82,
      width: Get.width,
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
      child: Row(
        children: [
          if (isback == true)
            FadeTransition(
              opacity: _animationController.loadValue,
              child: CustomButtonWidget(
                onTap: onBack ??
                    () async {
                      Get.back();
                    },
                buttonState: ButtonState.enabled,
                buttonTitle: backword ?? '이전',
              ),
            ),
          if (isback == true)
            const SizedBox(
              width: 20,
            ),
          Expanded(
            child: FadeTransition(
              opacity: _animationController.loadValue,
              child: CustomButtonWidget(
                onTap: onTap,
                buttonState:
                    isButtonActive ? ButtonState.primary : ButtonState.enabled,
                buttonTitle: nextword ?? '다음',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
