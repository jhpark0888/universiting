import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton({ Key? key, required this.text}) : super(key: key);
  String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.width / 8.5,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: kMainBlack),
      child: Center(child: Text(text, style: kActiveButtonStyle.copyWith(color: kMainWhite),)),
    );
  }
}