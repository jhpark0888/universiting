import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/app_controller.dart';
import 'package:universiting/controllers/chat_list_controller.dart';
import 'package:universiting/widgets/chat_room_widget.dart';
import 'package:universiting/widgets/custom_refresher.dart';
import 'package:universiting/widgets/scroll_noneffect_widget.dart';

class ChatListView extends StatelessWidget {
  ChatListView({Key? key}) : super(key: key);
  ChatListController chatListController = Get.put(ChatListController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        try {
          if (Platform.isAndroid &&
              (AppController.to.currentIndex.value == 2)) {
            AppController.to.currentIndex(0);
            return false;
          }
        } catch (e) {
          print(e);
        }

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          elevation: 0,
          titleSpacing: 20,
          title: const Padding(
            padding: EdgeInsets.only(top: 28),
            child: Text(
              '채팅방',
              style: k26SemiBold,
            ),
          ),
        ),
        body: ScrollNoneffectWidget(
          child: SmartRefresher(
              controller: chatListController.refreshController,
              header: const CustomRefresherHeader(),
              onRefresh: chatListController.onRefreshChatList,
              child: Obx(() => chatListController.chatRoomList.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '아직 채팅방이 없어요',
                          style: kSubtitleStyle2.copyWith(
                              color: kMainBlack.withOpacity(0.38)),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  : SingleChildScrollView(
                      child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 82),
                      child: Column(
                          children: chatListController.chatRoomList != []
                              ? chatListController.finalChatRoomList.value
                              : []),
                    )))),
        ),
      ),
    );
  }
}
