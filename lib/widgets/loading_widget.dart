import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      color: Colors.transparent,
      child: Center(
        child: Image.asset(
          'assets/icons/loading.gif',
          scale: 8,
        ),
      ),
    );
  }
}
