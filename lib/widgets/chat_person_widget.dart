import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/models/host_model.dart';
import 'package:universiting/models/profile_model.dart';
import 'package:universiting/widgets/profile_image_widget.dart';

class ChatPersonWidget extends StatelessWidget {
  ChatPersonWidget({Key? key, required this.profile, this.width})
      : super(key: key);
  Profile profile;
  double? width;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 18),
        Row(
          children: [
            ProfileImageWidget(
              profile: profile,
              type: ViewType.otherView,
              width: width,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${profile.nickname} / ${profile.age} / ${profile.gender}',
                  style: k16Medium,
                ),
                const SizedBox(height: 8),
                Text(
                  profile.introduction.isEmpty ? '소개글이 없습니다.' : profile.introduction,
                  style: k16Light,
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}
