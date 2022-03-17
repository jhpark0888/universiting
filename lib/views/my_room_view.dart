import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/views/create_room_view.dart';
import 'package:universiting/widgets/appbar_widget.dart';
import 'package:universiting/widgets/button_widget.dart';

class MyRoomView extends StatelessWidget {
  const MyRoomView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: '',
        leading: Padding(padding: EdgeInsets.fromLTRB(20, 13.5, 20, 13.5),child: Text('내 방', style: kHeaderStyle3)),
        actions: [
          GestureDetector(
            onTap: (){Get.to(() => CreateRoomView());},
              child: PrimaryButton(
            text: '방 만들기',
            width: Get.width / 4,
            height: 20,
            backColor: kPrimary,
          )),
        ],
      ),
    );
  }
}
