import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:universiting/main.dart';

import 'widgets/spinkit_widget.dart';

enum Screenstate { loading, error, network, connecting, success }
enum StateManagement {
  chatLeave,
  friendLeave,
  theyAccept,
  roomActivated,
  theyReject,
  waitingThey,
  waitingFriend,
  received,
  friendReject,
  sendme
}
enum ProfileType { profile, image }
enum AddFriends { myRoom, otherRoom }
enum RoomType { statusReceiveView, statusSendView, otherView }
enum EmailCheckState { empty, fill, loading, waiting, success }
enum SearchType { empty, error, loading, success }
enum ViewType {
  statusReceiveView,
  statusSendView,
  otherView,
  myRoom,
  univRoom,
  signUp,
  setting
}

enum AdType { myRoom, chatRoom, univRoom, detailRoom, otherProfile }
const Color kMainBlack = Color(0xff33343C);
const Color kMainWhite = Color(0xffFAF8FF);
const Color kCardColor = Color(0xffE0E0E0);
const Color kBackgroundWhite = Color(0xffffffff);
const Color kPrimary = Color(0xffFC94AF);
const Color kGreen = Color(0xff00B933);
const Color kyellow = Color(0xffEAEF00);
const Color kred = Color(0xffFF6565);
const Color kLightGrey = Color(0xffF5F5F5);
const Color kErrorColor = Color(0xffF9657A);
Color kSplashColor = const Color(0xff33343C).withOpacity(0.1);

const TextStyle k26SemiBold = TextStyle(
    color: kMainBlack,
    fontSize: 26,
    fontWeight: FontWeight.w600,
    fontFamily: 'SUIT');

const TextStyle k20SemiBold = TextStyle(
    color: kMainBlack,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    fontFamily: 'SUIT');

const TextStyle kHeaderStyle1 = TextStyle(
    color: kMainBlack,
    fontSize: 20,
    height: 1.5,
    fontWeight: FontWeight.w500,
    fontFamily: 'SUIT');

const TextStyle kHeaderStyle2 = TextStyle(
    color: kMainBlack,
    fontSize: 20,
    fontWeight: FontWeight.w400,
    height: 1,
    fontFamily: 'SUIT');
const TextStyle kHeaderStyle3 = TextStyle(
    color: kMainBlack,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    fontFamily: 'SUIT');

const TextStyle k16Light = TextStyle(
    color: kMainBlack,
    fontSize: 16,
    fontWeight: FontWeight.w300,
    height: 1,
    fontFamily: 'SUIT');

const TextStyle k16Normal = TextStyle(
    color: kMainBlack,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: 'SUIT');

const TextStyle k16Medium = TextStyle(
    color: kMainBlack,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontFamily: 'SUIT');

const TextStyle k16SemiBold = TextStyle(
    color: kMainBlack,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontFamily: 'SUIT');

const TextStyle k16Bold = TextStyle(
    color: kMainBlack,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    fontFamily: 'SUIT');

const TextStyle kSubtitleStyle1 = TextStyle(
    color: kMainBlack,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.5,
    fontFamily: 'SUIT');
const TextStyle kSubtitleStyle2 = TextStyle(
    color: kMainBlack,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: 'SUIT');
const TextStyle kSubtitleStyle3 = TextStyle(
    color: kMainBlack,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1,
    fontFamily: 'SUIT');
const TextStyle kSubtitleStyle4 = TextStyle(
    color: kMainBlack,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: 'SUIT');
const TextStyle kSubtitleStyle5 = TextStyle(
    color: kMainBlack,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontFamily: 'SUIT');
const TextStyle kBodyStyle1 = TextStyle(
    color: kMainBlack,
    fontSize: 14,
    height: 1.5,
    fontWeight: FontWeight.w400,
    fontFamily: 'SUIT');
const TextStyle kBodyStyle2 = TextStyle(
    color: kMainBlack,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: 'SUIT');
const TextStyle kActiveButtonStyle = TextStyle(
    color: kMainBlack,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: 'SUIT');
const TextStyle kInActiveButtonStyle = TextStyle(
    color: kMainBlack,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    fontFamily: 'SUIT');
const TextStyle kLargeCaptionStyle = TextStyle(
    color: kMainBlack,
    fontSize: 14,
    fontWeight: FontWeight.w300,
    height: 1,
    fontFamily: 'SUIT');
const TextStyle kSmallCaptionStyle = TextStyle(
    color: kMainBlack,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: 'SUIT');
const TextStyle kSmallBadgeStyle = TextStyle(
    color: kMainBlack,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    fontFamily: 'SUIT');

const List ageContents = [
  '대학생활의 시작을 응원할게요',
  '또 다른 대학생활 즐겨볼까요',
  '마지막 대학생활 함께해요'
];

// -----------------------------------------------------------------------------
Color kIconColor = const Color(0xff33343C).withOpacity(0.7);
Color cardColor = const Color(0xffF6F6F6);
const TextStyle kBodyStyle6 = TextStyle(
    color: kMainBlack,
    height: 1,
    fontSize: 26,
    fontWeight: FontWeight.w600,
    fontFamily: 'SUIT');
const TextStyle k13LightContent = TextStyle(
    color: kMainBlack,
    height: 1.5,
    fontSize: 13,
    fontWeight: FontWeight.w300,
    fontFamily: 'SUIT');
// -----------------------------------------------------------------------------