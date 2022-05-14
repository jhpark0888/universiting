import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:universiting/api/message_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/app_controller.dart';
import 'package:universiting/controllers/chat_list_controller.dart';
import 'package:universiting/controllers/profile_controller.dart';
import 'package:universiting/models/chat_list_model.dart';
import 'package:universiting/models/message_detail_model.dart';
import 'package:universiting/models/message_model.dart';
import 'package:universiting/models/profile_model.dart';
import 'package:universiting/widgets/chat_person_widget.dart';
import 'package:universiting/widgets/chat_widget.dart';

class MessageDetailController extends GetxController {
  static MessageDetailController get to => Get.find();
  MessageDetailController(this.groupId);
  TextEditingController chatController = TextEditingController();
  Rx<ScrollController> scrollController = ScrollController().obs;
  Rx<Profile> profile = ProfileController.to.profile;
  RxDouble maxHeight = 0.0.obs;
  String groupId;
  RxBool isSend = false.obs;
  RxBool isCalendar = false.obs;
  final focusDay =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 00,00)
          .obs;
  final selectedDay = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 00, 00).obs;
  final messageList = <Widget>[
    Center(
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            const TextSpan(
                text: '유니버시팅은 개인정보 보호를 위해\n', style: k13LightContent),
            TextSpan(
                text: '약속 시간 이후 채팅방이 삭제돼요\n',
                style: k13LightContent.copyWith(color: kPrimary)),
            const TextSpan(
                text: '만약 별도의 약속 시간을 설정하지 않으면\n', style: k13LightContent),
            TextSpan(
                text: '채팅방 생성 이후 일주일 뒤 자동 삭제되니\n',
                style: k13LightContent.copyWith(color: kPrimary)),
            TextSpan(
                text: '약속 시간을 설정해주세요\n',
                style: k13LightContent.copyWith(color: kPrimary)),
            const TextSpan(text: '\n', style: k13LightContent),
            const TextSpan(text: '아래 달력 아이콘을 통해\n', style: k13LightContent),
            const TextSpan(
                text: '언제든 약속 시간을 설정할 수 있으며\n', style: k13LightContent),
            const TextSpan(text: '여러 날짜를 입력할 경우\n', style: k13LightContent),
            const TextSpan(
                text: '가장 최근 설정된 날짜로 약속 시간이 변경돼요\n', style: k13LightContent),
            const TextSpan(text: '\n', style: k13LightContent),
            TextSpan(
                text: '그럼 새로운 친구에게 반갑게 인사해보세요!',
                style: k13LightContent.copyWith(color: kPrimary))
          ])),
    ),
    const SizedBox(height: 24),
  ].obs;
  final messageDetail = MessageDetail(
          userType: 0,
          message: [],
          groupTitle: '',
          memberProfile: [],
          university: '')
      .obs;
  final memberProfile = <Profile>[].obs;
  @override
  void onInit() async {
    AppController.to.addPage();
    print(AppController.to.stackPage);
    ChatListController.to.isInDetailMessage.value = true;
    profile.value.type = 1;
    messageDetail.value = await getMessageDetail(groupId, '0');
    memberProfile.value = messageDetail.value.memberProfile;
    messageList.addAll(messageDetail.value.message
        .map((e) => ChatWidget(
              message: e,
              userType: messageDetail.value.userType,
              profile: getFindProfile(e)[0],
            ))
        .toList());
    messageList.removeAt(2);
    scrollToBottom();
    initializeDateFormatting(Localizations.localeOf(Get.context!).languageCode);
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

  List<Profile> getFindProfile(Message message) {
    if (memberProfile.where((p0) => p0.userId == message.sender).isNotEmpty) {
      return memberProfile
          .where((profile) => message.sender == profile.userId)
          .toList();
    } else {
      return [
        Profile(
            age: 0,
            gender: 'M',
            introduction: '',
            nickname: '알수없음',
            profileImage: '',
            userId: 0)
      ];
    }
  }

  void onDayselected(DateTime day, DateTime day2) {
    print('선택된 날짜는 ${day}');
    selectedDay.value = day;
    print(selectedDay.value);
    focusDay.value = day;
  }

  void onPageChanged(DateTime day) {
    print('선택된 날짜는 ${day}');
    selectedDay.value = day;
    print(selectedDay.value);
    focusDay.value = day;
  }

  bool selectedDayPredicate(DateTime day) {
    return isSameDay(selectedDay.value, day);
  }

  List<ChatPersonWidget> hostMember(List<Profile> member) {
    List<Profile> list = [];
    for (Profile profile in member) {
      if (profile.type == 0) {
        list.add(profile);
      }
    }
    return getMemberInfo(list);
  }

  List<ChatPersonWidget> joinMember(List<Profile> member) {
    List<Profile> list = [];
    for (Profile profile in member) {
      if (profile.type == 1) {
        list.add(profile);
      }
    }
    return getMemberInfo(list);
  }

  List<ChatPersonWidget> getMemberInfo(List<Profile> member) {
    return member
        .map((e) => ChatPersonWidget(
              profile: e,
              width: 60,
            ))
        .toList();
  }
}
