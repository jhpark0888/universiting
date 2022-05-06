import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/profile_controller.dart';
import 'package:universiting/controllers/profile_image_widget_controller.dart';
import 'package:universiting/models/host_model.dart';
import 'package:universiting/models/profile_model.dart';
import 'package:universiting/views/other_profile_view.dart';

class ProfileImageWidget extends StatelessWidget {
  ProfileImageWidget(
      {Key? key,
      this.width,
      this.height,
      this.host,
      required this.type,
      this.profile})
      : super(key: key);
  double? width;
  double? height;
  Host? host;
  ViewType type;
  Profile? profile;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (type == ViewType.statusReceiveView)
          Get.to(OtherProfileView(id: host!.userId.toString()));
      },
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(children: [
              ClipOval(
                child: host != null
                    ? host!.userId == ProfileController.to.profile.value.userId
                        ? ProfileController.to.profile.value.profileImage != ''
                            ? CachedNetworkImage(
                                imageUrl: ProfileController
                                    .to.profile.value.profileImage,
                                width: width ?? 48,
                                height: width ?? 48,
                                fit: BoxFit.cover,
                              )
                            : SvgPicture.asset(
                                'assets/illustrations/default_profile.svg',
                                height: width ?? 48,
                                width: width ?? 48,
                                fit: BoxFit.cover,
                              )
                        : host!.profileImage != ''
                            ? CachedNetworkImage(
                                imageUrl: host!.profileImage,
                                width: width ?? 48,
                                height: width ?? 48,
                                fit: BoxFit.cover,
                              )
                            : SvgPicture.asset(
                                'assets/illustrations/default_profile.svg',
                                height: width ?? 48,
                                width: width ?? 48,
                                fit: BoxFit.cover,
                              )
                    : profile != null
                        ? profile!.userId ==
                                ProfileController.to.profile.value.userId
                            ? ProfileController.to.profile.value.profileImage !=
                                    ''
                                ? CachedNetworkImage(
                                    imageUrl: ProfileController
                                        .to.profile.value.profileImage,
                                    width: width ?? 48,
                                    height: width ?? 48,
                                    fit: BoxFit.cover,
                                  )
                                : SvgPicture.asset(
                                    'assets/illustrations/default_profile.svg',
                                    height: width ?? 80,
                                    width: width ?? 80,
                                    fit: BoxFit.cover,
                                  )
                            : profile?.profileImage == ''
                                ? SvgPicture.asset(
                                    'assets/illustrations/default_profile.svg',
                                    height: width ?? 80,
                                    width: width ?? 80,
                                    fit: BoxFit.cover,
                                  )
                                : CachedNetworkImage(
                                    imageUrl: profile!.profileImage,
                                    width: width ?? 48,
                                    height: width ?? 48,
                                    fit: BoxFit.cover,
                                  )
                        : ClipOval(
                            child: SvgPicture.asset(
                              'assets/illustrations/default_profile.svg',
                              height: width ?? 80,
                              width: width ?? 80,
                              fit: BoxFit.cover,
                            ),
                          ),
              ),
              // if(host != null && width == null)
              // Positioned(
              //     top: 36,
              //     left: 36,
              //     child: Container(
              //       decoration: BoxDecoration(
              //           color: host!.hostType! ? kPrimary : kMainWhite,
              //           borderRadius: BorderRadius.circular(8),
              //           border: host!.hostType!
              //               ? null
              //               : Border.all(color: kPrimary, width: 1.6)),
              //       width: 12,
              //       height: 12,
              //     ))
            ]),
          ],
        ),
      ),
    );
  }
}
