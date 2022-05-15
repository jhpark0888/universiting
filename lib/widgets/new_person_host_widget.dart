import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/models/host_model.dart';
import 'package:universiting/models/profile_model.dart';
import 'package:universiting/widgets/profile_image_widget.dart';

class NewPersonTileHostWidget extends StatelessWidget {
  NewPersonTileHostWidget({Key? key, required this.host}) : super(key: key);

  Host host;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: Row(
        children: [
          ProfileImageWidget(
            type: ViewType.otherView,
            host: host,
            width: 60,
            height: 60,
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${host.nickname} / ${host.age}세 / ${host.gender}',
                  style: k16Medium,
                ),
                const SizedBox(height: 8),
                Text(
                  host.introduction != '' ? host.introduction! : '아직 소개글이 없어요',
                  style: k16Light,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
