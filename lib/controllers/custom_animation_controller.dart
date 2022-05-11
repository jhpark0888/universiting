import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:universiting/constant.dart';

class CustomAnimationController extends GetxController
    with GetTickerProviderStateMixin {
  static CustomAnimationController get to =>
      Get.put(CustomAnimationController());

  AnimationController? animationController;
  AnimationController? scaleAnimationController;
  late AnimationController fadeAnimationController,
      offsetAnimationController,
      secondOffsetAnimationController;
  late Animation<double> loadValue;
  late Animation<Offset> offsetValue;
  late Animation<Offset> secondOffsetValue;
  Rx<Offset> bnbOffsetValue = Offset(0.0, 0.0).obs;
  final RxBool isRoomModalUp = false.obs;
  RxDouble modalHegiht = 300.0.obs;
  final TweenSequence<Offset> kTweenSequence =
      TweenSequence(<TweenSequenceItem<Offset>>[
    TweenSequenceItem<Offset>(
      tween: Tween(begin: Offset(0.0, 5.0), end: Offset(0.0, -0.2))
          .chain(CurveTween(curve: Curves.easeOut)),
      weight: 80.0,
    ),
    TweenSequenceItem<Offset>(
      tween: Tween(begin: Offset(0.0, -0.2), end: Offset(0.0, 0.0))
          .chain(CurveTween(curve: Curves.easeIn)),
      weight: 40.0,
    )
  ]);

  late AnimationController myRoomWidgetAnimationController;

  final easeInCurve = CurveTween(curve: Curves.easeInOutCubic);

  final halfTurn = Tween<double>(begin: 0.0, end: 0.5);

  late Animation<double> expandFactor;

  late Animation<double> iconTurns;

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
    fadeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    offsetAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    secondOffsetAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    loadValue = Tween(begin: 0.0, end: 1.0)
        .chain(CurveTween(curve: Curves.fastOutSlowIn))
        .animate(fadeAnimationController);
    offsetValue = kTweenSequence.animate(
      CurvedAnimation(
        parent: offsetAnimationController,
        curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
      ),
    );
    secondOffsetValue = kTweenSequence.animate(
      CurvedAnimation(
        parent: secondOffsetAnimationController,
        curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
      ),
    );

    myRoomWidgetAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    expandFactor = myRoomWidgetAnimationController.drive(easeInCurve);
    iconTurns =
        myRoomWidgetAnimationController.drive(halfTurn.chain(easeInCurve));

    // secondOffsetValue =
    //     Tween<Offset>(begin: const Offset(0.0, 10.0), end: Offset(0.0, 0.0))
    //         .chain(CurveTween(curve: Curves.easeInOut))
    //         .animate(secondOffsetAnimationController);

    fadeAnimationController.forward();
    offsetAnimationController.forward();
    secondOffsetAnimationController.forward();
  }

  @override
  void onClose() {
    fadeAnimationController.dispose();
    scaleAnimationController!.dispose();
    animationController!.dispose();
    offsetAnimationController.dispose();
    secondOffsetAnimationController.dispose();
    myRoomWidgetAnimationController.dispose();
    super.onClose();
  }
}
