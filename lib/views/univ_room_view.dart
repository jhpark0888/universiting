import 'package:flutter/material.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/widgets/appbar_widget.dart';

class UnivRoomView extends StatelessWidget {
  const UnivRoomView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: '',),
      backgroundColor: kMainWhite,
    );
  }
}