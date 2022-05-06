import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/management_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:universiting/models/myroom_request_model.dart';
import 'package:universiting/views/room_info_view.dart';
import 'package:universiting/widgets/appbar_widget.dart';
import 'package:universiting/widgets/myroom_request_widget.dart';
import 'package:universiting/widgets/scroll_noneffect_widget.dart';

class MyRoomRequestView extends StatelessWidget {
  MyRoomRequestView({Key? key, required this.requestlist, required this.title})
      : super(key: key);

  List<MyRoomRequest> requestlist;
  String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(
          title: '받은 신청',
        ),
        body:
            // Obx(() => SmartRefresher(
            //       controller: _manageController.myroomrefreshController,
            //       enablePullUp: _manageController.enablepullupMyRoom.value,
            //       header: const ClassicHeader(
            //           spacing: 0.0,
            //           height: 60,
            //           completeDuration: Duration(milliseconds: 600),
            //           textStyle: TextStyle(color: kMainBlack),
            //           refreshingText: '',
            //           releaseText: "",
            //           completeText: "",
            //           idleText: "",
            //           refreshingIcon: Text('당기는 중입니다.')),
            //       footer: ClassicFooter(
            //         loadStyle: LoadStyle.ShowWhenLoading,
            //         spacing: 0.0,
            //         completeDuration: Duration(milliseconds: 600),
            //         loadingText: "로딩 중",
            //         canLoadingText: "캔 로딩 중",
            //         idleText: "아이들",
            //         textStyle: TextStyle(color: kMainBlack),
            //         idleIcon: Container(),
            //       ),
            //       onRefresh: _manageController.onRoomRefresh,
            //       onLoading: _manageController.onRoomLoading,
            //       child:
            //           // Text(myRoomController.myRoomList.value.chiefList[0].toString())

            Column(children: [
          Text(
            '\'${title}\'',
            style: kSubtitleStyle3.copyWith(
                height: 1.5, color: kMainBlack.withOpacity(0.4)),
          ),
          Text(
            '방에 들어온 신청 목록이에요',
            style: kSubtitleStyle3.copyWith(
                height: 1.5, color: kMainBlack.withOpacity(0.4)),
          ),
          Expanded(
            child: ScrollNoneffectWidget(
              child: ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemBuilder: (context, index) => MyroomRequestWidget(
                      isrequestinfo: true, request: requestlist[index]),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemCount: requestlist.length),
            ),
          )
        ])

        // )),
        );
  }
}
