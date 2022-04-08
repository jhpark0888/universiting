import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:universiting/api/room_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/my_room_controller.dart';
import 'package:universiting/controllers/signup_controller.dart';
import 'package:universiting/widgets/custom_button_widget.dart';
import 'package:universiting/widgets/empty_back_textfield_widget.dart';

enum MoreType { delete, report }
void showCustomModalPopup(BuildContext context,
    {required String value1,
    String? value2,
    TextStyle? textStyle,
    required VoidCallback func1,
    VoidCallback? func2}) {
  showCupertinoModalPopup(
      barrierColor: kMainBlack.withOpacity(0.4),
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

void customDialog(int duration) {
  Get.dialog(
    AlertDialog(
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
        // contentPadding: EdgeInsets.fromLTRB(
        //   Get.width / 20,
        //   Get.width / 20,
        //   Get.width / 20,
        //   Get.width / 20,
        // ),
        insetPadding: const EdgeInsets.all(0),
        backgroundColor: Colors.transparent,
        content:  Container(
                height: Get.height,
                width: Get.width,
                color: Colors.transparent,
                child: Image.asset(
                  'assets/icons/loading.gif',
                  scale: 8,
                ),
              ),),
    barrierDismissible: false,
    barrierColor: Colors.transparent,
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

void showRoomDialog(
    TextEditingController? controller, String roomid, MoreType moretype) {
  Get.dialog(
    AlertDialog(
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
        contentPadding: const EdgeInsets.all(30),
        insetPadding: const EdgeInsets.only(left: 20, right: 20),
        backgroundColor: kBackgroundWhite,
        content: Container(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                  child: moretype != MoreType.delete
                      ? const Text('신고 사유를 입력해주세요', style: kSubtitleStyle2)
                      : const Text('방을 나가시겠어요?', style: kSubtitleStyle2)),
              const SizedBox(height: 15),
              moretype != MoreType.delete ?
              Container(
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
                    controller: controller!,
                    hinttext:
                        '신고 후 운영진이 신고 사유를 확인하며,\n운영 사항 위반이 확인될 경우 해당 방은 삭제됩니다.\n이후 관련 계정에 관하여 활동 정지 처분 등 제재가 이루어질 수 있습니다.',
                    hintstyle: kBodyStyle1.copyWith(
                        color: kMainBlack.withOpacity(0.4)),
                    maxLines: 5,
                    // cursorHeight: 20,
                    cursorWidth: 1.4,
                    textalign: TextAlign.center,
                    contentPadding: const EdgeInsets.only(
                        top: 10, bottom: 10, right: 20, left: 21.4),
                    textStyle: kBodyStyle1,
                  )) : const Text('참여한 방 친구 모두에게서 해당 방은 삭제되며, 방 목록에 더 이상 보이지 않아요\n해당 작업은 이후 복구할 수 없어요',style: kBodyStyle1,textAlign: TextAlign.center,),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 42,
                      padding: const EdgeInsets.fromLTRB(42, 14, 42, 14),
                      decoration: BoxDecoration(
                          color: kMainBlack.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              width: 0.5, color: kMainBlack.withOpacity(0.1))),
                      child: Text(
                        '닫기',
                        style: kActiveButtonStyle.copyWith(
                            color: kBackgroundWhite, height: 1),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () async {
                      print('눌렀다.');
                      moretype == MoreType.report ?
                      reportRoom(roomid, controller!.text)
                          .then((value) => Get.back())
                          :
                          deleteMyRoom(roomid);
                              Get.back();
                              print(MyRoomController.to.room.length);
                              MyRoomController.to.room.value = MyRoomController
                                  .to.room.value
                                  .where(
                                      (room) => room.room.id.toString() != roomid)
                                  .toList();
                          
                    },
                    child: Container(
                      height: 42,
                      padding: const EdgeInsets.fromLTRB(30, 14, 30, 14),
                      decoration: BoxDecoration(
                          color: const Color(0xffFF6565),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              width: 0.5, color: kMainBlack.withOpacity(0.1))),
                      child: moretype == MoreType.report ? Text(
                        '신고하기',
                        style: kActiveButtonStyle.copyWith(
                            color: kBackgroundWhite, height: 1),
                      ) : Text(
                        '삭제하기',
                        style: kActiveButtonStyle.copyWith(
                            color: kBackgroundWhite, height: 1))
                    ),
                  ),
                ],
              )
            ],
          ),
        )),
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.4),
  );
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
