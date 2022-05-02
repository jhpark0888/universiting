import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/models/profile_model.dart';
import 'package:universiting/widgets/profile_image_widget.dart';

class NewPersonTileWidget extends StatelessWidget {
  NewPersonTileWidget({Key? key, required this.profile}) : super(key: key);

  Profile profile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: Row(
        children: [
          ProfileImageWidget(
            type: ViewType.otherView,
            profile: profile,
            width: 60,
            height: 60,
          ),
          const SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${profile.nickname} / ${profile.age}세 / ${profile.gender}',
                style: k16Medium,
              ),
              const SizedBox(height: 8),
              Text(
                profile.introduction != ''
                    ? profile.introduction
                    : '아직 소개글이 없어요',
                style: k16Light,
              )
            ],
          )
        ],
      ),
    );
  }
}
