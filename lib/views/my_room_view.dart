import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/my_room_controller.dart';
import 'package:universiting/views/create_room_view.dart';
import 'package:universiting/widgets/appbar_widget.dart';
import 'package:universiting/widgets/button_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:universiting/widgets/custom_button_widget.dart';

class MyRoomView extends StatelessWidget {
  MyRoomView({Key? key}) : super(key: key);
  MyRoomController myRoomController = Get.put(MyRoomController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(
              '내 방',
              style: kHeaderStyle3,
            ),
          ),
          actions: [
            // CustomButtonWidget(
            //     buttonTitle: '방 만들기',
            //     buttonState: ButtonState.primary,
            //     onTap: () {}),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
                right: 20,
              ),
              child: GestureDetector(
                  onTap: () {
                    Get.to(() => CreateRoomView());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: kPrimary,
                        borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Center(
                      child: Text(
                        '방 만들기',
                        style: kActiveButtonStyle.copyWith(color: kMainWhite),
                      ),
                    ),
                  )),
            ),
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
                refreshingIcon: Text('당기는 중입니다.')),
            onRefresh: myRoomController.onRefresh,
            child:
                // Text(myRoomController.myRoomList.value.chiefList[0].toString())
                SingleChildScrollView(
                    child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20),
              child: Column(
                children: myRoomController.room,
              ),
            ))),
      ),
    );
  }
}
