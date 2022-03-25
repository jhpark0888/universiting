import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  @override
  void onInit() async{
    chatList.value = await getChatList();
    print(chatList);
    chatRoomList.value = getChatRoomList();
    super.onInit();
  }

  List<ChatRoomWidget> getChatRoomList(){
    List<ChatRoomWidget> list = <ChatRoomWidget>[];
    for(ChatRoom chatRoom in chatList){
      print('$chatRoom chatRoom');
      for(Host host in chatRoom.group.memberImages){
        print('$host 호스트다');
        chatImageList.add(ProfileImageWidget(type: RoomType.otherView, host: host));
      }
      list.add(ChatRoomWidget(chatRoom: chatRoom, imageList: chatImageList));
    }
    return list;
  }
}