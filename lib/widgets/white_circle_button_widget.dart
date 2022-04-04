import 'package:flutter/material.dart';
import 'package:universiting/constant.dart';

class WhiteCircleButtonWidget extends StatelessWidget {
  WhiteCircleButtonWidget({Key? key, required this.onTap, required this.icon})
      : super(key: key);

  Function() onTap;
  Widget icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24), color: kBackgroundWhite),
        child: Center(child: icon),
      ),
    );
  }
}
