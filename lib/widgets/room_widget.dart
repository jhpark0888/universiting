import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/models/room_model.dart';
import 'package:universiting/widgets/profile_image_widget.dart';

class RoomWidget extends StatelessWidget {
  RoomWidget({Key? key, required this.room, required this.hosts})
      : super(key: key);
  Room room;
  List<ProfileImageWidget> hosts;
  @override
  Widget build(BuildContext context) {
    print(hosts);
    return Column(
      children: [
        Container(
          height: Get.width / 1.9,
          width: double.infinity,
          decoration: BoxDecoration(
              color: kLightGrey, borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Row(children: hosts),
              const SizedBox(height: 12),
              Text(room.title, style: kSubtitleStyle2),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text('평균 나이',
                      style:
                          kBodyStyle2.copyWith(color: kMainBlack.withOpacity(0.6))),
                  const SizedBox(width: 4),
                  Text(
                    room.avgAge.toString(),
                    style: kSubtitleStyle3,
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    '·',
                    style: kInActiveButtonStyle,
                  ),
                  const SizedBox(width: 4),
                  Text('성별',
                      style:
                          kBodyStyle2.copyWith(color: kMainBlack.withOpacity(0.6))),
                  const SizedBox(width: 4),
                  Text(room.gender, style: kSubtitleStyle3)
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text('인원수',
                      style:
                          kBodyStyle2.copyWith(color: kMainBlack.withOpacity(0.6))),
                  const SizedBox(width: 4),
                  Text('${room.totalMember} : ${room.totalMember}', style: kSubtitleStyle3)
                ],
              )
            ]),
          ),
        ),
        const SizedBox(height: 16)
      ],
    );
  }
}
