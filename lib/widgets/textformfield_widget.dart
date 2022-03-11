import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant.dart';

class SignUpTextFormField extends StatelessWidget {
  SignUpTextFormField(
      {Key? key,
      required this.controller,
      this.validator,
      this.obsecuretext,
      this.hinttext,
      this.textalign})
      : super(key: key);
  TextEditingController controller;
  TextAlign? textalign;
  String? Function(String?)? validator;
  String? hinttext;
  bool? obsecuretext;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        cursorColor: kPrimary,
        maxLines: 1,
        style: kHeaderStyle2,
        textAlign: textalign ?? TextAlign.center,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hinttext ?? '',
            hintStyle:
                kHeaderStyle1.copyWith(color: kMainBlack.withOpacity(0.38)),
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            enabledBorder: InputBorder.none),
        validator: validator,
        obscureText: obsecuretext ?? false);
  }
}

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {Key? key, required this.controller, this.hinttext, this.maxLine})
      : super(key: key);
  TextEditingController controller;
  String? hinttext;
  int? maxLine;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.width / 8,
      child: TextFormField(
        controller: controller,
        cursorColor: kPrimary,
        maxLines: maxLine ?? 1,
        style: kBodyStyle2,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 20, top: 13, bottom: 13, right: 20),
          hintText: hinttext??'',
          hintStyle: kBodyStyle2.copyWith(color: kMainBlack.withOpacity(0.38)),
            fillColor: Color(0xffF4F4F4),
            filled: true,
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Color(0xffF4F4F4))),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Color(0xffF4F4F4)))
            ),
      ),
    );
  }
}
