import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg_provider;
import 'package:universiting/constant.dart';
import 'package:universiting/models/host_model.dart';
import 'package:universiting/models/profile_model.dart';
import 'package:universiting/utils/custom_profile.dart';

class RoomProfileImageWidget extends StatelessWidget {
  RoomProfileImageWidget(
      {Key? key,
      this.width,
      this.height,
      this.host,
      this.profile,
      required this.isname})
      : super(key: key);
  double? width;
  double? height;
  Host? host;
  Profile? profile;
  bool isname;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: host != null
                        ? host!.profileImage != ''
                            ? DecorationImage(
                                image: NetworkImage(host!.profileImage),
                                fit: BoxFit.cover)
                            : const DecorationImage(
                          image: NetworkImage(
                              'https://media.istockphoto.com/photos/confident-young-man-in-casual-green-shirt-looking-away-standing-with-picture-id1324558913?s=612x612'),
                          fit: BoxFit.cover)
                        : profile!.profileImage != ''
                            ? DecorationImage(
                                image: NetworkImage(profile!.profileImage),
                                fit: BoxFit.cover)
                            : const DecorationImage(
                          image: NetworkImage(
                              'https://media.istockphoto.com/photos/confident-young-man-in-casual-green-shirt-looking-away-standing-with-picture-id1324558913?s=612x612'),
                          fit: BoxFit.cover),
                  )),
              if (isname)
                ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: ProfileBlur(
                      width: 130,
                    )),
              if (isname)
                Positioned(
                    left: 0,
                    bottom: 0,
                    child: Container(
                      width: Get.width,
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                      child: Text(
                        host != null ? host!.nickname ?? '' : profile!.nickname,
                        style: k16Medium.copyWith(color: kBackgroundWhite),
                      ),
                    ))
            ],
          ),
        ],
      ),
    );
  }
}
