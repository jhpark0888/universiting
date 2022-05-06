import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:universiting/api/chat_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/chat_list_controller.dart';
import 'package:universiting/controllers/profile_controller.dart';
import 'package:universiting/models/chat_list_model.dart';
import 'package:universiting/utils/global_variable.dart';
import 'package:universiting/views/message_detail_screen.dart';
import 'package:universiting/widgets/profile_image_widget.dart';

// class ChatRoomWidget extends StatelessWidget {
//   ChatRoomWidget({Key? key, required this.chatRoom, required this.imageList})
//       : super(key: key);
//   Rx<ChatRoom> chatRoom;
//   List<ProfileImageWidget> imageList;
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Get.to(
//             () => MessageDetailScreen(groupId: chatRoom.value.group.id.toString()));
//             print(chatRoom.value.message.message);
//       },
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
//         child: Container(
//           height: 234,
//           decoration: BoxDecoration(
//               color: kLightGrey, borderRadius: BorderRadius.circular(28)),
//           child: imageList.isEmpty
//               ? Text('아직 만들어진 채팅방이 없어요',
//                   style: kSubtitleStyle2.copyWith(
//                       color: kMainBlack.withOpacity(0.38)))
//               : Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Row(children: [
//                         imageList[0],
//                         imageList[1],
//                         const SizedBox(width: 12),
//                         Text(
//                           chatRoom.value.group.title,
//                           style: kSubtitleStyle2,
//                         ),
//                         Expanded(
//                           child: Text(
//                               '${chatRoom.value.group.countMember.toString()}:${chatRoom.value.group.countMember.toString()}',
//                               textAlign: TextAlign.end,
//                               overflow: TextOverflow.ellipsis,
//                               style: kSubtitleStyle2.copyWith(
//                                   color: kMainBlack.withOpacity(0.6))),
//                         )
//                       ]),
//                       const SizedBox(height: 2),
//                       Row(
//                         children: [
//                           imageList[2],
//                           imageList.length >3 ?
//                           imageList[3] : Container(width:30, height:30),
//                           SizedBox(width: 12),
//                           Obx(
//                             () => Text(
//                               chatRoom.value.message.message,
//                               style: kBodyStyle2.copyWith(
//                                   color: kMainBlack.withOpacity(0.6)),
//                             ),
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//         ),
//       ),
//     );
//   }
// }

class ChatRoomWidget extends StatelessWidget {
  ChatRoomWidget({Key? key, required this.chatRoom, required this.imageList})
      : super(key: key);

  Rx<ChatRoom> chatRoom;
  List<Widget> imageList;
  @override
  Widget build(BuildContext context) {
    print('이미지 리스트 런타입은 ? : ${imageList[0]}');
    return GestureDetector(
      onTap: () async {
        await postTime(
            chatRoom.value.group.id, ProfileController.to.profile.value.userId);
        Get.to(() => MessageDetailScreen(
              groupId: chatRoom.value.group.id.toString(),
            ));
        chatRoom.value.newMsg = 0;
        chatRoom.refresh();
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(
          () => Container(
            // height: 234,
            width: Get.width,
            decoration: BoxDecoration(
                color: kLightGrey, borderRadius: BorderRadius.circular(28)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: chatRoom.value.newMsg != 0
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.end,
                    children: [
                      if (chatRoom.value.newMsg != 0)
                        Text('NEW',
                            style:
                                kInActiveButtonStyle.copyWith(color: kPrimary)),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: ChatListController.to
                                .calculateDate(chatRoom.value.group.date),
                            style: kLargeCaptionStyle)
                      ]))

                      // ,Text('${chatRoom.value.group.date}', style: kLargeCaptionStyle)
                    ],
                  ),
                  const SizedBox(height: 18),
                  Center(child: Stack(children: imageList)),
                  const SizedBox(height: 12),
                  Text(
                    chatRoom.value.group.university,
                    style: k16Medium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text: '약속 시간 ',
                            style: k16Light.copyWith(
                                color: kMainBlack.withOpacity(0.4))),
                        TextSpan(
                            text: chatRoom.value.group.dateCount > 0
                                ? DateFormat('yyyy-MM-dd')
                                    .format(chatRoom.value.group.date)
                                    .toString()
                                : '아직 정하지 않았어요',
                            style: k16Medium)
                      ])),
                  const SizedBox(height: 12),
                  Divider(
                    thickness: 2.5,
                    color: kMainBlack.withOpacity(0.1),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      children: [
                        Container(
                          width: Get.width - 150,
                          child: RichText(
                              softWrap: false,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              text: TextSpan(children: [
                                TextSpan(
                                    text:
                                        chatRoom.value.group.member[0].nickname,
                                    style: kLargeCaptionStyle.copyWith(
                                        color: kMainBlack.withOpacity(0.4))),
                                TextSpan(
                                    text: ' ${chatRoom.value.message.message}',
                                    style: kInActiveButtonStyle)
                              ])),
                        ),
                        Spacer(),
                        if (chatRoom.value.newMsg != 0)
                          Container(
                            height: 20,
                            width: 50,
                            decoration: BoxDecoration(
                                color: kred,
                                borderRadius: BorderRadius.circular(16)),
                            child: Center(
                              child: Text(
                                chatRoom.value.newMsg.toString(),
                                style: kLargeCaptionStyle.copyWith(
                                    color: kMainWhite),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
