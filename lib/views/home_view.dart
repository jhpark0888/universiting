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
import 'package:universiting/views/login_view.dart';
import 'package:universiting/views/signup_univ_view.dart';
import 'package:universiting/widgets/custom_button_widget.dart';
import 'package:universiting/widgets/state_management_widget.dart';
import 'package:universiting/widgets/spinkit_widget.dart';
import 'package:universiting/widgets/empty_back_textfield_widget.dart';

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
  static CameraUpdate cameraUpdate =
      CameraUpdate.scrollTo(const LatLng(37.563600, 126.962370));

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
          ? SizedBox.shrink()
          : Obx(
              () => homeController.islogin.value
                  ? homeController.isGuest.value
                      ? LoginView()
                      : const SizedBox.shrink()
                  : homeController.isGuest.value
                      ? Container(
                          decoration: BoxDecoration(
                            color: kBackgroundWhite,
                            border: Border(
                              top: BorderSide(
                                width: 1.6,
                                color: Color(0xffe7e7e7),
                              ),
                            ),
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
                                  height: 16,
                                ),
                                Center(
                                    child: GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    homeController.islogin.value = true;
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Text(
                                      '이미 계정이 있어요',
                                      style: kInActiveButtonStyle.copyWith(
                                          color: kMainBlack.withOpacity(0.6)),
                                    ),
                                  ),
                                )),
                                const SizedBox(height: 16),
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
                      : const SizedBox.shrink(),
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
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Obx(() => NaverMap(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 64, horizontal: 8),
                      initialCameraPosition:
                          CameraPosition(target: LatLng(lat, lng)),
                      onMapCreated: login ? null : mapController.onMapCreated,
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
                            child:
                                SvgPicture.asset('assets/icons/refresh.svg')),
                      ),
                    ),
                    bottom: 20,
                    left: 20),
                Positioned(
                    child: GestureDetector(
                      onTap: () {
                        if (_animationController.bnbOffsetValue.value ==
                            Offset(0.0, 0.0)) {
                          _animationController.bnbOffsetValue.value =
                              Offset(0.0, 1.0);
                          _animationController.isRoomModalUp(true);
                        } else {
                          _animationController.bnbOffsetValue.value =
                              Offset(0.0, 0.0);
                          _animationController.isRoomModalUp(false);
                        }
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
                    bottom: 20,
                    right: 20),
              ],
            ),
          ),
          Obx(
            () => AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height:
                  _animationController.bnbOffsetValue.value == Offset(0.0, 0.0)
                      ? 0
                      : 300,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
