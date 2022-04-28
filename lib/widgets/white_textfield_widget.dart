import 'package:flutter/material.dart';
import 'package:universiting/api/message_api.dart';

import '../constant.dart';

class WhiteTextfieldWidget extends StatelessWidget {
  WhiteTextfieldWidget(
      {Key? key,
      required this.controller,
      this.hinttext,
      this.maxLine,
      this.maxlenght,
      this.height,
      this.prefixicon,
      this.obsecure,
      this.ontap,
      this.hintstyle})
      : super(key: key);
  TextEditingController controller;
  bool? obsecure;
  String? hinttext;
  TextStyle? hintstyle;
  int? maxLine;
  int? maxlenght;
  Widget? prefixicon;
  double? height;
  VoidCallback? ontap;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      controller: controller,
      cursorColor: kPrimary,
      maxLines: maxLine ?? 1,
      maxLength: maxlenght,
      style: kSubtitleStyle3.copyWith(height: height),
      obscureText: obsecure ?? false,
      decoration: InputDecoration(
        counterText: "",
        isDense: true,
        contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        prefixIcon: prefixicon,
        hintText: hinttext ?? '',
        hintStyle: hintstyle ??
            kSubtitleStyle3.copyWith(color: kMainBlack.withOpacity(0.38)),
        fillColor: Colors.transparent,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            width: 1,
            color: kMainBlack.withOpacity(0.1),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            width: 1,
            color: kMainBlack.withOpacity(0.1),
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            width: 1,
            color: kMainBlack.withOpacity(0.1),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            width: 1,
            color: kMainBlack.withOpacity(0.1),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            width: 1,
            color: kMainBlack.withOpacity(0.1),
          ),
        ),
      ),
      textInputAction: TextInputAction.newline,
    );
  }
}
