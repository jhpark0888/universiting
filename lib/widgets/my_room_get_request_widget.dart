import 'package:flutter/material.dart';
import 'package:universiting/constant.dart';

class MyRoomGetRequestWidget extends StatelessWidget {
  const MyRoomGetRequestWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text('내가 만든 방', style: kSubtitleStyle2,),
      )],
    );
  }
}