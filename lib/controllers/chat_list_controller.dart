import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:universiting/api/chat_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/profile_controller.dart';
import 'package:universiting/models/chat_list_model.dart';
import 'package:universiting/models/group_model.dart';
import 'package:universiting/models/host_model.dart';
import 'package:universiting/widgets/chat_room_widget.dart';
import 'package:universiting/widgets/profile_image_widget.dart';

class ChatListController extends GetxController {
  static ChatListController get to => Get.find();
  final chatList = <ChatRoom>[].obs;
  final chatRoomList = <ChatRoomWidget>[].obs;
  final chatImageList = <ProfileImageWidget>[].obs;
  final isInDetailMessage = false.obs;
  final datetime = DateTime.now().obs;
  final otheruniv = ''.obs;
  RefreshController refreshController = RefreshController();
  @override
  void onInit() async {
    chatList.value = await getChatList();
    chatRoomList.value = getChatRoomList();
    initializeDateFormatting(Localizations.localeOf(Get.context!).languageCode);
    super.onInit();
  }

  void getList() async {
    chatList.value = await getChatList();
    chatRoomList.value = getChatRoomList();
  }

  List<ChatRoomWidget> getChatRoomList() {
    List<ChatRoomWidget> list = <ChatRoomWidget>[];
    for (ChatRoom chatRoom in chatList) {
      for (Host host in chatRoom.group.member) {
        chatImageList.add(ProfileImageWidget(
            type: ViewType.otherView, host: host, width: 50, height: 50));
        
      }
      list.add(ChatRoomWidget(
            chatRoom: chatRoom.obs,
            imageList: StackedImages(chatImageList).obs));
      chatImageList.clear();
    }

    return list;
  }

  void onRefreshChatList() async {
    chatList.value = await getChatList();
    chatRoomList.value = getChatRoomList();
    refreshController.refreshCompleted();
    print('리프레시 완료');
  }

  String calculateDate(DateTime date) {
    if (date.difference(DateTime.now()).inHours <= 24) {
      return '${date.difference(DateTime.now()).inHours}시간 뒤에 이 채팅방은 삭제돼요';
    } else if (date.difference(DateTime.now()).inDays <= 31) {
      return '${date.difference(DateTime.now()).inDays + 1}일 뒤에 이 채팅방은 삭제돼요';
    } else if (date.difference(DateTime.now()).inDays <= 365) {
      return '일 년 이내 만들어진 방';
    }
    return '일 년 이전 만들어진 방';
  }
}

List<Widget> StackedImages(List<ProfileImageWidget> image) {
  return image
      .asMap()
      .map((index, item) {
        const left = 20.0;
        final value = Container(
          width: 50,
          height: 50,
          child: item,
          margin: EdgeInsets.only(left: left * index),
        );
        return MapEntry(index, value);
      })
      .values
      .toList();
}
