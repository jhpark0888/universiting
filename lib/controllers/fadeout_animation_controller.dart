import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class FadeoutAniamtionController extends GetxController
    with GetTickerProviderStateMixin {
  static FadeoutAniamtionController get to =>
      Get.put(FadeoutAniamtionController());

  AnimationController? animationController;
  AnimationController? scaleAnimationController;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      lowerBound: 0.0,
      upperBound: 1.0,
    )..repeat();

    scaleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      lowerBound: 1.0,
      upperBound: 2.0,
    )..repeat();
  }
}
