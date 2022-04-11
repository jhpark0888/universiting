import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/chat_list_controller.dart';
import 'package:universiting/models/chat_list_model.dart';
import 'package:universiting/views/message_detail_screen.dart';
import 'package:universiting/widgets/profile_image_widget.dart';

class ChatRoomWidget extends StatelessWidget {
  ChatRoomWidget({Key? key, required this.chatRoom, required this.imageList})
      : super(key: key);
  Rx<ChatRoom> chatRoom;
  List<ProfileImageWidget> imageList;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
            () => MessageDetailScreen(groupId: chatRoom.value.group.id.toString()));
            print(chatRoom.value.message.message);
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Container(
          decoration: BoxDecoration(
              color: kLightGrey, borderRadius: BorderRadius.circular(28)),
          child: imageList.isEmpty
              ? Text('아직 만들어진 채팅방이 없어요',
                  style: kSubtitleStyle2.copyWith(
                      color: kMainBlack.withOpacity(0.38)))
              : Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(children: [
                        imageList[0],
                        imageList[1],
                        const SizedBox(width: 12),
                        Text(
                          chatRoom.value.group.title,
                          style: kSubtitleStyle2,
                        ),
                        Expanded(
                          child: Text(
                              '${chatRoom.value.group.countMember.toString()}:${chatRoom.value.group.countMember.toString()}',
                              textAlign: TextAlign.end,
                              style: kSubtitleStyle2.copyWith(
                                  color: kMainBlack.withOpacity(0.6))),
                        )
                      ]),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          imageList[2],
                          imageList.length >3 ?
                          imageList[3] : Container(width:30, height:30),
                          SizedBox(width: 12),
                          Obx(
                            () => Text(
                              chatRoom.value.message.message,
                              style: kBodyStyle2.copyWith(
                                  color: kMainBlack.withOpacity(0.6)),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
