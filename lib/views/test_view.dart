import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/fadeout_animation_controller.dart';

class TestView extends StatelessWidget {
  final FadeoutAniamtionController _fadeoutAniamtionController =
      Get.put(FadeoutAniamtionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                FadeTransition(
                  opacity: Tween(begin: 1.0, end: 0.0)
                      .chain(CurveTween(curve: Curves.fastOutSlowIn))
                      .animate(
                          _fadeoutAniamtionController.animationController!),
                  child: ScaleTransition(
                    scale:
                        _fadeoutAniamtionController.scaleAnimationController!,
                    child: Container(
                      height: 13,
                      width: 13,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: kPrimary),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: kMainWhite,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: kPrimary, width: 1.6),
                  ),
                  height: 12,
                  width: 12,
                  child: const SizedBox.shrink(),
                ),
              ],
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              '내 친구들의 수락을 기다리는 중이에요...',
              style: kSmallCaptionStyle.copyWith(
                color: kMainBlack.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
