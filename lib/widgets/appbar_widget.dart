import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import '../utils/global_variable.dart';

class AppBarWidget extends StatelessWidget implements PreferredSize {
  String title;
  List<Widget>? actions;
  Widget? leading;
  AppBarWidget({Key? key, required this.title, this.actions, this.leading})
      : super(key: key);

  AppBar appbar = AppBar();
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(title, style: kStyleAppbar),
      centerTitle: true,
      leading: leading ??
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: SvgPicture.asset('assets/icons/arrow.svg')),
      actions: actions,
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appbar.preferredSize.height);

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();
}
