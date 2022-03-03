import 'package:flutter/material.dart';
import 'package:universiting/widget/appbar_widget.dart';

class MainHomeScreen extends StatelessWidget {
  const MainHomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: '홈 화면'),
      body: Text('성공'),
    );
  }
}