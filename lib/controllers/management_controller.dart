import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:universiting/api/room_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/admob_controller.dart';
import 'package:universiting/controllers/custom_animation_controller.dart';
import 'package:universiting/models/my_room_model.dart';
import 'package:universiting/models/room_model.dart';
import 'package:universiting/models/send_request_model.dart';
import 'package:universiting/utils/global_variable.dart';
import 'package:universiting/widgets/myroom_widget.dart';
import 'package:universiting/widgets/profile_image_widget.dart';
import 'package:universiting/widgets/room_final_widget.dart';
import 'package:universiting/widgets/room_profile_image_widget.dart';
import 'package:universiting/widgets/room_widget.dart';
import 'package:universiting/widgets/send_request_widget.dart';

class ManagementController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static ManagementController get to => Get.find();

  late TabController managetabController;
  AdmobController admobController = Get.put(AdmobController(),tag: 'MyRoom');
  RefreshController myroomrefreshController = RefreshController();
  RefreshController requestrefreshController = RefreshController();
  // final myRoomList = MyRoom(chiefList: [], memberList: []).obs;
  Rx<Screenstate> myroomstate = Screenstate.loading.obs;
  Rx<Screenstate> requeststate = Screenstate.loading.obs;

  final chiefList = <Room>[].obs;
  final memberList = <Room>[].obs;
  final room = <MyRoomWidget>[].obs;
  RxList<Widget> adRoom = <Widget>[].obs;

  final sendRequestWidgetList = <SendRequestWidget>[].obs;
  final profileImage = <RoomProfileImageWidget>[].obs;

  RxBool enablepullupMyRoom = true.obs;
  RxBool enablepulluprequest = true.obs;

  @override
  void onInit() async {
    managetabController = TabController(length: 2, vsync: this);
    // myRoomList.value = await getMyRoom();
    getRoomList(0);
    getrequestlist(0);
    super.onInit();
  }

  void onRoomRefresh() async {
    await getRoomList(0);
    myroomrefreshController.refreshCompleted();
    print('리프레시 완료');
  }

  void onRoomLoading() async {
    await getRoomList(chiefList.first.id!);
    myroomrefreshController.loadComplete();
    print('로딩 완료');
  }

  void onRequestRefresh() async {
    await getrequestlist(0);

    requestrefreshController.refreshCompleted();
    print('리프레시 완료');
  }

  void onRequestLoading() async {
    await getrequestlist(sendRequestWidgetList.first.request.id);
    requestrefreshController.loadComplete();
    print('로딩 완료');
  }

  Future getRoomList(int last) async {
    await getMyRoom(last).then((httpresponse) {
      if (httpresponse.isError == false) {
        List<Room> tempRoomList = (httpresponse.data as MyRoom).chiefList;
        if (tempRoomList.isEmpty) {
          enablepullupMyRoom(false);
        } else {
          enablepullupMyRoom(true);
          if (last == 0) {
            chiefList(tempRoomList);
          } else {
            for (Room room in tempRoomList.reversed) {
              chiefList.insert(0, room);
            }
          }
        }

        myroomstate(Screenstate.success);
      } else {
        errorSituation(httpresponse);
        myroomstate(Screenstate.error);
      }
      // memberList.value = myRoomList.memberList;
    });
    getRoom();
  }

  Future getrequestlist(int last) async {
    await getSendlist('all', last).then((httpresponse) {
      if (httpresponse.isError == false) {
        List<SendRequest> temprequestlist =
            httpresponse.data as List<SendRequest>;
        if (temprequestlist.isEmpty) {
          enablepulluprequest(false);
        } else {
          enablepulluprequest(true);
          if (last == 0) {
            sendRequestWidgetList.clear();
            sendRequestWidgetList(temprequestlist
                .map((joinrequest) => SendRequestWidget(
                      request: joinrequest,
                    ))
                .toList());
            sendRequestWidgetList.refresh();
          } else {
            for (SendRequest request in temprequestlist.reversed) {
              sendRequestWidgetList.insert(
                  0,
                  SendRequestWidget(
                    request: request,
                  ));
            }
          }
        }

        myroomstate(Screenstate.success);
      } else {
        errorSituation(httpresponse);
        myroomstate(Screenstate.error);
      }
      // memberList.value = myRoomList.memberList;
    });
  }

  void getRoom() {
    room.clear();
    for (Room i in chiefList) {
      print('object ${i.roomstate}');
      room.add(MyRoomWidget(
        room: i,
        roomMember: getHostsList(i),
        isChief: true,
      ));
    }
    for (Room i in memberList) {
      room.add(MyRoomWidget(
        room: i,
        roomMember: getHostsList(i),
        isChief: false,
      ));
    }
    adRoom = getAdRoom(room).obs;
  }

  List<RoomProfileImageWidget> getHostsList(Room room) {
    switch (room.totalMember) {
      case 2:
      case 3:
      case 4:
        print(room);
        break;
    }
    profileImage.clear();
    for (int i = 0; i < room.hosts!.length; i++) {
      profileImage.add(RoomProfileImageWidget(
        host: room.hosts![i],
        isname: false,
        isReject: true,
      ));
    }
    return profileImage.toList();
  }

  List<Widget> getAdRoom(List<dynamic> room) {
    List<dynamic> list = List<dynamic>.from(room);
    if (room.length >= 2) {
      for (int a = 0; a < list.length; a++) {
        if ((a + 1)% 3 == 0) {
          if(a != 0) {
            list.insert(
           list.length - a ,
              Column(
                children: [
                  const SizedBox(height: 18),
                  // Container(
                  //    height: admobController.size.value.height.toDouble(),
                  // width: admobController.size.value.width.toDouble(),
                  //     decoration: const BoxDecoration(color: Colors.transparent),
                  //     child: AdWidget(ad: admobController.getBanner()..load())),
                   Container(
                     height:  admobController.sizes.value?.height.toDouble(),
                  width: admobController.sizes.value?.width.toDouble(),
                      decoration: const BoxDecoration(color: Colors.transparent),
                      child: AdWidget(ad: admobController.getAnchorBanner()..load(),key: UniqueKey())),
                      const SizedBox(height: 18),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          thickness: 2.5,
                          color: kMainBlack.withOpacity(0.1),
                        ),
                      ),
                ],
              ),
          );
          }
        }
      }
    }
    return List<Widget>.from(list);
  }
}
