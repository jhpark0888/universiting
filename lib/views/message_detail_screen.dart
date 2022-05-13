import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:universiting/api/chat_api.dart';
import 'package:universiting/api/message_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/chat_list_controller.dart';
import 'package:universiting/controllers/message_detail_controller.dart';
import 'package:universiting/controllers/profile_controller.dart';
import 'package:universiting/controllers/scroll_controller.dart';
import 'package:universiting/models/chat_list_model.dart';
import 'package:universiting/models/message_model.dart';
import 'package:universiting/models/profile_model.dart';
import 'package:universiting/views/message_detail_info.dart';
import 'package:universiting/widgets/appbar_widget.dart';
import 'package:universiting/widgets/background_textfield_widget.dart';
import 'package:universiting/widgets/chat_room_widget.dart';
import 'package:universiting/widgets/chat_widget.dart';
import 'package:universiting/widgets/scroll_noneffect_widget.dart';
import 'package:intl/date_symbol_data_local.dart';

class MessageDetailScreen extends StatelessWidget {
  MessageDetailScreen({Key? key, required this.groupId}) : super(key: key);
  String groupId;

  @override
  Widget build(BuildContext context) {
    MessageDetailController messageDetailController =
        Get.put(MessageDetailController(groupId));
    return Obx(
      () => Scaffold(
        backgroundColor: kBackgroundWhite,
        appBar: AppBarWidget(
          titlespacing: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 23.0),
            child: IconButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  Get.back();
                },
                icon: SvgPicture.asset('assets/icons/back.svg')),
          ),
          title: messageDetailController.messageDetail.value.university,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 18.5),
              child: IconButton(
                  onPressed: () {
                    Get.to(() => MessageDetailInfoView(
                        hostMember: messageDetailController
                            .hostMember(messageDetailController.memberProfile),
                        joinMember: messageDetailController.joinMember(
                            messageDetailController.memberProfile)));
                  },
                  icon: const Text(
                    '정보',
                    style: k16Medium,
                  )),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                // child: Column(
                //     children: messageDetailController.messageList)),
                child: Obx(
              () => GestureDetector(
                onTap: () {},
                child: ScrollNoneffectWidget(
                  child: ListView.builder(
                    reverse: true,
                    controller: messageDetailController.scrollController.value,
                    itemBuilder: (context, index) {
                      return messageDetailController.messageList.reversed
                          .toList()[index];
                    },
                    itemCount: messageDetailController.messageList.length,
                  ),
                ),
              ),
            )),
            Obx(
              () => Container(
                height: !messageDetailController.isCalendar.value ? 82 : 40,
                width: Get.width,
                decoration: const BoxDecoration(
                    // borderRadius: BorderRadius.only(
                    //     topLeft: Radius.circular(16),
                    //     topRight: Radius.circular(16)),
                    // borderRadius: BorderRadius.all(Radius.circular(16)),
                    border:
                        // Border.all(width: 0.3, color: const Color(0xff33343c1a))
                        Border(
                            left: BorderSide(
                                width: 0.3, color: Color(0xff33343c1a)),
                            right: BorderSide(
                                width: 0.3, color: Color(0xff33343c1a)),
                            top: BorderSide(
                                width: 0.3, color: Color(0xff33343c1a)),
                            bottom:
                                BorderSide(width: 0, color: kBackgroundWhite))),
                child: !messageDetailController.isCalendar.value
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20.5, 20, 20.5),
                        child: Row(children: [
                          GestureDetector(
                              onTap: () {
                                messageDetailController.isCalendar(true);
                              },
                              child: SvgPicture.asset(
                                  'assets/icons/calendar.svg')),
                          const SizedBox(width: 12),
                          Expanded(
                            child: BackgroundTextfieldWidget(
                                style: kLargeCaptionStyle.copyWith(height: 1),
                                hinttext: '내용을 입력하세요',
                                controller:
                                    messageDetailController.chatController),
                          ),
                          const SizedBox(width: 12),
                          GestureDetector(
                              onTap: () async {
                                if (messageDetailController
                                        .chatController.text !=
                                    '') {
                                  messageDetailController.scrollToBottom();
                                  await sendMessage(groupId).then((value) {
                                    MessageDetailController.to.messageList
                                        .add(ChatWidget(
                                      message: Message(
                                          id: messageDetailController
                                                  .messageDetail
                                                  .value
                                                  .message
                                                  .last
                                                  .id +
                                              1,
                                          message: messageDetailController
                                              .chatController.text,
                                          date: DateTime.now(),
                                          sender: ProfileController
                                              .to.profile.value.userId),
                                      userType: 1,
                                      profile:
                                          messageDetailController.profile.value,
                                    ));
                                    ChatListController
                                            .to
                                            .chatRoomList[ChatListController
                                                .to.chatRoomList
                                                .indexWhere((chatRoomWidget) =>
                                                    chatRoomWidget
                                                        .chatRoom.value.group.id
                                                        .toString() ==
                                                    groupId)]
                                            .chatRoom
                                            .value
                                            .message
                                            .message =
                                        messageDetailController
                                            .chatController.text;
                                    ChatListController
                                            .to
                                            .chatRoomList[ChatListController
                                                .to.chatRoomList
                                                .indexWhere((chatRoomWidget) =>
                                                    chatRoomWidget
                                                        .chatRoom.value.group.id
                                                        .toString() ==
                                                    groupId)]
                                            .chatRoom
                                            .value
                                            .message
                                            .sender =
                                        ProfileController.to.profile.value.userId;
                                    FocusScope.of(context).unfocus();
                                    messageDetailController.chatController
                                        .clear();
                                    ChatListController
                                        .to
                                        .chatRoomList[ChatListController
                                            .to.chatRoomList
                                            .indexWhere((chatRoomWidget) =>
                                                chatRoomWidget
                                                    .chatRoom.value.group.id
                                                    .toString() ==
                                                groupId)]
                                        .chatRoom
                                        .refresh();
                                  });
                                  ChatListController.to.chatRoomList.refresh();
                                  print('이거래');
                                  print(ChatListController
                                      .to
                                      .chatRoomList[ChatListController
                                          .to.chatRoomList
                                          .indexWhere((chatRoomWidget) =>
                                              chatRoomWidget
                                                  .chatRoom.value.group.id
                                                  .toString() ==
                                              groupId)]
                                      .chatRoom
                                      .value
                                      .message
                                      .message);
                                  postTime(
                                      int.parse(groupId),
                                      ProfileController
                                          .to.profile.value.userId);
                                }
                              },
                              child:
                                  SvgPicture.asset('assets/icons/sender.svg'))
                        ]),
                      )
                    : Padding(
                        padding: const EdgeInsets.fromLTRB(0, 9.5, 20, 9.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  messageDetailController.focusDay.value =
                                      messageDetailController.selectedDay.value;
                                  messageDetailController.isCalendar(false);
                                  await updateTime(
                                      groupId,
                                      messageDetailController
                                          .selectedDay.value);
                                  MessageDetailController.to.messageList
                                      .add(ChatWidget(
                                    message: Message(
                                        id: messageDetailController
                                                .messageDetail
                                                .value
                                                .message
                                                .last
                                                .id +
                                            1,
                                        message:
                                            "'${messageDetailController.profile.value.nickname}'님이 약속시간을 ${DateFormat('yyyy-MM-dd').format(messageDetailController.selectedDay.value)}로 설정했어요",
                                        date: DateTime.now(),
                                        sender: 1),
                                    userType: 1,
                                    profile:
                                        messageDetailController.profile.value,
                                  ));
                                  ChatListController
                                          .to
                                          .chatRoomList[ChatListController
                                              .to.chatRoomList
                                              .indexWhere((chatRoomWidget) =>
                                                  chatRoomWidget
                                                      .chatRoom.value.group.id
                                                      .toString() ==
                                                  groupId)]
                                          .chatRoom
                                          .value
                                          .message
                                          .message =
                                      "'${messageDetailController.profile.value.nickname}'님이 약속시간을 ${DateFormat('yyyy-MM-dd').format(messageDetailController.selectedDay.value)}로 설정했어요";
                                  ChatListController
                                          .to
                                          .chatRoomList[ChatListController
                                              .to.chatRoomList
                                              .indexWhere((chatRoomWidget) =>
                                                  chatRoomWidget
                                                      .chatRoom.value.group.id
                                                      .toString() ==
                                                  groupId)]
                                          .chatRoom
                                          .value
                                          .group
                                          .date =
                                      messageDetailController.selectedDay.value;
                                  ChatListController.to.chatRoomList.refresh();
                                  ChatListController
                                      .to
                                      .chatRoomList[ChatListController
                                          .to.chatRoomList
                                          .indexWhere((chatRoomWidget) =>
                                              chatRoomWidget
                                                  .chatRoom.value.group.id
                                                  .toString() ==
                                              groupId)]
                                      .chatRoom
                                      .refresh();
                                  postTime(
                                      int.parse(groupId),
                                      ProfileController
                                          .to.profile.value.userId);
                                },
                                child: Text(
                                  '약속 시간 설정하기',
                                  style:
                                      kSubtitleStyle3.copyWith(color: kPrimary),
                                ))
                          ],
                        ),
                      ),
              ),
            ),
            Obx(() => messageDetailController.isCalendar.value == true
                ? TableCalendar(
                    locale: 'ko-KR',
                    firstDay: DateTime.now().add(const Duration(days: -60)),
                    lastDay: DateTime.now().add(const Duration(days: 60)),
                    focusedDay: messageDetailController.focusDay.value,
                    calendarFormat: CalendarFormat.month,
                    availableCalendarFormats: const {
                      CalendarFormat.month: '한달'
                    },
                    selectedDayPredicate:
                        messageDetailController.selectedDayPredicate,
                    onDaySelected: messageDetailController.onDayselected,
                    // onPageChanged: (focusedDay),
                  )
                : const SizedBox.shrink())
          ],
          // ),
          // ),
          //   ),
          // ),
          // );
          // }
        ),
      ),
    );
  }
}
