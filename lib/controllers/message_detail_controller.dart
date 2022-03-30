import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/api/message_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/app_controller.dart';
import 'package:universiting/controllers/chat_list_controller.dart';
import 'package:universiting/models/chat_list_model.dart';
import 'package:universiting/models/message_detail_model.dart';
import 'package:universiting/models/message_model.dart';
import 'package:universiting/models/profile_model.dart';
import 'package:universiting/widgets/chat_widget.dart';

class MessageDetailController extends GetxController {
  static MessageDetailController get to => Get.find();
  MessageDetailController(this.groupId);
  TextEditingController chatController = TextEditingController();
  Rx<ScrollController> scrollController = ScrollController().obs;
  RxDouble maxHeight = 0.0.obs;
  String groupId;
  RxBool isSend = false.obs;
  final messageList = <Widget>[
    Text(
      '서로 간단하게 인사를 나눠볼까요?',
      style: kSmallCaptionStyle.copyWith(color: kMainBlack.withOpacity(0.6)),
      textAlign: TextAlign.center,
    ),
    const SizedBox(height: 24),
  ].obs;
  final messageDetail = MessageDetail(userType: '0', message: []).obs;

  @override
  void onInit() async {
    AppController.to.addPage();
    print(AppController.to.stackPage);
    ChatListController.to.isInDetailMessage.value = true;
    messageDetail.value =
        await getMessageDetail(groupId, '0');
    messageList.addAll(messageDetail.value.message
        .map((e) => ChatWidget(
              message: e,
              userType: messageDetail.value.userType,
            ))
        .toList());
    scrollToBottom();
    super.onInit();
  }

  @override
  void onClose() {
    AppController.to.deletePage();
    print(AppController.to.stackPage);
    ChatListController.to.isInDetailMessage.value = false;
    super.onClose();
  }

  void scrollToBottom() {
    if (scrollController.value.hasClients) {
      if (scrollController.value.offset != 0) {
        scrollController.value.jumpTo(
          0,
        );
      }
    }
  }
}
