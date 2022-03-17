import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';

class RoomManagerWithWidget extends StatelessWidget {
  RoomManagerWithWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            Container(
              width: Get.width / 7,
              height: Get.width / 7,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: kMainBlack.withOpacity(0.6)),
            ),
            Positioned.fill(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: Get.width / 10,
            
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kMainBlack),
                    child: Text(
                      '방장',
                      style: TextStyle(fontSize: 10, color: kMainWhite),textAlign: TextAlign.center,
                    ),
                  )),
            )
          ],
        ),
        SizedBox(width: 8)
      ],
    );
  }
}
