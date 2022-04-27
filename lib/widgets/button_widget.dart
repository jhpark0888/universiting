import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton(
      {Key? key,
      required this.text,
      required this.isactive,
      this.height,
      this.width,
      this.backColor,
      this.textColor})
      : super(key: key);
  Color? backColor;
  Color? textColor;
  String text;
  double? height;
  double? width;
  RxBool isactive;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: height ?? Get.width / 8.5,
        width: width ?? Get.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: isactive.value ? kPrimary : kMainBlack.withOpacity(0.4)),
        child: Center(
            child: Text(
          text,
          style: k16Medium.copyWith(color: textColor ?? kMainWhite),
        )),
      ),
    );
  }
}
