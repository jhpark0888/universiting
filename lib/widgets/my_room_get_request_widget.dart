import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/views/create_room_view.dart';
import 'package:universiting/widgets/button_widget.dart';

class MyRoomGetRequestWidget extends StatelessWidget {
  const MyRoomGetRequestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // const Text(
              //   '내가 만든 방',
              //   style: kSubtitleStyle2,
              //   textAlign: TextAlign.start,
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 20.0),
              //   child: Container(
              //     child: Column(
              //       children: [
              //         Text('새로운 방을 만들어보세요', style: kSubtitleStyle2),
              //         SizedBox(height: 12),
              //         GestureDetector(
              //           onTap: (){Get.to(() => CreateRoomView());},
              //           child: PrimaryButton(
              //             text: '방 만들기',
              //             width: Get.width / 4,
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              // SizedBox(height: 40),
              // Text(
              //   '받은 신청',
              //   style: kSubtitleStyle2,
              // ),
              SizedBox(height: 32),
              Text(
                '아직 받은 신청이 없어요',
                style: kSubtitleStyle2.copyWith(
                    color: kMainBlack.withOpacity(0.38)),
                textAlign: TextAlign.center,
              )
            ],
          ),
        )
      ],
    );
  }
}
