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
        maxLines: 1,
        style: kHeaderStyle1,
        textAlign: textalign ??TextAlign.center,
        decoration: InputDecoration(
          focusColor: Colors.black,
          border: InputBorder.none,
          hintText: hinttext ?? '',
          hintStyle: kHeaderStyle2.copyWith(color: kMainBlack.withOpacity(0.38)),
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            // enabledBorder: UnderlineInputBorder(
            //     borderRadius: BorderRadius.circular(2),
            //     borderSide: const BorderSide(color: Colors.black))),
            enabledBorder: InputBorder.none),
        validator: validator,
        obscureText: obsecuretext ?? false);
  }
}
