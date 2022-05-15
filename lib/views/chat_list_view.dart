import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/chat_list_controller.dart';
import 'package:universiting/widgets/chat_room_widget.dart';
import 'package:universiting/widgets/custom_refresher.dart';

class ChatListView extends StatelessWidget {
  ChatListView({Key? key}) : super(key: key);
  ChatListController chatListController = Get.put(ChatListController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(
            '채팅방',
            style: kHeaderStyle3,
          ),
        ),
        actions: [],
      ),
      body: SmartRefresher(
          controller: chatListController.refreshController,
          header: const CustomRefresherHeader(),
          onRefresh: chatListController.onRefreshChatList,
          child: Obx(() => SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 82),
                child: Column(
                    children: chatListController.chatRoomList != []
                        ? chatListController.chatRoomList.value
                        : []),
              )))),
    );
  }
}
