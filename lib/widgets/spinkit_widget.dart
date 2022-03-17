import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:universiting/constant.dart';
class SpinKitWidget extends StatelessWidget {
  const SpinKitWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: SpinKitFadingCircle(
              color: kMainBlack.withOpacity(0.6),
              size: 100,
            ),
          ),
        ],
      ),
    );
  }
}