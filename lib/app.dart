import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/app_controller.dart';
import 'package:universiting/views/home_view.dart';
import 'package:universiting/views/profile_view.dart';
import 'package:universiting/views/room_view.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);
  List<Widget> views = [
    RoomView(),
    HomeView(login: true, tag: '다음 화면'),
    ProfileView()
  ];
  AppController appController = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
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
                  items: [
                    BottomNavigationBarItem(
                        icon: Container(
                          height: Get.width / 12,
                          width: Get.width / 12,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color(0xffC4C4C4)),
                        ),
                        label: '내 목록'),
                    BottomNavigationBarItem(
                        icon: Container(
                          height: Get.width / 9,
                          width: Get.width / 9,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: kMainBlack),
                          child: Center(
                            child: Text(
                              'U',
                              textAlign: TextAlign.center,
                              style: kActiveButtonStyle.copyWith(
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        label: ''),
                    BottomNavigationBarItem(
                        icon: Container(
                          height: Get.width / 12,
                          width: Get.width / 12,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color(0xffC4C4C4)),
                        ),
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
