import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/widgets/button_widget.dart';

class ImageCheckView extends StatelessWidget {
  const ImageCheckView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(
            30, MediaQuery.of(context).padding.top + 40, 30, 17),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const Text('잠깐! 유니버시팅이 처음이시네요', style: kHeaderStyle2),
          const SizedBox(height: 10),
          const Text('친구들을 위해 프로필 사진이 필요해요', style: kHeaderStyle2),
          const SizedBox(height: 60),
          Center(
            child: Container(
              height: 150,
              width: 150,
              decoration: const BoxDecoration(
                  color: Color(0xffF7F7F7),
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [SvgPicture.asset('assets/icons/image_update.svg')],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text('본인을 잘 나타낼 수 있는 사진이 필요해요',style: k16Normal.copyWith(color: kMainBlack.withOpacity(0.4),height: 1.5), textAlign: TextAlign.center,),
          Text('얼굴 사진이 아니어도 괜찮아요',style: k16Normal.copyWith(color: kMainBlack.withOpacity(0.4), height: 1.5), textAlign: TextAlign.center),
          const SizedBox(height: 20),
          Text('부적적할 사진을 게시할 경우', style: kSmallCaptionStyle.copyWith(color: kMainBlack.withOpacity(0.4), height: 1.5), textAlign: TextAlign.center),
          Text('이유를 불문한 계정 제재 및 민형사적 책임을 질 수 있습니다.', style: kSmallCaptionStyle.copyWith(color: kMainBlack.withOpacity(0.4), height: 1.5), textAlign: TextAlign.center),
          const Spacer(),
          PrimaryButton(text: '친구 만나러 가기',isactive: true.obs)
        ]),
      ),
    );
  }
}
