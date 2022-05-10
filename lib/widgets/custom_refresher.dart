import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:universiting/constant.dart';

class CustomRefresherHeader extends StatelessWidget {
  const CustomRefresherHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClassicHeader(
      spacing: 0.0,
      height: 60,
      completeDuration: Duration(milliseconds: 600),
      textStyle: TextStyle(color: kMainBlack),
      refreshingText: '',
      releaseText: "",
      completeText: "",
      idleText: "",
      refreshingIcon: Image.asset(
        'assets/icons/loading.gif',
        scale: 18,
      ),
    );
  }
}

class CustomRefresherFooter extends StatelessWidget {
  const CustomRefresherFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClassicFooter(
      loadStyle: LoadStyle.ShowWhenLoading,
      spacing: 0.0,
      completeDuration: Duration(milliseconds: 600),
      loadingText: "",
      canLoadingText: "",
      idleText: "",
      textStyle: TextStyle(color: kMainBlack),
      idleIcon: Container(),
      loadingIcon: Image.asset(
        'assets/icons/loading.gif',
        scale: 18,
      ),
      canLoadingIcon: Image.asset(
        'assets/icons/loading.gif',
        scale: 18,
      ),
    );
  }
}
