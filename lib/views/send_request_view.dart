import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/management_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:universiting/controllers/profile_controller.dart';
import 'package:universiting/controllers/send_request_detail_controller.dart';
import 'package:universiting/models/myroom_request_model.dart';
import 'package:universiting/models/send_request_model.dart';
import 'package:universiting/views/room_info_view.dart';
import 'package:universiting/widgets/appbar_widget.dart';
import 'package:universiting/widgets/button_widget.dart';
import 'package:universiting/widgets/loading_widget.dart';
import 'package:universiting/widgets/myroom_request_widget.dart';
import 'package:universiting/widgets/new_person_host_widget.dart';
import 'package:universiting/widgets/new_person_widget.dart';
import 'package:universiting/widgets/room_info_widget.dart';
import 'package:universiting/widgets/scroll_noneffect_widget.dart';

class SendRequestView extends StatelessWidget {
  SendRequestView({Key? key, required this.id, required this.stateManagement})
      : super(key: key);

  int id;
  StateManagement stateManagement;

  @override
  Widget build(BuildContext context) {
    SendRequestDetailController controller = Get.put(
        SendRequestDetailController(id: id, stateManagement: stateManagement));
    return Obx(
      () => controller.morerequeststate.value == Screenstate.loading
          ? const LoadingWidget()
          : Scaffold(
              appBar: AppBarWidget(
                  title: '보낸 신청',
                  textStyle: k20SemiBold.copyWith(fontWeight: FontWeight.w500),
                  actions: [
                    IconButton(
                      icon: SvgPicture.asset('assets/icons/more.svg'),
                      onPressed: () {},
                    )
                  ]),
              body: Obx(
                () => Padding(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                          children: controller.sendRequest.value.members!
                              .map((member) =>
                                  NewPersonTileHostWidget(host: member))
                              .toList()),
                      const SizedBox(height: 28),
                      const Text('신청 메세지',
                          style: k16Medium, textAlign: TextAlign.start),
                      const SizedBox(height: 12),
                      Text(controller.sendRequest.value.joinInfo.introduction,
                          style: k16Light.copyWith(height: 1.5)),
                      const SizedBox(height: 20),
                      RoomInfoWidget(
                          avgAge: controller.sendRequest.value.joinInfo.age!,
                          mypersonnum:
                              controller.sendRequest.value.members!.length,
                          yourpersonnum:
                              controller.sendRequest.value.members!.length,
                          gender: controller.sendRequest.value.joinInfo.gender,
                          univ: controller.sendRequest.value.joinInfo.uni),
                      if (stateManagement == StateManagement.friendReject ||
                          stateManagement == StateManagement.theyReject)
                        Column(
                          children: [
                            const SizedBox(height: 24),
                            if (controller.sendRequest.value.members! != [])
                              Text(
                                  "'${controller.sendRequest.value.members![controller.sendRequest.value.members!.indexWhere((e) => e.type == 2)].nickname.toString()}'님이 함께 가기를 거절했어요",
                                  style: kInActiveButtonStyle.copyWith(
                                      color: kred)),
                            const SizedBox(height: 12),
                            PrimaryButton(
                              text: '신청 다시 보내기',
                              isactive: true.obs,
                            )
                          ],
                        )
                    ],
                  ),
                ),
              )),
    );
  }
}
