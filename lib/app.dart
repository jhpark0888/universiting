import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/app_controller.dart';
import 'package:universiting/controllers/home_controller.dart';
import 'package:universiting/controllers/map_controller.dart';
import 'package:universiting/views/chat_list_view.dart';
import 'package:universiting/views/home_view.dart';
import 'package:universiting/views/management_view.dart';
import 'package:universiting/views/profile_view.dart';
import 'package:universiting/views/status_view.dart';

import 'controllers/custom_animation_controller.dart';

class App extends StatelessWidget {
  App({Key? key, required this.lat, required this.lng}) : super(key: key);
  double lat;
  double lng;
  AppController appController = Get.put(AppController());
  MapController mapController = Get.put(MapController());
  final CustomAnimationController _animationController =
      Get.put(CustomAnimationController(), tag: 'bottomnavigation');

  double bottomiconsize = 45;
  @override
  Widget build(BuildContext context) {
    List<Widget> views = [
      HomeView(
        login: true,
        tag: '다음 화면',
        lat: lat,
        lng: lng,
      ),
      StatusView(),
      ManagementView(),
      ChatListView(),
      ProfileView(),
    ];

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Obx(
        () => _animationController.isRoomModalUp.value == false
            ? AnimatedSlide(
                offset: _animationController.bnbOffsetValue.value,
                curve: Curves.easeInOut,
                duration: Duration(milliseconds: 300),
                child: Obx(() => Container(
                      height: 82,
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: kMainBlack.withOpacity(0.3),
                          ),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          color: Colors.transparent),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        child: BottomNavigationBar(
                            type: BottomNavigationBarType.fixed,
                            currentIndex: appController.currentIndex.value,
                            backgroundColor: kBackgroundWhite,
                            showSelectedLabels: false,
                            showUnselectedLabels: false,
                            onTap: appController.changePageIndex,
                            items: [
                              BottomNavigationBarItem(
                                  icon: SvgPicture.asset(
                                    'assets/icons/home_inactive.svg',
                                    width: bottomiconsize,
                                    height: bottomiconsize,
                                  ),
                                  activeIcon: SvgPicture.asset(
                                    'assets/icons/home_active.svg',
                                    width: bottomiconsize,
                                    height: bottomiconsize,
                                  ),
                                  label: '홈',
                                  tooltip: ''),
                              BottomNavigationBarItem(
                                icon: SvgPicture.asset(
                                  'assets/icons/bell_inactive.svg',
                                  width: bottomiconsize,
                                  height: bottomiconsize,
                                ),
                                activeIcon: SvgPicture.asset(
                                  'assets/icons/bell_active.svg',
                                  width: bottomiconsize,
                                  height: bottomiconsize,
                                ),
                                label: '알람',
                                tooltip: '',
                              ),
                              BottomNavigationBarItem(
                                icon: SvgPicture.asset(
                                  'assets/icons/manage_inactive.svg',
                                  width: bottomiconsize,
                                  height: bottomiconsize,
                                ),
                                activeIcon: SvgPicture.asset(
                                  'assets/icons/manage_active.svg',
                                  width: bottomiconsize,
                                  height: bottomiconsize,
                                ),
                                label: '관리',
                                tooltip: '',
                              ),
                              BottomNavigationBarItem(
                                icon: SvgPicture.asset(
                                  'assets/icons/chat_inactive.svg',
                                  width: bottomiconsize,
                                  height: bottomiconsize,
                                ),
                                activeIcon: SvgPicture.asset(
                                  'assets/icons/chat_active.svg',
                                  width: bottomiconsize,
                                  height: bottomiconsize,
                                ),
                                label: '채팅방',
                                tooltip: '',
                              ),
                              BottomNavigationBarItem(
                                icon: SvgPicture.asset(
                                  'assets/icons/profile_inactive.svg',
                                  width: bottomiconsize,
                                  height: bottomiconsize,
                                ),
                                activeIcon: SvgPicture.asset(
                                  'assets/icons/profile_active.svg',
                                  width: bottomiconsize,
                                  height: bottomiconsize,
                                ),
                                label: '프로필',
                                tooltip: '',
                              ),
                            ]),
                      ),
                    )),
              )
            : SizedBox.shrink(),
      ),
      body: Obx(
        () => IndexedStack(
          index: appController.currentIndex.value,
          children: views,
        ),
      ),
    );
  }
}
