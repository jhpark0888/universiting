import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/profile_controller.dart';
import 'package:universiting/utils/custom_profile.dart';

class RoomManagerWithWidget extends StatelessWidget {
  RoomManagerWithWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            ClipOval(
                child: ProfileController.to.profile.value.profileImage != ''
                    ? CustomCachedNetworkImage(
                        imageUrl:
                            ProfileController.to.profile.value.profileImage,
                        width: 48,
                        height: 48,
                      )
                    : SvgPicture.asset(
                        'assets/illustrations/default_profile.svg',
                        height: 48,
                        width: 48,
                        fit: BoxFit.cover,
                      )),
            // Positioned.fill(
            //   child: Align(
            //       alignment: Alignment.bottomCenter,
            //       child: Container(
            //         width: Get.width / 10,

            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(10),
            //             color: kMainBlack),
            //         child: Text(
            //           '방장',
            //           style: TextStyle(fontSize: 10, color: kMainWhite),textAlign: TextAlign.center,
            //         ),
            //       )),
            // )
          ],
        ),
        SizedBox(width: 8)
      ],
    );
  }
}
