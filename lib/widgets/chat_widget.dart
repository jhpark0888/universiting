import 'package:flutter/material.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/message_detail_controller.dart';
import 'package:universiting/models/message_detail_model.dart';
import 'package:universiting/models/message_model.dart';
import 'package:universiting/models/profile_model.dart';
import 'package:universiting/widgets/background_textfield_widget.dart';
import 'package:universiting/widgets/profile_image_widget.dart';

class ChatWidget extends StatelessWidget {
  ChatWidget({Key? key, required this.message, required this.userType, required this.profile})
      : super(key: key);
  Message message;
  String userType;
  Profile profile;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      message.type.toString() != userType
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                  ProfileImageWidget(
                    type: ViewType.otherView,
                    profile: profile,
                    width: 48,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          '${profile.nickname} / ${profile.age} / ${profile.gender}',
                          style: kSubtitleStyle3),
                      const SizedBox(height: 4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: kMainBlack.withOpacity(0.38)),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(12, 8, 12, 8),
                                child:
                                    Text(message.message, style: kBodyStyle1),
                              )),
                          const SizedBox(width: 8),
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
          : Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                      '${profile.nickname} / ${profile.age} / ${profile.gender}',
                      style: kSubtitleStyle3),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(getTime(message.date),
                          style: kSmallCaptionStyle.copyWith(
                              color: kMainBlack.withOpacity(0.6)),
                          textAlign: TextAlign.end),
                      const SizedBox(width: 8),
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: kMainBlack.withOpacity(0.38)),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                            child: Text(message.message, style: kBodyStyle1),
                          )),
                    ],
                  )
                ],
              ),
              const SizedBox(width: 8),
              ProfileImageWidget(
                type: ViewType.otherView,
                profile: profile,
                width: 48,
              ),
            ]),
      const SizedBox(
        height: 20,
      ),
    ]);
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
