import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/app_controller.dart';
import 'package:universiting/views/chat_list_view.dart';
import 'package:universiting/views/home_view.dart';
import 'package:universiting/views/profile_view.dart';
import 'package:universiting/views/status_view.dart';
import 'package:universiting/views/my_room_view.dart';

class App extends StatelessWidget {
  App({Key? key,required this.lat,required this.lng}) : super(key: key);
  double lat;
  double lng;
  AppController appController = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    List<Widget> views = [
    HomeView(login: true, tag: '다음 화면', lat: lat, lng: lng,),
    MyRoomView(),
    StatusView(),
    ChatListView(),
    ProfileView()
  ];

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Obx(() => Container(
            height: Get.width / 5,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
              child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: appController.currentIndex.value,
                  onTap: appController.changePageIndex,
                  selectedItemColor: kMainBlack,
                    selectedFontSize: 12,
                    unselectedFontSize: 12,
                  items: [
                    BottomNavigationBarItem(
                        icon: SvgPicture.asset('assets/icons/home_inactive.svg'),
                        activeIcon: SvgPicture.asset('assets/icons/home_active.svg'),
                        label: '홈'),
                        BottomNavigationBarItem(
                        icon: SvgPicture.asset('assets/icons/room_inactive.svg'),
                        activeIcon: SvgPicture.asset('assets/icons/room_active.svg'),
                        label: '내 방'),
                    BottomNavigationBarItem(
                        icon: SvgPicture.asset('assets/icons/state_inactive.svg'),
                        activeIcon: SvgPicture.asset('assets/icons/state_active.svg'),
                        label: '신청 현황'),
                    
                    
                        BottomNavigationBarItem(
                        icon: SvgPicture.asset('assets/icons/chat_inactive.svg'),
                        activeIcon: SvgPicture.asset('assets/icons/chat_active.svg'),
                        label: '채팅방'),
                        BottomNavigationBarItem(
                        icon: SvgPicture.asset('assets/icons/profile_inactive.svg'),
                        activeIcon: SvgPicture.asset('assets/icons/profile_active.svg'),
                        label: '프로필')
                  ]),
            ),
          )),
      body: Obx(
        () => IndexedStack(
          index: appController.currentIndex.value,
          children: views,
        ),
      ),
    );
  }
}
