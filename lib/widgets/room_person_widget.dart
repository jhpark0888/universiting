import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/models/host_model.dart';
import 'package:universiting/widgets/profile_image_widget.dart';

class RoomPersonWidget extends StatelessWidget {
  RoomPersonWidget({Key? key, required this.host, this.width})
      : super(key: key);
  Host host;
  double? width;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileImageWidget(
          host: host,
          type: ViewType.otherView,
          width: width,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${host.nickname} / ${host.age} / ${host.gender}',
              style: kSubtitleStyle4,
            ),
            const SizedBox(height: 6),
            host.introduction != ''
                ? Text(
                    '${host.introduction}',
                    style: kBodyStyle2,
                  )
                : Text(
                    '소개 글이 없어요',
                    style: kBodyStyle2.copyWith(
                        color: kMainBlack.withOpacity(0.6)),
                  )
          ],
        )
      ],
    );
  }
}
