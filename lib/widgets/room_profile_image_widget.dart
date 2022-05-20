import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg_provider;
import 'package:universiting/constant.dart';
import 'package:universiting/models/host_model.dart';
import 'package:universiting/models/profile_model.dart';
import 'package:universiting/utils/custom_profile.dart';
import 'package:universiting/views/room_profile_view.dart';

class RoomProfileImageWidget extends StatelessWidget {
  RoomProfileImageWidget(
      {Key? key,
      this.width,
      this.height,
      this.host,
      this.profile,
      this.borderRadius,
      required this.isname,
      required this.isReject})
      : super(key: key);
  double? width;
  double? height;
  double? borderRadius;
  Host? host;
  Profile? profile;
  bool isname;
  bool isReject;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Container(
              height: height ?? 130,
              width: width ?? 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius ?? 16),
              ),
              child: host != null
                  ? host!.profileImage != ''
                      ? ClipRRect(
                          borderRadius:
                              BorderRadius.circular(borderRadius ?? 16),
                          child: CustomCachedNetworkImage(
                            imageUrl:
                                host!.profileImage.replaceAll('https', 'http'),
                          ))
                      : CustomCachedNetworkImage(
                          imageUrl:
                              'http://media.istockphoto.com/photos/confident-young-man-in-casual-green-shirt-looking-away-standing-with-picture-id1324558913?s=612x612',
                        )
                  : profile!.profileImage != ''
                      ? ClipRRect(
                          borderRadius:
                              BorderRadius.circular(borderRadius ?? 16),
                          child: CustomCachedNetworkImage(
                            imageUrl: profile!.profileImage
                                .replaceAll('https', 'http'),
                          ))
                      : CustomCachedNetworkImage(
                          imageUrl:
                              'http://media.istockphoto.com/photos/confident-young-man-in-casual-green-shirt-looking-away-standing-with-picture-id1324558913?s=612x612',
                        ),
            ),
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
                  )),
            if (isReject == false)
              Positioned.fill(
                  child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Get.to(() => RoomProfileView(profile: host!));
                  },
                  borderRadius: BorderRadius.circular(borderRadius ?? 16),
                  splashColor: kSplashColor,
                ),
              )),
          ],
        ),
      ],
    );
  }
}
