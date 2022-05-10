import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:universiting/api/room_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/models/my_room_model.dart';
import 'package:universiting/models/myroom_request_model.dart';
import 'package:universiting/models/room_model.dart';
import 'package:universiting/models/send_request_model.dart';
import 'package:universiting/widgets/myroom_widget.dart';
import 'package:universiting/widgets/profile_image_widget.dart';
import 'package:universiting/widgets/room_final_widget.dart';
import 'package:universiting/widgets/room_profile_image_widget.dart';
import 'package:universiting/widgets/room_widget.dart';
import 'package:universiting/widgets/send_request_widget.dart';

class MyRoomRequestController extends GetxController
    with GetSingleTickerProviderStateMixin {
  MyRoomRequestController({required this.roomId, required this.requestlist});
  static MyRoomRequestController get to => Get.find();

  RefreshController moreRequestRefreshController = RefreshController();
  Rx<Screenstate> morerequeststate = Screenstate.loading.obs;

  RxBool enablepullupMoreRequest = true.obs;
  RxList<MyRoomRequest> requestlist = <MyRoomRequest>[].obs;
  late int roomId;

  @override
  void onInit() async {
    getmorerequestlist(0);
    super.onInit();
  }

  void onMoreReqRefresh() async {
    await getmorerequestlist(0);
    enablepullupMoreRequest(true);
    moreRequestRefreshController.refreshCompleted();
    print('리프레시 완료');
  }

  void onMoreReqLoading() async {
    await getmorerequestlist(requestlist.first.id);
    moreRequestRefreshController.loadComplete();
    print('로딩 완료');
  }

  Future getmorerequestlist(int last) async {
    print(last);
    await getMyRoomRequestlist('all', last, roomId).then((httpresponse) {
      if (httpresponse.isError == false) {
        List<MyRoomRequest> temprequestlist =
            httpresponse.data as List<MyRoomRequest>;
        if (temprequestlist.isEmpty) {
          enablepullupMoreRequest(false);
        } else {
          enablepullupMoreRequest(true);
          if (last == 0) {
            requestlist(temprequestlist);
          } else {
            for (MyRoomRequest request in temprequestlist.reversed) {
              requestlist.insert(
                0,
                request,
              );
            }
          }
        }

        morerequeststate(Screenstate.success);
      } else {
        morerequeststate(Screenstate.error);
      }
      // memberList.value = myRoomList.memberList;
    });
  }
}
