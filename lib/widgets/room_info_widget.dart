import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universiting/constant.dart';

class RoomInfoWidget extends StatelessWidget {
  RoomInfoWidget(
      {Key? key,
      required this.avgAge,
      required this.mypersonnum,
      this.yourpersonnum,
      this.gender,
      this.univ})
      : super(key: key);

  String? univ;
  double avgAge;
  String? gender;
  int mypersonnum;
  int? yourpersonnum;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              'assets/icons/mini_univ.svg',
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              univ ?? '인천대학교',
              style: k16Medium,
            )
          ],
        ),
        const SizedBox(height: 12),
        RichText(
          text: TextSpan(children: [
            TextSpan(
                text: '평균 나이 ',
                style: k16Medium.copyWith(color: kMainBlack.withOpacity(0.4))),
            TextSpan(text: '${avgAge.toString()}세', style: k16Medium),
            TextSpan(
                text: ' · 성별 ',
                style: k16Medium.copyWith(color: kMainBlack.withOpacity(0.4))),
            TextSpan(text: gender, style: k16Medium),
            TextSpan(
                text: ' · 인원 ',
                style: k16Medium.copyWith(color: kMainBlack.withOpacity(0.4))),
            TextSpan(
                text: yourpersonnum != null
                    ? '${mypersonnum.toString()}:${yourpersonnum.toString()}'
                    : '${mypersonnum.toString()}명',
                style: k16Medium),
          ]),
        ),
      ],
    );
  }
}
