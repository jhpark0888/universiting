import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/management_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:universiting/models/myroom_request_model.dart';
import 'package:universiting/models/send_request_model.dart';
import 'package:universiting/views/room_info_view.dart';
import 'package:universiting/widgets/appbar_widget.dart';
import 'package:universiting/widgets/myroom_request_widget.dart';
import 'package:universiting/widgets/new_person_widget.dart';
import 'package:universiting/widgets/scroll_noneffect_widget.dart';

class SendRequestView extends StatelessWidget {
  SendRequestView({
    Key? key,
    required this.request,
  }) : super(key: key);

  SendRequest request;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(
          title: '보낸 신청',
        ),
        body: Column(children: [
          Column(
              // children: request.members.map((member) => NewPersonTileWidget(profile: member)),
              )
        ]));
  }
}
