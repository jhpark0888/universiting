import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
