import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/models/host_model.dart';

class ProfileImageWidget extends StatelessWidget {
  ProfileImageWidget({Key? key, this.width, this.height, this.host})
      : super(key: key);
  double? width;
  double? height;
  Host? host;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        host != null
            ? host!.profileImage != ''
                ? ClipOval(
                    child: Image.network(
                    serverUrl + host!.profileImage,
                    width: width?? Get.width / 7,
                    height: height ??Get.width / 7,
                    fit: BoxFit.fill,
                  ))
                : ClipOval(
                  child: SvgPicture.asset(
                          'assets/illustrations/default_profile.svg',
                          height: Get.width / 7,
                          width: Get.width / 7,
                          fit: BoxFit.cover,
                        ),
                )
            : Container(
                width: width ?? Get.width / 7,
                height: height ?? Get.width / 7,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: kMainBlack.withOpacity(0.38)),
              ),
        SizedBox(
          width: 8,
        )
      ],
    );
  }
}
