import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:universiting/api/chat_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/models/chat_list_model.dart';
import 'package:universiting/models/group_model.dart';
import 'package:universiting/models/host_model.dart';
import 'package:universiting/widgets/chat_room_widget.dart';
import 'package:universiting/widgets/profile_image_widget.dart';

class ChatListController extends GetxController{
  static ChatListController get to => Get.find();
  final chatList = <ChatRoom>[].obs;
  final chatRoomList = <ChatRoomWidget>[].obs;
  final chatImageList = <ProfileImageWidget>[].obs;
  final isInDetailMessage = false.obs;
  RefreshController refreshController = RefreshController();
  @override
  void onInit() async{
    chatList.value = await getChatList();
    chatRoomList.value = getChatRoomList();
    super.onInit();
  }

  List<ChatRoomWidget> getChatRoomList(){
    List<ChatRoomWidget> list = <ChatRoomWidget>[];
    for(ChatRoom chatRoom in chatList){
      for(Host host in chatRoom.group.memberImages){
        chatImageList.add(ProfileImageWidget(type: ViewType.otherView, host: host, width: 28,height: 28));
      }
      list.add(ChatRoomWidget(chatRoom: chatRoom, imageList: chatImageList.value));
    }
    return list;
  }

  void onRefreshChatList()async{
    chatList.value = await getChatList();
    chatRoomList.value = getChatRoomList();
    refreshController.refreshCompleted();
    print('리프레시 완료');
  }
}