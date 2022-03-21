import 'package:flutter/material.dart';

import '../constant.dart';

class BackgroundTextfieldWidget extends StatelessWidget {
  BackgroundTextfieldWidget(
      {Key? key,
      required this.controller,
      this.hinttext,
      this.maxLine,
      this.height,
      this.obsecure})
      : super(key: key);
  TextEditingController controller;
  bool? obsecure;
  String? hinttext;
  int? maxLine;
  double? height;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: controller,
        cursorColor: kPrimary,
        maxLines: maxLine ?? 1,
        style: kSubtitleStyle3,
        obscureText: obsecure ?? false,
        decoration: InputDecoration(
          isDense: true,
          contentPadding:
              EdgeInsets.only(left: 20, top: 13, bottom: 13, right: 20),
          hintText: hinttext ?? '',
          hintStyle:
              kSubtitleStyle3.copyWith(color: kMainBlack.withOpacity(0.38)),
          fillColor: kLightGrey,
          filled: true,
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: kLightGrey,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: kLightGrey,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: kLightGrey,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: kLightGrey,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: kLightGrey,
            ),
          ),
        ),
        textInputAction: TextInputAction.newline,
      ),
    );
  }
}
