import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton({ Key? key, required this.text, this.height, this.width, this.backColor, this.textColor}) : super(key: key);
  Color? backColor;
  Color? textColor;
  String text;
  double? height;
  double? width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? Get.width / 8.5,
      width: width?? Get.width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: backColor?? kPrimary),
      child: Center(child: Text(text, style: kActiveButtonStyle.copyWith(color: textColor?? kMainWhite),)),
    );
  }
}


