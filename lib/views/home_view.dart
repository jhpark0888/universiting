import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:universiting/api/login_api.dart';
import 'package:universiting/api/main_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/home_controller.dart';
import 'package:universiting/controllers/login_controller.dart';
import 'package:universiting/controllers/map_controller.dart';
import 'package:universiting/views/login_view.dart';
import 'package:universiting/views/signup_univ_view.dart';
import 'package:universiting/widgets/textformfield_widget.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key, required this.login, required this.tag})
      : super(key: key);
  bool login = false;
  String tag;
  static CameraUpdate cameraUpdate =
      CameraUpdate.scrollTo(const LatLng(37.563600, 126.962370));

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController(), tag: tag);
    MapController mapController = Get.put(MapController());

    return Scaffold(
      extendBody: true,
      bottomSheet: login
      ? Container(height: 0)
          : Obx(() => homeController.islogin.value
              ? homeController.isGuest.value
                  ? LoginView()
                  : Container(
                      height: 0,
                    )
              : homeController.isGuest.value
                  ? Container(
                      decoration: BoxDecoration(color: kMainWhite),
                      height: Get.width / 1.1,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(Get.width / 20,
                            Get.width / 15, Get.width / 20, Get.width / 9),
                        child: Column(
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
                            GestureDetector(
                              onTap: () async {
                                await getMainUniv();
                              },
                              child: Container(
                                height: Get.width / 8,
                                decoration: BoxDecoration(
                                    border: Border.all(color: kPrimary),
                                    borderRadius: BorderRadius.circular(16),
                                    color: kMainWhite),
                                child: Center(
                                  child: Text(
                                    '유니버시팅에서 무엇을 할 수 있을까요?',
                                    style: kActiveButtonStyle.copyWith(
                                        color: kPrimary),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => SignupUnivView());
                              },
                              child: Container(
                                height: Get.width / 8,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: kPrimary),
                                child: Center(
                                  child: Text(
                                    '시작해볼까요?',
                                    style: kActiveButtonStyle.copyWith(
                                        color: kMainWhite),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Center(
                                child: GestureDetector(
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
                                      decoration: TextDecoration.underline)),
                              TextSpan(
                                  text: '을 읽고, ',
                                  style: kSmallCaptionStyle.copyWith(
                                      color: kMainBlack.withOpacity(0.6))),
                              TextSpan(
                                  text: '서비스 이용약관',
                                  style: kSmallCaptionStyle.copyWith(
                                      color: kMainBlack.withOpacity(0.6),
                                      decoration: TextDecoration.underline)),
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
                      height: Get.width / 1.3,
                    )),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Obx(() => NaverMap(
                      initialCameraPosition: const CameraPosition(
                          target: LatLng(37.563600, 126.962370)),
                      onMapCreated: login ? null : mapController.onMapCreated,
                      onMapTap: (value) {
                        mapController.isClick(false);
                      },
                      markers: homeController.mapController.markers.isNotEmpty
                          ? homeController.mapController.markers
                          : [
                              Marker(
                                  markerId: '-1',
                                  position: const LatLng(37.563600, 126.962370))
                            ],
                      initLocationTrackingMode: LocationTrackingMode.Follow,
                    )),
                Positioned(
                    child: GestureDetector(
                      onTap: () {
                        homeController.createdMarker();
                      },
                      child: Container(
                        height: Get.width / 9,
                        width: Get.width / 9,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white),
                        child: const Icon(Icons.restart_alt),
                      ),
                    ),
                    bottom: Get.width / 3,
                    left: Get.width / 10),
                Positioned(
                    child: GestureDetector(
                      onTap: () async {},
                      child: Container(
                        height: Get.width / 9,
                        width: Get.width / 9,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: kMainBlack),
                        child: Center(
                          child: Text(
                            'MY',
                            textAlign: TextAlign.center,
                            style: kActiveButtonStyle.copyWith(
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    bottom: Get.width / 3,
                    right: Get.width / 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
