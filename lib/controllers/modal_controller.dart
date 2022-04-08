import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/signup_controller.dart';

void showCustomModalPopup(BuildContext context,
    {required String value1,
    String? value2,
    TextStyle? textStyle,
    required VoidCallback func1,
    VoidCallback? func2}) {
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
                child: Text(
                  value1,
                  style: textStyle ?? kBodyStyle2,
                ),
                onPressed: func1,
              ),
              if (value2 != null && func2 != null)
                CupertinoActionSheetAction(
                  child: Text(
                    value2,
                    style: kBodyStyle2,
                  ),
                  onPressed: func2,
                )
            ]);
      });
}

void showcustomCustomDialog(int duration) {
  Get.dialog(
    AlertDialog(
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
        contentPadding: EdgeInsets.fromLTRB(
          Get.width / 20,
          Get.width / 20,
          Get.width / 20,
          Get.width / 20,
        ),
        insetPadding: EdgeInsets.symmetric(horizontal: 130),
        backgroundColor: Colors.black.withOpacity(0.6),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SpinKitFadingCircle(
              color: kMainWhite.withOpacity(0.6),
              size: 50,
            ),
          ],
        )),
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.3),
    // transitionCurve: kAnimationCurve,
    // transitionDuration: kAnimationDuration,
  );
}

void showCustomDialog(String title, int duration) {
  Get.dialog(
    AlertDialog(
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
      contentPadding: EdgeInsets.fromLTRB(20, 12, 20, 12),
      backgroundColor: Colors.white,
      content: Text(
        title,
        style: kSubtitleStyle3,
        textAlign: TextAlign.center,
      ),
    ),
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.3),
    // transitionCurve: kAnimationCurve,
    // transitionDuration: kAnimationDuration,
  );
  Future.delayed(Duration(milliseconds: duration), () {
    Get.back();
  });
}

void showemailchecksnackbar(String message) {
  Get.closeCurrentSnackbar();
  Get.snackbar(
    '',
    '',
    titleText: Container(),
    messageText: Text(
      message,
      textAlign: TextAlign.center,
      style: kBodyStyle2.copyWith(color: kMainWhite),
    ),
    snackStyle: SnackStyle.FLOATING,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: kPrimary,
    padding: const EdgeInsets.fromLTRB(0, 25, 0, 30),
    margin: const EdgeInsets.fromLTRB(30, 20, 30, 20),
    borderRadius: 16,
  );
}

void showdatepicker(
  BuildContext context,
) {
  DatePicker.showDatePicker(
    context,
    showTitleActions: true,
    minTime: DateTime(1988, 1, 1),
    maxTime: DateTime(DateTime.now().year - 17, 12, 31),
    theme: DatePickerTheme(
      headerColor: kMainWhite,
      backgroundColor: kMainWhite,
      cancelStyle: kSubtitleStyle3.copyWith(
        color: kMainBlack.withOpacity(0.6),
      ),
      itemStyle: kSubtitleStyle3,
      doneStyle: kSubtitleStyle3.copyWith(
        color: kPrimary,
        fontWeight: FontWeight.w500,
      ),
    ),
    onChanged: (date) {},
    onConfirm: (date) {
      SignupController.to.birthdate(date);
    },
    currentTime: DateTime.now(),
    locale: LocaleType.ko,
  );
}
