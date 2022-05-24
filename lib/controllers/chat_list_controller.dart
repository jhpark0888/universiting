import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:universiting/api/chat_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/admob_controller.dart';
import 'package:universiting/controllers/profile_controller.dart';
import 'package:universiting/models/chat_list_model.dart';
import 'package:universiting/models/group_model.dart';
import 'package:universiting/models/host_model.dart';
import 'package:universiting/utils/global_variable.dart';
import 'package:universiting/widgets/chat_room_widget.dart';
import 'package:universiting/widgets/profile_image_widget.dart';

class ChatListController extends GetxController {
  static ChatListController get to => Get.find();
  final chatList = <ChatRoom>[].obs;
  final chatRoomList = <ChatRoomWidget>[].obs;
  final chatImageList = <ProfileImageWidget>[].obs;
  final finalChatRoomList = <Widget>[].obs;
  final isInDetailMessage = false.obs;
  final datetime = DateTime.now().obs;
  final otheruniv = ''.obs;
  RefreshController refreshController = RefreshController();
  AdmobController admobController = Get.put(AdmobController(), tag: 'ChatList');
  @override
  void onInit() async {
    await getList();
    initializeDateFormatting(Localizations.localeOf(Get.context!).languageCode);
    super.onInit();
  }

  Future getList() async {
    await getChatList().then((httpresponse) {
      if (httpresponse.isError == false) {
        chatList(List<ChatRoom>.from(httpresponse.data));
        chatRoomList.value = getChatRoomList();
        finalChatRoomList.value = getAdList(chatRoomList);
      } else {
        errorSituation(httpresponse);
      }
    });
  }

  List<ChatRoomWidget> getChatRoomList() {
    List<ChatRoomWidget> list = <ChatRoomWidget>[];
    for (ChatRoom chatRoom in chatList) {
      for (Host host in chatRoom.group.member) {
        chatImageList.add(ProfileImageWidget(
            type: ViewType.otherView, host: host, width: 50, height: 50));
      }
      list.add(ChatRoomWidget(
          chatRoom: chatRoom.obs, imageList: StackedImages(chatImageList).obs));
      chatImageList.clear();
    }

    return list;
  }

  void onRefreshChatList() async {
    await getList();
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

  List<Widget> getAdList(List<dynamic> room) {
    List<dynamic> list = List<dynamic>.from(room);
    if (room.length >= 2) {
      for (int a = 1; a < room.length; a++) {
        if (a % 1 == 0) {
          list.insert(
            a ,
              Container(
                 height: admobController.size.value.height.toDouble(),
              width: admobController.size.value.width.toDouble(),
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: AdWidget(ad: admobController.getBanner()..load())),
          );
        }
      }
    }
    return List<Widget>.from(list);
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

