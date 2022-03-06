import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:universiting/Api/login_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/home_controller.dart';
import 'package:universiting/controllers/login_controller.dart';
import 'package:universiting/controllers/map_controller.dart';
import 'package:universiting/views/login_view.dart';
import 'package:universiting/views/signup_university_view.dart';
import 'package:universiting/widgets/textformfield_widget.dart';

class HomeView extends StatelessWidget {
  final MapController _mapController = Get.put(MapController());
  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Obx(() => homeController.islogin.value
          ? Container(
              height: Get.width / 1,
              child: Padding(
                padding: EdgeInsets.fromLTRB(Get.width / 20, Get.width / 15,
                    Get.width / 20, Get.width / 9),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      '로그인',
                      style: kStyleHeader,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: Get.width / 20),
                    TextFormField(
                        controller: LoginController.to.emailController,
                        decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(Get.width / 30),
                            fillColor: Color(0xffF4F4F4),
                            filled: true,
                            hintText: '학교 이메일 주소',
                            hintStyle: kStyleContent.copyWith(
                              color: mainblack.withOpacity(0.38),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(color: Color(00000000)),
                            ))),
                    SizedBox(height: Get.width / 30),
                    TextFormField(
                        controller: LoginController.to.passwordController,
                        decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(Get.width / 30),
                            fillColor: Color(0xffF4F4F4),
                            filled: true,
                            hintText: '비밀번호',
                            hintStyle: kStyleContent.copyWith(
                              color: mainblack.withOpacity(0.38),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                borderSide: BorderSide(color: Color(00000000))),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(color: Color(00000000)),
                            ))),
                    SizedBox(height: Get.height / 30),
                    Center(
                        child: Text(
                      '비밀번호를 잊어버렸어요',
                      style: kStyleContent.copyWith(
                          decoration: TextDecoration.underline,
                          color: mainblack.withOpacity(0.6)),
                    )),
                    SizedBox(
                      height: Get.height / 30,
                    ),
                    GestureDetector(
                      onTap: () async {
                        LoginController.to.emailController.text.isNotEmpty &&
                                LoginController
                                    .to.passwordController.text.isNotEmpty
                            ? await login()
                            : Container();
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: LoginController.to.emailController.text.isNotEmpty &&
                                LoginController
                                    .to.passwordController.text.isNotEmpty ? mainblack :Color(0xffE7E7E7),
                              borderRadius: BorderRadius.circular(16)),
                          child: Padding(
                            padding: EdgeInsets.all(Get.width / 30),
                            child: Text('로그인하기',style: kStyleButton.copyWith(color : LoginController.to.emailController.text.isNotEmpty &&
                                LoginController
                                    .to.passwordController.text.isNotEmpty ? Colors.white : Colors.white.withOpacity(0.38)),textAlign: TextAlign.center,),
                          )),
                    )
                  ],
                ),
              ),
            )
          : Container(
              height: Get.width / 1.3,
              child: Padding(
                padding: EdgeInsets.fromLTRB(Get.width / 20, Get.width / 15,
                    Get.width / 20, Get.width / 9),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: Get.width / 8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Color(0xffC4C4C4)),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => SignupView());
                          },
                          child: Text(
                            '시작해볼까요?',
                            style: kStyleButton.copyWith(color: mainblack),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.width / 20,
                    ),
                    Container(
                      height: Get.width / 8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Color(0xffC4C4C4)),
                      child: Center(
                        child: Text(
                          '유니버시팅에선 뭘 할 수 있나요?',
                          style: kStyleButton.copyWith(color: mainblack),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height: Get.width / 15),
                    Center(
                        child: GestureDetector(
                      onTap: () {
                        homeController.islogin.value = true;
                      },
                      child: Text(
                        '이미 계정이 있어요',
                        style: kStyleContent.copyWith(
                            color: mainblack.withOpacity(0.6),
                            decoration: TextDecoration.underline),
                      ),
                    )),
                    SizedBox(height: Get.width / 15),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "'시작해볼까요?' 버튼을 누르시면 유니버시팅의 ",
                          style: kStylecontents.copyWith(
                              color: mainblack.withOpacity(0.6))),
                      TextSpan(
                          text: '개인정보 처리방침',
                          style: kStylecontents.copyWith(
                              color: mainblack.withOpacity(0.6),
                              decoration: TextDecoration.underline)),
                      TextSpan(
                          text: '을 읽고, ',
                          style: kStylecontents.copyWith(
                              color: mainblack.withOpacity(0.6))),
                      TextSpan(
                          text: '서비스 이용약관',
                          style: kStylecontents.copyWith(
                              color: mainblack.withOpacity(0.6),
                              decoration: TextDecoration.underline)),
                      TextSpan(
                          text: '에 동의한 것으로 간주됩니다.',
                          style: kStylecontents.copyWith(
                              color: mainblack.withOpacity(0.6)))
                    ]))
                  ],
                ),
              ),
            )),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Obx(
                  () => NaverMap(
                    initialCameraPosition:
                        CameraPosition(target: LatLng(37.563600, 126.962370)),
                    onMapCreated: onMapCreated,
                    // onMapTap: _onMapTap,
                    markers: _mapController.markers.value.isNotEmpty
                        ? _mapController.markers
                        : [
                            Marker(
                                markerId: '-1',
                                position: LatLng(37.563600, 126.962370))
                          ],
                    initLocationTrackingMode: LocationTrackingMode.Follow,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onMapCreated(NaverMapController controller) {
    _mapController.nMapController.complete(controller);
  }
}
