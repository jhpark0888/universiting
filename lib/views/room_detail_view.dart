import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/controllers/room_detail_controller.dart';
import 'package:universiting/views/participate_view.dart';
import 'package:universiting/widgets/appbar_widget.dart';
import 'package:universiting/widgets/button_widget.dart';
import 'package:universiting/widgets/room_person_widget.dart';

class RoomDetailView extends StatelessWidget {
  RoomDetailView({Key? key, required this.roomid}) : super(key: key);
  String roomid;

  @override
  Widget build(BuildContext context) {
      RoomDetailController roomDetailController = Get.put(RoomDetailController(roomid: roomid),tag: '$roomid번 방');
    return Obx(
      ()=> Scaffold(
        appBar: AppBarWidget(
          title:  roomDetailController.detailRoom.value.title,
          actions:  [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: (){showCustomModalPopup(context,value1: '이 방 신고하기',func1: (){}, textStyle: kSubtitleStyle3.copyWith(color: kErrorColor));},
                child: Icon(
                  Icons.more_horiz,
                  color: kMainBlack,
                ),
              ),
            )
          ],
        ),
        body:Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('간단한 방 소개', style: kSubtitleStyle2),
                const SizedBox(height: 12),
                Text(roomDetailController.detailRoom.value.title, style: kBodyStyle1),
                const SizedBox(height: 20),
                Text('구성원 ${roomDetailController.detailRoom.value.totalMember}명'),
                const SizedBox(height: 12),
                Column(children: roomDetailController.roomPersonList),
                const SizedBox(height: 20),
                GestureDetector(onTap: (){Get.to(()=> ParticiapteView(roomid: roomid,peopleNumber: roomDetailController.detailRoom.value.totalMember,));},child: PrimaryButton(text: '같이 갈 친구들 초대하기')),
                const SizedBox(height: 12),
                Text('같이 갈 친구들을 초대하고, 친구들이 모두 수락을 하면 참여 신청이 완료돼요.', style:  kSmallCaptionStyle.copyWith(color: kMainBlack.withOpacity(0.6)),)
              ],
            ),
          ),
        ),
    );
  }
}
