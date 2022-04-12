import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/api/message_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/chat_list_controller.dart';
import 'package:universiting/controllers/message_detail_controller.dart';
import 'package:universiting/controllers/profile_controller.dart';
import 'package:universiting/controllers/scroll_controller.dart';
import 'package:universiting/models/chat_list_model.dart';
import 'package:universiting/models/message_model.dart';
import 'package:universiting/widgets/appbar_widget.dart';
import 'package:universiting/widgets/background_textfield_widget.dart';
import 'package:universiting/widgets/chat_room_widget.dart';
import 'package:universiting/widgets/chat_widget.dart';

class MessageDetailScreen extends StatelessWidget {
  MessageDetailScreen({Key? key, required this.groupId}) : super(key: key);
  String groupId;

  @override
  Widget build(BuildContext context) {
    MessageDetailController messageDetailController =
        Get.put(MessageDetailController(groupId));
    return Scaffold(
      appBar: AppBarWidget(
        leading: IconButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              Get.back();
            },
            icon: SvgPicture.asset('assets/icons/back.svg')),
        title: messageDetailController.messageDetail.value.groupTitle,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
        ],
      ),
      // bottomNavigationBar:  Transform.translate(
      //     offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
      //     child: Padding(
      //       padding: const EdgeInsets.fromLTRB(20, 8, 20, 23),
      //       child: BottomAppBar(
      //         elevation: 0,
      //         child: BackgroundTextfieldWidget(controller: messageDetailController.chatController, ischat: true,ontap: (){sendMessage(chatRoom.group.id.toString());},),
      //       ),
      //     ),
      //   ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(19, 20, 21, 23),
        child:
            // LayoutBuilder(builder: (context, constraints) {
            //   return
            // SingleChildScrollView(
            //   child:
            // ConstrainedBox(
            //   constraints: BoxConstraints(
            //       minWidth: constraints.maxWidth,
            //       minHeight: constraints.maxHeight),
            //   child: IntrinsicHeight(
            // child:
            //  Obx(
            //   () =>
            Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                // child: Column(
                //     children: messageDetailController.messageList)),
                child: Obx(
              () => GestureDetector(
                onTap: () {},
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
            )),
            BackgroundTextfieldWidget(
                controller: messageDetailController.chatController,
                ischat: true,
                ontap: () async {
                  messageDetailController.scrollToBottom();
                  await sendMessage(groupId).then((value) {
                    MessageDetailController.to.messageList.add(ChatWidget(
                      message: Message(
                        id: messageDetailController
                                .messageDetail.value.message.last.id +
                            1,
                        message: messageDetailController.chatController.text,
                        date: DateTime.now(),
                      ),
                      userType: '1',
                      profile: messageDetailController.profile.value,
                    ));
                    ChatListController
                        .to
                        .chatRoomList[ChatListController.to.chatRoomList
                            .indexWhere((chatRoomWidget) =>
                                chatRoomWidget.chatRoom.value.group.id
                                    .toString() ==
                                groupId)]
                        .chatRoom
                        .value
                        .message
                        .message = messageDetailController.chatController.text;
                    FocusScope.of(context).unfocus();
                    messageDetailController.chatController.clear();
                    ChatListController
                        .to
                        .chatRoomList[ChatListController.to.chatRoomList
                            .indexWhere((chatRoomWidget) =>
                                chatRoomWidget.chatRoom.value.group.id
                                    .toString() ==
                                groupId)]
                        .chatRoom
                        .refresh();
                  });
                })
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
