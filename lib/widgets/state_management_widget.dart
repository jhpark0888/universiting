import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/fadeout_animation_controller.dart';

class StateManagementWidget extends StatelessWidget {
  StateManagementWidget({required this.state});
  final FadeoutAniamtionController _fadeoutAniamtionController =
      Get.put(FadeoutAniamtionController());

  final StateManagement state;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (state == StateManagement.waitingThey ||
                state == StateManagement.waitingFriend)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      FadeTransition(
                        opacity: Tween(begin: 1.0, end: 0.0)
                            .chain(CurveTween(curve: Curves.fastOutSlowIn))
                            .animate(_fadeoutAniamtionController
                                .animationController!),
                        child: ScaleTransition(
                          scale: _fadeoutAniamtionController
                              .scaleAnimationController!,
                          child: Container(
                            height: 13,
                            width: 13,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: kPrimary),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: kMainWhite,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: kPrimary, width: 1.6),
                        ),
                        height: 12,
                        width: 12,
                        child: const SizedBox.shrink(),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  if (state == StateManagement.waitingThey)
                    Text(
                      '상대 측의 수락을 기다리는 중이에요...',
                      style: kSmallCaptionStyle.copyWith(
                        color: kMainBlack.withOpacity(0.6),
                      ),
                    ),
                  if (state == StateManagement.waitingFriend)
                    Text(
                      '내 친구들의 수락을 기다리는 중이에요...',
                      style: kSmallCaptionStyle.copyWith(
                        color: kMainBlack.withOpacity(0.6),
                      ),
                    ),
                ],
              ),
            if (state == StateManagement.theyAccept ||
                state == StateManagement.received ||
                state == StateManagement.roomActivated)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: kPrimary,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: kPrimary, width: 1.6),
                    ),
                    height: 12,
                    width: 12,
                    child: const SizedBox.shrink(),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  if (state == StateManagement.roomActivated)
                    Text(
                      '현재 활성화 된 방이에요',
                      style: kSmallCaptionStyle.copyWith(
                        color: kMainBlack.withOpacity(0.6),
                      ),
                    ),
                  if (state == StateManagement.theyAccept)
                    Text(
                      '상대 측이 참여 신청을 수락했어요',
                      style: kSmallCaptionStyle.copyWith(
                        color: kMainBlack.withOpacity(0.6),
                      ),
                    ),
                  if (state == StateManagement.received)
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          //TODO: ROOM TITLE 값 받아와야 함
                          TextSpan(
                            text: 'ROOM TITLE',
                            style: kSmallCaptionStyle.copyWith(
                                fontWeight: FontWeight.w500),
                          ),
                          TextSpan(
                            text: ' 방에 참여 신청이 들어왔어요',
                            style: kSmallCaptionStyle.copyWith(
                              color: kMainBlack.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            if (state == StateManagement.theyReject ||
                state == StateManagement.friendLeave ||
                state == StateManagement.friendReject ||
                state == StateManagement.chatLeave)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: kErrorColor,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: kErrorColor, width: 1.6),
                    ),
                    height: 12,
                    width: 12,
                    child: const SizedBox.shrink(),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  if (state == StateManagement.chatLeave)
                    Text(
                      '친구가 채팅방을 나갔어요',
                      style: kSmallCaptionStyle.copyWith(
                        color: kMainBlack.withOpacity(0.6),
                      ),
                    ),
                  if (state == StateManagement.friendLeave)
                    Text(
                      '내 친구가 방을 나갔어요',
                      style: kSmallCaptionStyle.copyWith(
                        color: kMainBlack.withOpacity(0.6),
                      ),
                    ),
                  if (state == StateManagement.friendReject)
                    Text(
                      '내 친구가 초대 신청을 거절했어요',
                      style: kSmallCaptionStyle.copyWith(
                        color: kMainBlack.withOpacity(0.6),
                      ),
                    ),
                  if (state == StateManagement.theyReject)
                    Text(
                      '참여 신청이 거절되었어요',
                      style: kSmallCaptionStyle.copyWith(
                        color: kMainBlack.withOpacity(0.6),
                      ),
                    ),
                ],
              ),
          ],
        ),
      
    );
  }
}
