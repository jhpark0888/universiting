import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/api/chat_api.dart';
import 'package:universiting/api/room_api.dart';
import 'package:universiting/app.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/app_controller.dart';
import 'package:universiting/controllers/management_controller.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/models/myroom_request_model.dart';
import 'package:universiting/utils/global_variable.dart';
import 'package:universiting/views/room_info_view.dart';
import 'package:universiting/widgets/appbar_widget.dart';
import 'package:universiting/widgets/button_widget.dart';
import 'package:universiting/widgets/myroom_widget.dart';
import 'package:universiting/widgets/new_person_host_widget.dart';
import 'package:universiting/widgets/new_person_widget.dart';
import 'package:universiting/widgets/reject_button.dart';
import 'package:universiting/widgets/room_info_widget.dart';

class MyRoomRequestDetailView extends StatelessWidget {
  MyRoomRequestDetailView(
      {Key? key, required this.request, required this.roomId})
      : super(key: key);

  MyRoomRequest request;
  int roomId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: '받은 신청', actions: [
        IconButton(
            onPressed: () {
              // showCustomModalPopup(context, value1: '채팅 나가기', func1: () {
              //   exitChat(MessageDetailController.to.groupId);
              //   getbacks(3);
              //   ChatListController.to.chatRoomList.remove(
              //       ChatListController.to.chatRoomList[ChatListController
              //           .to.chatRoomList
              //           .indexWhere((chatRoomWidget) =>
              //               chatRoomWidget.chatRoom.value.group.id
              //                   .toString() ==
              //               MessageDetailController.to.groupId)]);
              //   ChatListController.to.chatRoomList.refresh();
              // }, textStyle: kSubtitleStyle3.copyWith(color: kErrorColor));
            },
            icon: SvgPicture.asset('assets/icons/more.svg'))
      ]),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: request.members!
                      .map((member) => NewPersonTileHostWidget(host: member))
                      .toList(),
                ),
                const SizedBox(
                  height: 28,
                ),
                const Text(
                  '신청 메세지',
                  style: k16Normal,
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  request.joinInfo.introduction,
                  style: k16Light.copyWith(height: 1.5),
                ),
                const SizedBox(
                  height: 20,
                ),
                RoomInfoWidget(
                    avgAge: request.joinInfo.age!,
                    mypersonnum: request.members!.length,
                    gender: request.joinInfo.gender,
                    univ: request.joinInfo.uni),
                const SizedBox(
                  height: 24,
                ),
                request.iscreater == true
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: GestureDetector(
                                      onTap: () async {
                                        await requestaccept(
                                                roomId,
                                                request.members!.first.userId,
                                                false)
                                            .then((httpresponse) {
                                          if (httpresponse.isError == false) {
                                            getbacks(1);
                                            MyRoomWidget myRoomWidget =
                                                ManagementController.to.room
                                                    .where((myroom) =>
                                                        myroom.room.id ==
                                                        roomId)
                                                    .first;
                                            myRoomWidget.room.requestlist!
                                                .removeWhere((myrequest) =>
                                                    myrequest.id == request.id);
                                            myRoomWidget
                                                .room.requestcount!.value -= 1;
                                          } else {}
                                        });
                                      },
                                      child: const RejectButton())),
                              const SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    await requestaccept(roomId,
                                            request.members!.first.userId, true)
                                        .then((httpresponse) {
                                      if (httpresponse.isError == false) {
                                        MyRoomWidget myRoomWidget =
                                            ManagementController.to.room
                                                .where((myroom) =>
                                                    myroom.room.id == roomId)
                                                .first;
                                        myRoomWidget.room.requestlist!
                                            .removeWhere((myrequest) =>
                                                myrequest.id == request.id);
                                        myRoomWidget.room.requestcount!.value -=
                                            1;
                                      } else {}
                                    });
                                  },
                                  child: PrimaryButton(
                                      text: '수락하기', isactive: true.obs),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Center(
                            child: Text(
                              '회원님이 방장으로 수락하면 채팅이 시작됩니다',
                              style: kLargeCaptionStyle.copyWith(
                                  color: kMainBlack.withOpacity(0.4)),
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: Text(
                          '${request.creater}님이 수락하면 채팅이 시작됩니다',
                          style: k16Medium.copyWith(color: kPrimary),
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
