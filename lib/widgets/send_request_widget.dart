import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/api/room_api.dart';
import 'package:universiting/api/status_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/management_controller.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/models/send_request_model.dart';
import 'package:universiting/views/room_detail_view.dart';
import 'package:universiting/views/send_request_view.dart';

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
    return Obx(
      () => Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: kCardColor.withOpacity(1)),
            color: kCardColor.withOpacity(0.4),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            InkWell(
              onTap: () {
                if (request.requeststate!.value != StateManagement.theyReject) {
                  Get.to(
                      () => SendRequestView(
                            id: request.id,
                            stateManagement: StateManagement.waitingThey,
                          ),
                      opaque: false);
                } else if (request.requeststate!.value ==
                    StateManagement.friendReject) {
                  Get.to(
                      () => SendRequestView(
                            id: request.id,
                            stateManagement: StateManagement.friendReject,
                          ),
                      opaque: false);
                } else if (request.requeststate!.value ==
                    StateManagement.theyReject) {
                  getDetailSendView(request.id, request.requeststate!.value);
                  showCustomDialog('다음 기회에', 1200);
                }
              },
              splashColor: kSplashColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
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
                                  ProfileImageWidget(
                                    type: ViewType.statusSendView,
                                    width: 50,
                                    height: 50,
                                    host: request.members![index],
                                  ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
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
                    if (request.requeststate!.value !=
                        StateManagement.theyReject)
                      request.requeststate!.value != StateManagement.sendme
                          ? StateManagementWidget(
                              state: request.requeststate!.value,
                              type: 'SendRequest',
                            )
                          : Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Column(
                                children: [
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text:
                                            '\'${request.members!.first.nickname}\'',
                                        style: k16Medium.copyWith(
                                            color: kPrimary, height: 1.5)),
                                    const TextSpan(
                                        text: '님이 함께 가고 싶어해요',
                                        style: k16Medium),
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
                                                roomRequestJoin(
                                                        request.room!.id!,
                                                        'reject',
                                                        request.members!.first
                                                            .userId)
                                                    .then((httpresponse) {
                                                  if (httpresponse.isError ==
                                                      false) {
                                                    ManagementController
                                                            .to
                                                            .sendRequestWidgetList
                                                            .value =
                                                        (ManagementController.to
                                                            .sendRequestWidgetList
                                                            .where((widget) =>
                                                                widget.request
                                                                    .id !=
                                                                request.id)
                                                            .toList());

                                                    print(request.requeststate);
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
                                            roomRequestJoin(
                                                    request.room!.id!,
                                                    'join',
                                                    request
                                                        .members!.first.userId)
                                                .then((httpresponse) {
                                              if (httpresponse.isError ==
                                                  false) {
                                                ManagementController
                                                        .to.sendRequestWidgetList
                                                        .where((widget) =>
                                                            widget.request.id ==
                                                            request.id)
                                                        .first
                                                        .request
                                                        .requeststate!
                                                        .value =
                                                    StateManagement.waitingThey;
                                                ManagementController
                                                    .to.sendRequestWidgetList
                                                    .where((widget) =>
                                                        widget.request.id ==
                                                        request.id)
                                                    .first
                                                    .request
                                                    .requeststate!
                                                    .refresh();
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
                            ),
                    const SizedBox(
                      height: 18,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Divider(
                        thickness: 2.5,
                        color: kMainBlack.withOpacity(0.1),
                      ),
                    ),
                  ]),
            ),
            InkWell(
              onTap: () {
                if (request.requeststate!.value != StateManagement.theyReject) {
                  Get.to(
                      () =>
                          RoomDetailView(roomid: request.room!.id!.toString()),
                      opaque: false);
                }
              },
              splashColor: kSplashColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (request.requeststate!.value != StateManagement.theyReject)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) =>
                                      RoomProfileImageWidget(
                                        width: 50,
                                        height: 50,
                                        host: request.room!.hosts![index],
                                        isname: false,
                                        borderRadius: 8,
                                        isReject: true,
                                      ),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
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
                            style: kSubtitleStyle3.copyWith(
                                height: 1.5, color: kred),
                          ),
                          Text(
                            '아직 많은 방이 신청을 기다리고 있어요',
                            style: kSubtitleStyle3.copyWith(
                                height: 1.5,
                                color: kMainBlack.withOpacity(0.4)),
                          )
                        ],
                      ),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ])),
    );
  }
}
