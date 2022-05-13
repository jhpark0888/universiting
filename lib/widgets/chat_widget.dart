import 'package:flutter/material.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/message_detail_controller.dart';
import 'package:universiting/controllers/profile_controller.dart';
import 'package:universiting/models/message_detail_model.dart';
import 'package:universiting/models/message_model.dart';
import 'package:universiting/models/profile_model.dart';
import 'package:universiting/widgets/background_textfield_widget.dart';
import 'package:universiting/widgets/profile_image_widget.dart';

class ChatWidget extends StatelessWidget {
  ChatWidget(
      {Key? key,
      required this.message,
      required this.userType,
      required this.profile})
      : super(key: key);
  Message message;
  int userType;
  Profile profile;
  @override
  Widget build(BuildContext context) {
    return message.sender != 1
        ? Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(children: [
              profile.type != userType
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                          ProfileImageWidget(
                            type: ViewType.otherView,
                            profile: profile,
                            width: 40,
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${profile.nickname}',
                                  style: kSubtitleStyle3),
                              const SizedBox(height: 6),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                      constraints:
                                          const BoxConstraints(maxWidth: 200),
                                      decoration: BoxDecoration(
                                          color: cardColor,
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            12, 8, 12, 8),
                                        child: Text(message.message,
                                            style: kBodyStyle1),
                                      )),
                                  const SizedBox(width: 12),
                                  Text(
                                    getTime(message.date),
                                    style: kSmallCaptionStyle.copyWith(
                                        color: kMainBlack.withOpacity(0.6)),
                                    textAlign: TextAlign.end,
                                  )
                                ],
                              )
                            ],
                          ),
                        ])
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('${profile.nickname}',
                                  style: kSubtitleStyle3),
                              const SizedBox(height: 6),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(getTime(message.date),
                                      style: kSmallCaptionStyle.copyWith(
                                          color: kMainBlack.withOpacity(0.6)),
                                      textAlign: TextAlign.end),
                                  const SizedBox(width: 12),
                                  Container(
                                      constraints:
                                          const BoxConstraints(maxWidth: 200),
                                      decoration: BoxDecoration(
                                          color:
                                              message.sender == ProfileController.to.profile.value.userId
                                                  ? kPrimary
                                                  : cardColor,
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            12, 10, 12, 10),
                                        child: Text(message.message,
                                            style: kBodyStyle1.copyWith(
                                                color: message.sender ==
                                                        ProfileController.to.profile.value.userId
                                                    ? kMainWhite
                                                    : kMainBlack)),
                                      )),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(width: 12),
                          ProfileImageWidget(
                            type: ViewType.otherView,
                            profile: profile,
                            width: 40,
                          ),
                        ]),
              const SizedBox(
                height: 18,
              ),
            ]),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: kMainBlack.withOpacity(0.4),
                      ),
                    ),
                    managerChat(message.message)!,
                    Expanded(
                      child: Divider(
                        height: 1,
                        thickness: 1,
                        color: kMainBlack.withOpacity(0.4),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
              ],
            ),
          );
  }
}

String getTime(DateTime dateTime) {
  if (DateTime.now().difference(dateTime).inSeconds < 60) {
    return '방금 전';
  } else if (DateTime.now().difference(dateTime).inMinutes < 60) {
    return '${DateTime.now().difference(dateTime).inMinutes}분 전';
  } else if (DateTime.now().difference(dateTime).inHours < 24) {
    return '${DateTime.now().difference(dateTime).inHours}시간 전';
  } else if (DateTime.now().difference(dateTime).inDays < 31) {
    return '${DateTime.now().difference(dateTime).inDays}일 전';
  } else if (DateTime.now().month - dateTime.month < 12) {
    return '${DateTime.now().month - dateTime.month}달 전';
  }
  return '${DateTime.now().year - dateTime.year}년 전';
}

Widget? managerChat(String message) {
  late String username;
  late String updateDate;
  for (Profile user in MessageDetailController.to.memberProfile) {
    username = message.split('님이 ')[0];
  }
  if (message.contains('님이 약속시간을')) {
    updateDate = message.split('$username님이 약속시간을 ')[1].split('로 설정했어요')[0].split(' 00:00:00')[0];
    return Padding(
      padding: const EdgeInsets.only(left: 33, right: 33),
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            TextSpan(
                text: "$username",
                style: kInActiveButtonStyle.copyWith(
                    color: kPrimary, height: 1.5)),
            const TextSpan(text: '님이 약속시간을\n', style: kInActiveButtonStyle),
            TextSpan(
                text: updateDate,
                style: kInActiveButtonStyle.copyWith(
                    color: kPrimary, height: 1.5)),
            const TextSpan(text: '로 설정했어요', style: kInActiveButtonStyle),
          ])),
    );
  } else if (message.contains('님이 방을 나갔어요')) {
    return Padding(
      padding: const EdgeInsets.only(left: 33, right: 33),
      child: Text("$username님이 채팅을 나갔어요",
          style: kInActiveButtonStyle.copyWith(
              color: kMainBlack.withOpacity(0.4), height: 1.5)),
    );
  } else {return Text(message);}
}
