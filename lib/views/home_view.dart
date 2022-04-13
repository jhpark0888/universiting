import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:universiting/api/login_api.dart';
import 'package:universiting/api/main_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/home_controller.dart';
import 'package:universiting/controllers/login_controller.dart';
import 'package:universiting/controllers/map_controller.dart';
import 'package:universiting/controllers/notifications_controller.dart';
import 'package:universiting/controllers/univ_room_controller.dart';
import 'package:universiting/views/alarm_list_view.dart';
import 'package:universiting/views/login_view.dart';
import 'package:universiting/views/room_info_view.dart';
import 'package:universiting/views/signup_univ_view.dart';
import 'package:universiting/widgets/custom_button_widget.dart';
import 'package:universiting/widgets/state_management_widget.dart';
import 'package:universiting/widgets/spinkit_widget.dart';
import 'package:universiting/widgets/empty_back_textfield_widget.dart';
import 'package:universiting/widgets/white_circle_button_widget.dart';
import 'package:universiting/widgets/univ_room_widget.dart';

import '../controllers/custom_animation_controller.dart';

class HomeView extends StatelessWidget {
  HomeView(
      {Key? key,
      required this.login,
      required this.tag,
      required this.lat,
      required this.lng})
      : super(key: key);
  double lat;
  double lng;
  bool login = false;
  late String tag;
  late CameraUpdate cameraUpdate = CameraUpdate.scrollTo(LatLng(lat, lng));

  MapController mapController = Get.put(MapController());
  late final HomeController homeController =
      Get.put(HomeController(), tag: tag);
  final CustomAnimationController _animationController =
      Get.put(CustomAnimationController(), tag: 'bottomnavigation');

  @override
  Widget build(BuildContext context) {
    return
        // Obx(
        // ()=> (homeController.isLoading.value == false) ?
        Scaffold(
      extendBody: true,
      bottomSheet: login
          ? const SizedBox.shrink()
          : Obx(() => homeController.islogin.value
                  ? homeController.isGuest.value
                      ? LoginView()
                      : const SizedBox.shrink()
                  : homeController.isGuest.value
                      ? Container(
                          decoration: BoxDecoration(
                            color: kBackgroundWhite,
                            boxShadow: [
                              BoxShadow(
                                color: kMainBlack.withOpacity(0.1),
                                blurRadius: 1,
                                offset: const Offset(
                                  0.0,
                                  -1.0,
                                ),
                              ),
                            ],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            // border: Border(
                            //   top: BorderSide(
                            //     width: 1.6,
                            //     color: Color(0xffe7e7e7),
                            //   ),
                            // ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right: 20,
                              left: 20,
                              top: 28,
                              bottom: 40,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                if (mapController.isClick.value)
                                  const Center(
                                      child: Text(
                                    '로그인 또는 회원 가입 후 이용할 수 있어요!',
                                    style: kSubtitleStyle2,
                                  )),
                                if (mapController.isClick.value)
                                  const SizedBox(
                                    height: 24,
                                  ),
                                CustomButtonWidget(
                                    onTap: () {
                                      Get.to(() => SignupUnivView());
                                    },
                                    buttonTitle: '유니버시팅에서 무엇을 할 수 있을까요?',
                                    buttonState: ButtonState.secondary),
                                const SizedBox(height: 16),
                                CustomButtonWidget(
                                    onTap: () {
                                      Get.to(() => SignupUnivView(),
                                          transition: Transition.noTransition);
                                    },
                                    buttonTitle: '시작해볼까요?',
                                    buttonState: ButtonState.primary),
                                const SizedBox(
                                  height: 24,
                                ),
                                Center(
                                    child: GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    homeController.islogin.value = true;
                                  },
                                  child: Text(
                                    '이미 계정이 있어요',
                                    style: kInActiveButtonStyle.copyWith(
                                        color: kMainBlack.withOpacity(0.6)),
                                  ),
                                )),
                                const SizedBox(height: 24),
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: "'시작해볼까요?' 버튼을 누르시면 유니버시팅의 ",
                                      style: kSmallCaptionStyle.copyWith(
                                          color: kMainBlack.withOpacity(0.6))),
                                  TextSpan(
                                      text: '개인정보 처리방침',
                                      style: kSmallCaptionStyle.copyWith(
                                          color: kMainBlack.withOpacity(0.6),
                                          decoration:
                                              TextDecoration.underline)),
                                  TextSpan(
                                      text: '을 읽고, ',
                                      style: kSmallCaptionStyle.copyWith(
                                          color: kMainBlack.withOpacity(0.6))),
                                  TextSpan(
                                      text: '서비스 이용약관',
                                      style: kSmallCaptionStyle.copyWith(
                                          color: kMainBlack.withOpacity(0.6),
                                          decoration:
                                              TextDecoration.underline)),
                                  TextSpan(
                                      text: '에 동의한 것으로 간주됩니다.',
                                      style: kSmallCaptionStyle.copyWith(
                                          color: kMainBlack.withOpacity(0.6)))
                                ]))
                              ],
                            ),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(color: kMainBlack),
                          height: 100,
                        )
              // const SizedBox.shrink(),
              ),
      // floatingActionButton: homeController.islogin.value
      //     ? SizedBox.shrink()
      //     : FloatingActionButton(
      //         backgroundColor: kBackgroundWhite,
      //         onPressed: () {},
      //         child: SvgPicture.asset(
      //           'assets/icons/my_button.svg',
      //           color: kMainBlack,
      //         ),
      //       ),
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Obx(() => NaverMap(
                        contentPadding:
                            // EdgeInsets.symmetric(vertical: 64, horizontal: 8),
                            const EdgeInsets.only(bottom: 70),
                        initialCameraPosition:
                            CameraPosition(target: LatLng(lat, lng)),
                        onMapCreated: mapController.onMapCreated,
                        onCameraChange: mapController.onCameraChange,
                        onMapTap: (value) {
                          mapController.isClick(false);
                        },
                        markers: homeController.mapController.markers.isNotEmpty
                            ? homeController.mapController.markers
                            : [
                                Marker(
                                    markerId: '-1',
                                    position: LatLng(37.563600, 126.962370))
                              ],
                        initLocationTrackingMode: LocationTrackingMode.Follow,
                      )),
                  if (homeController.islogin.value && tag == '다음 화면')
                    Positioned(
                      top: 60,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        width: Get.width,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                    color: kBackgroundWhite,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                        width: 0.5,
                                        color: kMainBlack.withOpacity(0.1))),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 10.5, 10, 10.5),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Center(
                                          child: SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: Icon(
                                                Icons.search,
                                                color: kMainBlack
                                                    .withOpacity(0.38),
                                                size: 15,
                                              ))),
                                      const SizedBox(width: 10),
                                      Text(
                                        '대학 이름으로 검색',
                                        textAlign: TextAlign.center,
                                        style: kBodyStyle1.copyWith(
                                            color: kMainBlack.withOpacity(0.40),
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                //  if (_animationController.bnbOffsetValue.value ==
                                //     Offset(0.0, 0.0)) {
                                //   _animationController.bnbOffsetValue.value =
                                //       Offset(0.0, 1.0);
                                //   _animationController.isRoomModalUp(true);
                                // } else {
                                //   _animationController.bnbOffsetValue.value =
                                //       Offset(0.0, 0.0);
                                //   Future.delayed(Duration(milliseconds: 300), () {
                                //     _animationController.isRoomModalUp(false);
                                //   });
                                // }
                                Get.to(() => AlarmListView());
                              },
                              child: Container(
                                height: 48,
                                width: 48,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    color: kBackgroundWhite),
                                child: Center(child: Icon(Icons.alarm)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (homeController.islogin.value && tag == '다음 화면')
                    Positioned(
                        child: GestureDetector(
                          onTap: () {
                            homeController.createdMarker();
                          },
                          child: Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: kBackgroundWhite),
                            child: Center(
                                child: SvgPicture.asset(
                                    'assets/icons/refresh.svg')),
                          ),
                        ),
                        top: 120,
                        right: 20),
                  if (homeController.islogin.value && tag == '다음 화면')
                    Positioned(
                        child: GestureDetector(
                          onTap: () async {
                            // if (_animationController.bnbOffsetValue.value ==
                            //     Offset(0.0, 0.0)) {
                            //   _animationController.bnbOffsetValue.value =
                            //       Offset(0.0, 1.0);
                            //   _animationController.isRoomModalUp(true);
                            // } else {
                            //   _animationController.bnbOffsetValue.value =
                            //       Offset(0.0, 0.0);
                            //   Future.delayed(Duration(milliseconds: 300), () {
                            //     _animationController.isRoomModalUp(false);
                            //   });
                            // }
                            final controller =
                                await mapController.nMapController.future;
                            Timer(Duration(milliseconds: 500), () {
                              controller.moveCamera(cameraUpdate);
                            });
                          },
                          child: Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: kBackgroundWhite),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/icons/my_button.svg',
                              ),
                            ),
                          ),
                        ),
                        top: 120,
                        left: 20),
                  if (_animationController.isRoomModalUp.value &&
                      _animationController.modalHegiht.value == 300)
                    Positioned(
                      bottom: 30,
                      left: 20,
                      child: GestureDetector(
                        onTap: () {
                          _animationController.isRoomModalUp(false);
                          _animationController.bnbOffsetValue.value =
                              Offset(0.0, 0.0);
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                                color: kMainWhite,
                                borderRadius: BorderRadius.circular(24)),
                            child: Center(
                              child: SvgPicture.asset('assets/icons/back.svg'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  Positioned.fill(
                      bottom: 94,
                      child: GestureDetector(
                          onTap: () {
                            Get.to(() => RoomInfoView());
                          },
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: kPrimary,
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          padding: const EdgeInsets.fromLTRB(
                                              30, 13, 30, 13),
                                          child: Center(
                                            child: Text(
                                              '방 만들기',
                                              style: kBodyStyle2.copyWith(
                                                  color: kMainWhite, height: 1),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]))))
                ],
              ),
            ),
            Obx(
              () => AnimatedContainer(
                duration: Duration(milliseconds: 100),
                curve: Curves.easeInOut,
                height: _animationController.bnbOffsetValue.value ==
                        Offset(0.0, 0.0)
                    ? 0
                    : _animationController.modalHegiht.value,
                child: Column(children: [
                  GestureDetector(
                    onTap: () {
                      if (_animationController.modalHegiht.value ==
                          Get.height - 100) {
                        _animationController.modalHegiht.value = 300.0;
                      } else {
                        _animationController.modalHegiht.value =
                            Get.height - 100;
                      }
                    },
                    child: Container(
                      height: 20,
                      color: Colors.green,
                    ),
                  ),
                  homeController.univRoom.last
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
