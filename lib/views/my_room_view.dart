import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/my_room_controller.dart';
import 'package:universiting/views/create_room_view.dart';
import 'package:universiting/widgets/appbar_widget.dart';
import 'package:universiting/widgets/button_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyRoomView extends StatelessWidget {
  MyRoomView({Key? key}) : super(key: key);
  MyRoomController myRoomController = Get.put(MyRoomController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBarWidget(
          title: '',
          leading: const Padding(
              padding: EdgeInsets.fromLTRB(20, 13.5, 0, 13.5),
              child: Text('내 방', style: kHeaderStyle3, textAlign: TextAlign.center,)),
              leadingwidth: 100,
          actions: [
            GestureDetector(
                onTap: () {
                  Get.to(() => CreateRoomView());
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0,9,20,9),
                  child: PrimaryButton(
                    text: '방 만들기',
                    width: Get.width / 4,
                    height: 34,
                    backColor: kPrimary,
                  ),
                )),
          ],
        ),
        body: SmartRefresher(
            controller: myRoomController.refreshController,
            header: const ClassicHeader(
                spacing: 0.0,
                height: 60,
                completeDuration: Duration(milliseconds: 600),
                textStyle: TextStyle(color: kMainBlack),
                refreshingText: '',
                releaseText: "",
                completeText: "",
                idleText: "",
                refreshingIcon: Text('당기는 중입니다.')),onRefresh: myRoomController.onRefresh,
            child:
                // Text(myRoomController.myRoomList.value.chiefList[0].toString())
                SingleChildScrollView(child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0,20.0,20.0,80),
                  child: Column(children: myRoomController.room,),
                ))
                ),
      ),
    );
  }
}
