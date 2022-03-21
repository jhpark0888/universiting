import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';

class SelectedNameWidget extends StatelessWidget {
  SelectedNameWidget({ Key? key, required this.name }) : super(key: key);
  String name;
  @override
  Widget build(BuildContext context) {
    return Container(
                height: Get.width / 10,
                width: Get.width / 4,
                decoration: BoxDecoration(color: kLightGrey, borderRadius: BorderRadius.circular(16)),
                child: Center(child: Text(name, style: kInActiveButtonStyle,)));
  }
}