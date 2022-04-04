import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/other_profile_controller.dart';
import 'package:universiting/widgets/appbar_widget.dart';
import 'package:universiting/widgets/profile_image_widget.dart';

class OtherProfileView extends StatelessWidget {
  OtherProfileView({Key? key, required this.id}) : super(key: key);
  String id;
  @override
  Widget build(BuildContext context) {
    OtherProfileController otherProfileController =
        Get.put(OtherProfileController(id: id), tag: '$id번 프로필');
    return Scaffold(
      // appBar: AppBar(
      //     automaticallyImplyLeading: false,
      //     centerTitle: false,
      //     elevation: 0,
      //     title: Padding(
      //       padding: const EdgeInsets.only(left: 4.0),
      //       child: Text(
      //         '',
      //         style: kHeaderStyle3,
      //       ),
      //     ),
      //     leading: IconButton(
      //       onPressed: () {
      //         Get.back();
      //       },
      //       icon: SvgPicture.asset('assets/icons/back.svg'),
      //     ),
      //     actions: [Icon(Icons.more_horiz)]),
      appBar: AppBarWidget(
        title: '',
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))],
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.only(top: 8, left: 20, right: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            ProfileImageWidget(
              type: ViewType.otherView,
              profile: otherProfileController.otherProfile.value,
            ),
            const SizedBox(height: 12),
            Center(
              child: Text(
                '${otherProfileController.otherProfile.value.nickname} / ${otherProfileController.otherProfile.value.age} / ${otherProfileController.otherProfile.value.gender}',
                style: kHeaderStyle1,
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                  '${otherProfileController.otherProfile.value.university}',
                  style: kSubtitleStyle3.copyWith(
                      color: kMainBlack.withOpacity(0.6))),
            ),
            if (otherProfileController.otherProfile.value.department != '')
              const SizedBox(height: 4),
            if (otherProfileController.otherProfile.value.department != '')
              Center(
                child: Text(
                    '${otherProfileController.otherProfile.value.department}',
                    style: kSubtitleStyle3.copyWith(
                        color: kMainBlack.withOpacity(0.6))),
              ),
            const SizedBox(height: 16),
            Text(
              otherProfileController.otherProfile.value.introduction != ''
                  ? otherProfileController.otherProfile.value.introduction
                  : 'USER DESCRIPTION',
              style: kBodyStyle1,
            ),
            const SizedBox(height: 40),
            const Text('꼭 지켜주세요!', style: kSubtitleStyle2),
            const SizedBox(height: 12),
            Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
              Text('· ',
                  style: kSmallCaptionStyle.copyWith(
                      color: kMainBlack.withOpacity(0.6))),
              Expanded(
                child: RichText(
                  maxLines: 6,
                  text: TextSpan(
                    text :
                        '상대방의 프로필 사진이나 기타 개인 정보를 기록 또는 공유하는 행위는 유니버시팅의 이용약관에 어긋나는 행위이므로, 이를 어길 시 불이익을 받을 수 있습니다.',
                        style: kSmallCaptionStyle.copyWith(
                            color: kMainBlack.withOpacity(0.6))
                  ),
                ),
              )
            ]),
            const SizedBox(height: 8),
            Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
              Text('· ',
                  style: kSmallCaptionStyle.copyWith(
                      color: kMainBlack.withOpacity(0.6))),
              Expanded(
                child: RichText(
                  maxLines: 6,
                  text: TextSpan(
                    text :
                        '불건전하거나 부적절한 프로필을 목격하신 경우 오른쪽 상단 버튼을 통해 신고를 해주시면, 빠르게 조치하도록 하겠습니다.',
                        style: kSmallCaptionStyle.copyWith(
                            color: kMainBlack.withOpacity(0.6))
                  ),
                ),
              )
            ]),
          ]),
        ),
      ),
    );
  }
}
