import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: Get.width / 7,
          height: Get.width / 7,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: kMainBlack.withOpacity(0.38)),
        ),
        SizedBox(width: 8,)
      ],
    );
  }
}
