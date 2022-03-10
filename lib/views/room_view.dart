import 'package:flutter/material.dart';

class RoomView extends StatelessWidget {
  const RoomView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('방 목록 화면')),
    );
  }
}