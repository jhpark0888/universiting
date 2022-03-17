import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';

class BottomButtonWidget extends StatelessWidget {
  BottomButtonWidget({Key? key, required this.color, this.borderColor, this.widget, this.width, this.height}) : super(key: key);
  Color color;
  Color? borderColor;
  Widget? widget;
  double? width;
  double? height;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: width?? Get.width / 6,
        height: height ?? Get.width / 7,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: color, border: Border.all(color: borderColor ?? kMainWhite)),
        child: Center(
          child: widget ?? Icon(Icons.arrow_forward, color: kMainWhite),
        ));
  }
}
// bottom: Get.width / 15,
        // right: Get.width / 20,