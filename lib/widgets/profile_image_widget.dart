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
                ? Stack(children: [
                    ClipOval(
                      child: Image.network(
                        serverUrl + host!.profileImage,
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      ),
                    ),
                    //todo: 유저 상태
                    Positioned(
                        top: 36,
                        left: 36,
                        child: Container(
                          decoration: BoxDecoration(
                              color: kPrimary,
                              borderRadius: BorderRadius.circular(6)),
                          width: 12,
                          height: 12,
                        ))
                  ])
                : ClipOval(
                    child: SvgPicture.asset(
                      'assets/illustrations/default_profile.svg',
                      height: 48,
                      width: 48,
                      fit: BoxFit.cover,
                    ),
                  )
            : Container(
                width: 48,
                height: 48,
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
