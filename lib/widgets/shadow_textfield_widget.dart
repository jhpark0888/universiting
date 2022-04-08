import 'package:flutter/material.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/widgets/empty_back_textfield_widget.dart';

class ShadowTextfieldWidget extends StatelessWidget {
  ShadowTextfieldWidget({ Key? key, required this.controller, required this.hintText, required this.maxLines, required this.textAlign}) : super(key: key);
  TextEditingController controller;
  String hintText;
  int maxLines;
  TextAlign textAlign;
  @override
  Widget build(BuildContext context) {
    return Container(
                  decoration: BoxDecoration(
                      color: kBackgroundWhite,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0x000000).withOpacity(0.1),
                            blurRadius: 3,
                            spreadRadius: 0,
                            offset: const Offset(0.0, 1.0))
                      ]),
                  child: EmptyBackTextfieldWidget(
                    controller: controller,
                    hinttext:
                        hintText,
                    hintstyle: kBodyStyle1.copyWith(
                        color: kMainBlack.withOpacity(0.4)),
                    maxLines: maxLines,
                    // cursorHeight: 20,
                    cursorWidth: 1.4,
                    textalign: textAlign,
                    contentPadding: const EdgeInsets.only(
                        top: 10, bottom: 10, right: 20, left: 21.4),
                    textStyle: kBodyStyle1,
                  ));
  }
}