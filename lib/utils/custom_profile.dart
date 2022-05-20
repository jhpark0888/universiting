import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/widgets/loading_widget.dart';

class ProfileBlur extends StatelessWidget {
  ProfileBlur({Key? key, this.width, this.blurRadius, this.opacity})
      : super(key: key);

  double? opacity;
  double? blurRadius;
  double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width != null ? width! : Get.width,
      height: width != null ? width! : Get.width,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: kMainBlack.withOpacity(opacity ?? 0.7),
          blurRadius: blurRadius ?? 80,
          offset: Offset(0, width != null ? -width! : -Get.width),
          blurStyle: BlurStyle.normal,
        ),
        BoxShadow(
          color: kMainBlack.withOpacity(opacity ?? 0.7),
          blurRadius: blurRadius ?? 80,
          offset: Offset(width != null ? -width! : -Get.width, 0),
          blurStyle: BlurStyle.normal,
        ),
        BoxShadow(
          color: kMainBlack.withOpacity(opacity ?? 0.7),
          blurRadius: blurRadius ?? 80,
          offset: Offset(width != null ? width! : Get.width, 0),
          blurStyle: BlurStyle.normal,
        ),
        BoxShadow(
          color: kMainBlack.withOpacity(opacity ?? 0.7),
          blurRadius: blurRadius ?? 80,
          offset: Offset(0, width != null ? width! : Get.width),
          blurStyle: BlurStyle.normal,
        ),
      ]),
    );
  }
}

class ProfileBlurClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;
    var path = Path()
      ..lineTo(0, 0)
      ..lineTo(width, 0)
      ..lineTo(width, height)
      ..lineTo(0, height)
      ..lineTo(0, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

// 원모양으로 자르기
// class ProfileBlurClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     double width = size.width;
//     double height = size.height;
//     double radius = size.width / 2;
//     var path = Path()
//       ..moveTo(0, radius)
//       ..lineTo(0, 0)
//       ..lineTo(width, 0)
//       ..lineTo(width, radius)
//       ..arcToPoint(Offset(0, radius),
//           radius: Radius.circular(radius), clockwise: false)
//       ..lineTo(0, height)
//       ..lineTo(width, height)
//       ..lineTo(width, radius)
//       ..arcToPoint(
//         Offset(0, radius),
//         radius: Radius.circular(radius),
//       )
//       ..close();

//     return path;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
// }

class CustomCachedNetworkImage extends StatelessWidget {
  CustomCachedNetworkImage(
      {Key? key, required this.imageUrl, this.width, this.height})
      : super(key: key);

  String imageUrl;
  double? width;
  double? height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: BoxFit.cover,
      placeholder: (context, url) {
        return const LoadingWidget();
      },
    );
  }
}
