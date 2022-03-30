import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
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
  RoomType type;
  Profile? profile;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (type == RoomType.statusReceiveView)
          Get.to(OtherProfileView(id: host!.userId.toString()));
      },
      child: Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          host != null
              ? host!.profileImage != ''
                  ? Stack(children: [
                      ClipOval(
                        child: Image.network(
                          serverUrl + host!.profileImage,
                          width: width?? 48,
                          height:width?? 48,
                          fit: BoxFit.cover,
                        ),
                      ),
                      //todo: 유저 상태
                      Positioned(
                          top:  36,
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
                        height: width?? 48,
                        width: width?? 48,
                        fit: BoxFit.cover,
                      ),
                    )
              : profile == null
                  ?
                  //  Container(
                  //     width: 48,
                  //     height: 48,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(30),
                  //         color: kMainBlack.withOpacity(0.38)),
                  //   ),
                  ClipOval(
                      child: SvgPicture.asset(
                        'assets/illustrations/default_profile.svg',
                        height: width??80,
                        width: width??80,
                        fit: BoxFit.cover,
                      ),
                    )
                  : profile!.profileImage != ''
                      ? ClipOval(
                          child: Image.network(
                            serverUrl + profile!.profileImage,
                            height: width?? 80,
                            width:width?? 80,
                            fit: BoxFit.cover,
                          ),
                        )
                      : ClipOval(
                          child: SvgPicture.asset(
                            'assets/illustrations/default_profile.svg',
                            height: width?? 80,
                            width: width?? 80,
                            fit: BoxFit.cover,
                          ),
                        ),
          SizedBox(
            width: 8,
          )
        ],
      ),
    );
  }
}
