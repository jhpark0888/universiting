import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';

void showCustomModalPopup(BuildContext context,
    {required String value1,
    required String value2,
    required VoidCallback func1,
    required VoidCallback func2}) {
  showCupertinoModalPopup(
      barrierColor: kMainBlack.withOpacity(0.1),
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Get.back();
              },
              child: const Text(
                '닫기',
                style: kBodyStyle2,
              ),
              isDefaultAction: true,
            ),
            actions: [
              CupertinoActionSheetAction(
                child: Text(value1, style: kBodyStyle2,),
                onPressed: func1,
              ),
              CupertinoActionSheetAction(child: Text(value2, style: kBodyStyle2,), onPressed: func2,)
            ]);
      });
}
