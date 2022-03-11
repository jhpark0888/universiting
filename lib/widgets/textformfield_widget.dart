import 'package:flutter/material.dart';

import '../constant.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {Key? key, required this.controller, this.validator, this.obsecuretext, this.hinttext, this.textalign})
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
        textAlign: textalign ??TextAlign.center,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hinttext ?? '',
          hintStyle: kHeaderStyle1.copyWith(color: kMainBlack.withOpacity(0.38)),
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            enabledBorder: InputBorder.none),
        validator: validator,
        obscureText: obsecuretext ?? false);
  }
}
