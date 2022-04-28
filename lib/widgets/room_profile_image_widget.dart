import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg_provider;
import 'package:universiting/models/host_model.dart';
import 'package:universiting/models/profile_model.dart';

class RoomProfileImageWidget extends StatelessWidget {
  RoomProfileImageWidget(
      {Key? key, this.width, this.height, this.host, this.profile})
      : super(key: key);
  double? width;
  double? height;
  Host? host;
  Profile? profile;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: 130,
              width: 130,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: host!.profileImage != ''
                      ? DecorationImage(
                          image: NetworkImage(host!.profileImage),
                          fit: BoxFit.cover)
                      : DecorationImage(
                          image: NetworkImage(
                              'https://media.istockphoto.com/photos/confident-young-man-in-casual-green-shirt-looking-away-standing-with-picture-id1324558913?s=612x612'),
                          fit: BoxFit.cover))),
          const SizedBox(width: 12)
        ],
      ),
    );
  }
}
