import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/api/room_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/models/send_request_model.dart';

import 'package:universiting/widgets/button_widget.dart';
import 'package:universiting/widgets/profile_image_widget.dart';
import 'package:universiting/widgets/reject_button.dart';
import 'package:universiting/widgets/room_info_widget.dart';
import 'package:universiting/widgets/room_profile_image_widget.dart';
import 'package:universiting/widgets/scroll_noneffect_widget.dart';
import 'package:universiting/widgets/state_management_widget.dart';

class SendRequestWidget extends StatelessWidget {
  SendRequestWidget({Key? key, required this.request}) : super(key: key);

  SendRequest request;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: kCardColor.withOpacity(0.3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: SizedBox(
              height: 50,
              child: ScrollNoneffectWidget(
                child: ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => ProfileImageWidget(
                          type: ViewType.statusSendView,
                          width: 50,
                          height: 50,
                          host: request.members![index],
                        ),
                    separatorBuilder: (context, index) => const SizedBox(
                          width: 8,
                        ),
                    itemCount: request.members!.length),
              ),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Text(
              request.joinInfo.introduction,
              style: k16Medium.copyWith(height: 1.5),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          if (request.requeststate!.value != StateManagement.theyReject)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      request.requeststate!.value != StateManagement.sendme
                          ? StateManagementWidget(
                              state: request.requeststate!.value,
                              type: 'SendRequest',
                            )
                          : Column(
                              children: [
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text:
                                          '\'${request.members!.first.nickname}\'',
                                      style: k16Medium.copyWith(
                                          color: kPrimary, height: 1.5)),
                                  const TextSpan(
                                      text: '님이 함께 가고 싶어해요', style: k16Medium),
                                ])),
                                const Text('수락하여 새로운 친구를 만나보세요',
                                    style: k16Medium),
                                const SizedBox(height: 18),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: GestureDetector(
                                            onTap: () {
                                              roomparticipate(0, 'reject')
                                                  .then((httpresponse) {
                                                if (httpresponse.isError ==
                                                    false) {
                                                } else {}
                                              });
                                            },
                                            child: const RejectButton())),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          roomparticipate(0, 'join')
                                              .then((httpresponse) {
                                            if (httpresponse.isError == false) {
                                            } else {}
                                          });
                                        },
                                        child: PrimaryButton(
                                            text: '수락하기', isactive: true.obs),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                      const SizedBox(
                        height: 18,
                      ),
                      Divider(
                        thickness: 2.5,
                        color: kMainBlack.withOpacity(0.1),
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        '상대 방 정보',
                        style: k16Medium,
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                    ],
                  ),
                ),
                Center(
                  child: SizedBox(
                    height: 50,
                    child: ScrollNoneffectWidget(
                      child: ListView.separated(
                          shrinkWrap: true,
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) =>
                              RoomProfileImageWidget(
                                width: 50,
                                height: 50,
                                host: request.room!.hosts![index],
                                isname: false,
                                borderRadius: 8,
                              ),
                          separatorBuilder: (context, index) => const SizedBox(
                                width: 8,
                              ),
                          itemCount: request.room!.hosts!.length),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text(
                    request.room!.introduction!,
                    style: k16Medium.copyWith(height: 1.5),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: RoomInfoWidget(
                    univ: request.room!.university,
                    gender: request.room!.gender,
                    avgAge: request.room!.avgAge!,
                    mypersonnum: request.members!.length,
                    yourpersonnum: request.room!.hosts!.length,
                  ),
                ),
              ],
            ),
          if (request.requeststate!.value == StateManagement.theyReject)
            Center(
              child: Column(
                children: [
                  Text(
                    '아쉽지만 상대방이 신청을 거절했어요',
                    style: kSubtitleStyle3.copyWith(height: 1.5, color: kred),
                  ),
                  Text(
                    '아직 많은 방이 신청을 기다리고 있어요',
                    style: kSubtitleStyle3.copyWith(
                        height: 1.5, color: kMainBlack.withOpacity(0.4)),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}
