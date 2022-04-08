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
      this.hintstyle,
      this.textStyle,
      this.textalign,
      this.cursorHeight,
      this.cursorWidth,
      this.maxLines,
      this.contentPadding})
      : super(key: key);
  TextEditingController controller;
  TextAlign? textalign;
  TextStyle? textStyle;
  TextStyle? hintstyle;
  TextInputType? textInputType;
  String? Function(String?)? validator;
  String? hinttext;
  bool? obsecuretext;
  int? maxLines;
  double? cursorWidth;
  double? cursorHeight;
  EdgeInsetsGeometry? contentPadding;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      autofocus: true,
      toolbarOptions: const ToolbarOptions(
        copy: true,
        cut: true,
        paste: true,
        selectAll: true,
      ),
      autocorrect: false,
      enableSuggestions: false,
      controller: controller,
      cursorColor: kPrimary,
      cursorWidth: cursorWidth ?? 1.4,
      cursorHeight: cursorHeight ?? 22,
      cursorRadius: Radius.zero,
      style: textStyle ?? kHeaderStyle2,
      textAlign: textalign ?? TextAlign.center,
      decoration: InputDecoration(
          contentPadding: contentPadding ??
              const EdgeInsets.symmetric(
                horizontal: 0,
                vertical: 10,
              ),
          isDense: true,
          border: InputBorder.none,
          hintText: hinttext ?? '',
          hintStyle: hintstyle ??
              kHeaderStyle2.copyWith(color: kMainBlack.withOpacity(0.38)),
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          disabledBorder: InputBorder.none),
      validator: validator,
      obscureText: obsecuretext ?? false,
      maxLines: maxLines,
    );
  }
}
