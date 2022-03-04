import 'package:flutter/material.dart';

import '../constant.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {Key? key, required this.controller, this.validator, this.obsecuretext})
      : super(key: key);
  TextEditingController controller;
  String? Function(String?)? validator;
  bool? obsecuretext;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        maxLines: 1,
        style: TstyleContent,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: const BorderSide(color: Colors.black)),
            errorBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: const BorderSide(color: Colors.black)),
            enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: const BorderSide(color: Colors.black))),
        validator: validator,
        obscureText: obsecuretext ?? false);
  }
}
