import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import '../utils/global_variable.dart';

class AppBarWidget extends StatelessWidget implements PreferredSize {
  String title;
  List<Widget>? actions;
  Widget? leading;
  double? leadingwidth;
  Color? backgroundColor;
  double? titlespacing;
  TextStyle? textStyle;
  AppBarWidget(
      {Key? key,
      required this.title,
      this.backgroundColor,
      this.actions,
      this.leading,
      this.leadingwidth,
      this.titlespacing,
      this.textStyle})
      : super(key: key);

  AppBar appbar = AppBar();
  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: titlespacing,
      backgroundColor: backgroundColor,
      leadingWidth: leadingwidth,
      automaticallyImplyLeading: false,
      title: Text(title, style: textStyle?? k20SemiBold),
      centerTitle: true,
      leading: leading ??
          IconButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                Get.back();
              },
              icon: SvgPicture.asset('assets/icons/back.svg')),
      actions: actions,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appbar.preferredSize.height);

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();
}
