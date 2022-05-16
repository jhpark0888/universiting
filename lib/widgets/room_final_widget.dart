import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/map_controller.dart';
import 'package:universiting/controllers/univ_room_controller.dart';
import 'package:universiting/models/room_model.dart';
import 'package:universiting/utils/global_variable.dart';
import 'package:universiting/views/room_detail_view.dart';
import 'package:universiting/widgets/profile_image_widget.dart';
import 'package:universiting/widgets/room_profile_image_widget.dart';
import 'package:universiting/widgets/scroll_noneffect_widget.dart';
import 'package:universiting/widgets/state_management_widget.dart';

class RoomFinalWidget extends StatelessWidget {
  RoomFinalWidget(
      {Key? key,
      required this.room,
      this.joinmember,
      this.roomMember,
      this.hosts,
      required this.isChief,
      required this.roomType})
      : super(key: key);
  Room room;
  List<Widget>? roomMember;
  List<ProfileImageWidget>? joinmember;
  List<ProfileImageWidget>? hosts;
  bool isChief;
  ViewType roomType;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
          onTap: () {
            if (roomType != ViewType.statusReceiveView) {
              if (roomType == ViewType.univRoom) {
                if (MapController.to.isDetailClick.value == true) {
                  Get.to(
                      () => RoomDetailView(
                            roomid: room.id.toString(),
                          ),
                      opaque: false);
                } else {
                  UnivRoomController.to.changeHeight.value = Get.height;
                  MapController.to.isDetailClick(true);
                }
              } else if (roomType != ViewType.statusReceiveView) {
                Get.to(
                    () => RoomDetailView(
                          roomid: room.id.toString(),
                        ),
                    opaque: false);
              }
            } else {
              print(hosts);
            }
          },
          splashColor: kSplashColor,
          // behavior: HitTestBehavior.translucent,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const SizedBox(
              height: 18,
            ),
            ScrollNoneffectWidget(
                child: SizedBox(
                    height: 130,
                    width: Get.width,
                    child: ListView.separated(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      scrollDirection: Axis.horizontal,
                      itemCount: roomMember != null
                          ? roomMember!.length
                          : hosts!.length,
                      itemBuilder: (context, index) {
                        return roomMember != null
                            ? roomMember![index]
                            : hosts![index];
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 8,
                        );
                      },
                    ))),
            Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 18),
                      Text(room.title, style: k16Medium.copyWith(height: 1.5)),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Text('평균 나이',
                              style: k16Medium.copyWith(
                                  color: kMainBlack.withOpacity(0.4))),
                          const SizedBox(width: 4),
                          Text(
                            room.avgAge.toString() + '세',
                            style: k16Medium,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '·',
                            style: k16Medium.copyWith(
                                color: kMainBlack.withOpacity(0.4)),
                          ),
                          const SizedBox(width: 4),
                          Text('성별',
                              style: k16Medium.copyWith(
                                  color: kMainBlack.withOpacity(0.4))),
                          const SizedBox(width: 4),
                          Text(room.gender!, style: k16Medium),
                          const SizedBox(width: 4),
                          Text(
                            '·',
                            style: k16Medium.copyWith(
                                color: kMainBlack.withOpacity(0.4)),
                          ),
                          const SizedBox(width: 4),
                          Text('인원',
                              style: k16Medium.copyWith(
                                  color: kMainBlack.withOpacity(0.4))),
                          const SizedBox(width: 4),
                          Text('${room.totalMember} : ${room.totalMember}',
                              style: k16Medium),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Text('조회수',
                              style: k16Medium.copyWith(
                                  color: kMainBlack.withOpacity(0.4))),
                          const SizedBox(width: 4),
                          Text('${room.views}',
                              style: k16Medium.copyWith(
                                  color: kMainBlack.withOpacity(0.4))),
                          const Spacer(),
                          Text(calculateDate(room.date!),
                              style: k16Medium.copyWith(
                                  color: kMainBlack.withOpacity(0.4)))
                        ],
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Divider(
                        thickness: 1.5,
                        color: kMainBlack.withOpacity(0.05),
                      ),
                    ]))
          ])),
    );
  }
}
