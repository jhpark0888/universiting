import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universiting/api/message_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/chat_list_controller.dart';
import 'package:universiting/controllers/message_detail_controller.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/controllers/profile_controller.dart';
import 'package:universiting/utils/global_variable.dart';
import 'package:universiting/widgets/appbar_widget.dart';
import 'package:get/get.dart';
import 'package:universiting/widgets/chat_person_widget.dart';

class MessageDetailInfoView extends StatelessWidget {
  MessageDetailInfoView(
      {Key? key, required this.hostMember, required this.joinMember})
      : super(key: key);
  List<ChatPersonWidget> hostMember;
  List<ChatPersonWidget> joinMember;
  MessageDetailController messageDetailController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(title: '정보', actions: [
          IconButton(
              onPressed: () {
                showCustomModalPopup(context, value1: '채팅 나가기', func1: () {
                  exitChat(MessageDetailController.to.groupId);
                  getbacks(2);
                  ChatListController.to.chatRoomList.remove(
                      ChatListController.to.chatRoomList[ChatListController
                          .to.chatRoomList
                          .indexWhere((chatRoomWidget) =>
                              chatRoomWidget.chatRoom.value.group.id
                                  .toString() ==
                              MessageDetailController.to.groupId)]);
                  ChatListController.to.chatRoomList.refresh();
                }, textStyle: kSubtitleStyle3.copyWith(color: kErrorColor));
              },
              icon: SvgPicture.asset('assets/icons/more.svg'))
        ]),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    messageDetailController.messageDetail.value.userType != 0
                        ? Text(
                            "${messageDetailController.messageDetail.value.university} 내\n'${messageDetailController.messageDetail.value.groupTitle}'방에\n${messageDetailController.profile.value.university}에서 신청했어요 ",
                            style: kInActiveButtonStyle.copyWith(height: 1.5),
                            textAlign: TextAlign.center,
                          )
                        : Text(
                            "${messageDetailController.profile.value.university} 내\n'${messageDetailController.messageDetail.value.groupTitle}'방에\n${messageDetailController.messageDetail.value.university}에서 신청했어요 ",
                            style: kInActiveButtonStyle.copyWith(height: 1.5),
                            textAlign: TextAlign.center),
                    const SizedBox(height: 26),
                    messageDetailController.messageDetail.value.userType != 0
                        ? Text(
                            messageDetailController
                                .messageDetail.value.university,
                            style: kSubtitleStyle1,
                          )
                        : Text(
                            messageDetailController.profile.value.university!,
                            style: kSubtitleStyle1),
                    Column(children: hostMember),
                    const SizedBox(height: 24),
                    messageDetailController.messageDetail.value.userType == 0
                        ? Text(
                            messageDetailController
                                .messageDetail.value.university,
                            style: kSubtitleStyle1)
                        : Text(
                            messageDetailController.profile.value.university!,
                            style: kSubtitleStyle1),
                    Column(children: joinMember)
                  ]),
            )));
  }
}
