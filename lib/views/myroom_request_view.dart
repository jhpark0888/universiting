import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/management_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:universiting/controllers/myroomrequest_controller.dart';
import 'package:universiting/models/myroom_request_model.dart';
import 'package:universiting/views/room_info_view.dart';
import 'package:universiting/widgets/appbar_widget.dart';
import 'package:universiting/widgets/custom_refresher.dart';
import 'package:universiting/widgets/myroom_request_widget.dart';
import 'package:universiting/widgets/scroll_noneffect_widget.dart';

class MyRoomRequestView extends StatelessWidget {
  MyRoomRequestView({
    Key? key,
    required this.title,
    required this.roomId,
    required this.requestlist,
  }) : super(key: key);

  late final MyRoomRequestController _myRoomRequestController =
      MyRoomRequestController(roomId: roomId, requestlist: requestlist.obs);
  List<MyRoomRequest> requestlist;
  String title;
  int roomId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: '받은 신청',
      ),
      body: Obx(() => SmartRefresher(
          controller: _myRoomRequestController.moreRequestRefreshController,
          enablePullUp: _myRoomRequestController.enablepullupMoreRequest.value,
          header: const CustomRefresherHeader(),
          footer: const CustomRefresherFooter(),
          onRefresh: _myRoomRequestController.onMoreReqRefresh,
          onLoading: _myRoomRequestController.onMoreReqLoading,
          child: _myRoomRequestController.requestlist.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '아직 받은 신청이 없어요',
                      style: kSubtitleStyle2.copyWith(
                          color: kMainBlack.withOpacity(0.38)),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: Column(
                      children: [
                        Text(
                          '\'${title}\'',
                          style: kSubtitleStyle3.copyWith(
                              height: 1.5, color: kMainBlack.withOpacity(0.4)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '방에 들어온 신청 목록이에요',
                          style: kSubtitleStyle3.copyWith(
                              height: 1.5, color: kMainBlack.withOpacity(0.4)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: _myRoomRequestController.requestlist
                              .map((request) => MyroomRequestWidget(
                                    roomId: roomId,
                                    isrequestinfo: true,
                                    request: request,
                                    isbottompadding: true,
                                  ))
                              .toList(),
                        )
                      ],
                    ),
                  ),
                ))),
    );
  }
}
