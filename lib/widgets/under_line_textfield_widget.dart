import 'package:flutter/material.dart';
import 'package:universiting/constant.dart';

class UnderLineTexField extends StatelessWidget {
  final TextEditingController? textController;
  final String hintText;
  final String? Function(String?)? validator;
  final bool obscureText;
  final int? maxLines;
  final String? counterText;
  final int? maxLength;

  UnderLineTexField({
    required this.textController,
    required this.hintText,
    required this.validator,
    required this.obscureText,
    required this.maxLines,
    required this.counterText,
    required this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      obscureText: obscureText,
      autocorrect: false,
      minLines: 1,
      maxLines: maxLines,
      autofocus: true,
      style: k16Medium.copyWith(height: 1.5),
      cursorColor: kPrimary,
      cursorWidth: 1.2,
      cursorRadius: const Radius.circular(2),
      controller: textController,
      decoration: InputDecoration(
        counterText: counterText,
        contentPadding: const EdgeInsets.only(bottom: 12),
        isDense: true,
        hintText: hintText,
        hintStyle: k16Medium.copyWith(
          color: kMainBlack.withOpacity(0.38),
        ),
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: const BorderSide(color: kMainBlack, width: 1.2),
        ),
        disabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: const BorderSide(color: kMainBlack, width: 1.2),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: kMainBlack, width: 1.2),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: kMainBlack, width: 1.2),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: kMainBlack, width: 1.2),
        ),
      ),
      validator: validator,
    );
  }
}
