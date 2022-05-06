import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/models/host_model.dart';
import 'package:universiting/widgets/appbar_widget.dart';

class RoomProfileView extends StatelessWidget {
  RoomProfileView({Key? key, required this.profile}) : super(key: key);
  Host profile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarWidget(
        backgroundColor: Colors.transparent,
        title: '',
        leading: IconButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              Get.back();
            },
            icon: SvgPicture.asset(
              'assets/icons/back.svg',
              color: kBackgroundWhite,
            )),
        actions: [
          IconButton(
            onPressed: () {
              showCustomModalPopup(context, value1: '이 유저 신고하기', func1: () {
                Get.back();
              }, textStyle: kSubtitleStyle3.copyWith(color: kErrorColor));

              // showCustomModalPopup(context, value1: '이 방 나가기', func1: () {
              //   Get.back();

              // }, textStyle: kSubtitleStyle3.copyWith(color: kErrorColor));
            },
            icon: SvgPicture.asset(
              'assets/icons/more.svg',
              color: kBackgroundWhite,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: Get.width,
              height: Get.width,
              child: Stack(
                children: [
                  Image.network(
                    profile.profileImage != ''
                        ? profile.profileImage
                        : 'https://media.istockphoto.com/photos/confident-young-man-in-casual-green-shirt-looking-away-standing-with-picture-id1324558913?s=612x612',
                    width: Get.width,
                    height: Get.width,
                    fit: BoxFit.cover,
                  ),
                  ClipRect(
                    child: Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: kMainBlack.withOpacity(0.7),
                          blurRadius: 80,
                          offset: Offset(0, -Get.width),
                          blurStyle: BlurStyle.normal,
                        ),
                        BoxShadow(
                          color: kMainBlack.withOpacity(0.7),
                          blurRadius: 80,
                          offset: Offset(-Get.width, 0),
                          blurStyle: BlurStyle.normal,
                        ),
                        BoxShadow(
                          color: kMainBlack.withOpacity(0.7),
                          blurRadius: 80,
                          offset: Offset(Get.width, 0),
                          blurStyle: BlurStyle.normal,
                        ),
                        BoxShadow(
                          color: kMainBlack.withOpacity(0.7),
                          blurRadius: 80,
                          offset: Offset(0, Get.width),
                          blurStyle: BlurStyle.normal,
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/mini_profile.svg',
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        '${profile.nickname} / ${profile.age.toString()} / ${profile.gender}',
                        style: k16SemiBold,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/mini_univ.svg',
                        color: kMainBlack.withOpacity(0.7),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        '대학교',
                        style: k16SemiBold,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/mini_dept.svg',
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        '무슨 무슨 과',
                        style: k16SemiBold,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    '자기 소개',
                    style: k16Medium,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    profile.introduction == ''
                        ? '아직 소개글이 없어요'
                        : profile.introduction!,
                    style: k16Light.copyWith(height: 1.5),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
