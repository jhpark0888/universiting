import 'package:flutter/material.dart';
import 'package:universiting/api/message_api.dart';

import '../constant.dart';

class BackgroundTextfieldWidget extends StatelessWidget {
  BackgroundTextfieldWidget(
      {Key? key,
      required this.controller,
      this.hinttext,
      this.maxLine,
      this.height,
      this.obsecure,
      this.ischat,
      this.ontap,
      this.style})
      : super(key: key);
  TextEditingController controller;
  bool? obsecure;
  String? hinttext;
  int? maxLine;
  double? height;
  bool? ischat;
  VoidCallback? ontap;
  TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        autocorrect: false,
        controller: controller,
        cursorColor: kPrimary,
        maxLines: maxLine ?? 1,
        style: style ?? kSubtitleStyle3,
        obscureText: obsecure ?? false,
        decoration: InputDecoration(
          suffixIcon:ischat != null ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: ontap,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 12, right: 20),
                  child: Container(
                    decoration: BoxDecoration(color: kMainBlack.withOpacity(0.38), borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                    child: Text('보내기',style: kSmallCaptionStyle.copyWith(color: kMainWhite),),
                  )),
                ),
              ),
            ],
          ) : SizedBox.shrink(),
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
