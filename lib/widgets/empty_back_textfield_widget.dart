import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant.dart';

class EmptyBackTextfieldWidget extends StatelessWidget {
  EmptyBackTextfieldWidget(
      {Key? key,
      required this.controller,
      this.textInputType,
      this.validator,
      this.obsecuretext,
      this.hinttext,
      this.textalign})
      : super(key: key);
  TextEditingController controller;
  TextAlign? textalign;
  String? Function(String?)? validator;
  String? hinttext;
  TextInputType? textInputType;
  bool? obsecuretext;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        keyboardType: textInputType,
        autofocus: true,
        toolbarOptions: ToolbarOptions(
          copy: true,
          cut: true,
          paste: true,
          selectAll: true,
        ),
        autocorrect: false,
        enableSuggestions: false,
        controller: controller,
        cursorColor: kPrimary,
        cursorWidth: 1.4,
        cursorHeight: 22,
        cursorRadius: Radius.zero,
        style: kHeaderStyle2,
        textAlign: textalign ?? TextAlign.center,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            isDense: true,
            border: InputBorder.none,
            hintText: hinttext ?? '',
            hintStyle:
                kHeaderStyle2.copyWith(color: kMainBlack.withOpacity(0.38)),
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            disabledBorder: InputBorder.none),
        validator: validator,
        obscureText: obsecuretext ?? false);
  }
}
