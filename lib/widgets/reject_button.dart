import 'package:flutter/material.dart';
import 'package:universiting/constant.dart';

class RejectButton extends StatelessWidget {
  const RejectButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(30, 13, 30, 13),
      decoration: BoxDecoration(
          color: kBackgroundWhite,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(width: 1, color: kMainBlack.withOpacity(0.1))),
      child: Center(
        child: Text(
          '거절하기',
          style: k16Medium.copyWith(color: kred),
        ),
      ),
    );
  }
}
