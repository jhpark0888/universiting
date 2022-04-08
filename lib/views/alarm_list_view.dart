import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/controllers/alarm_list_controller.dart';
import 'package:universiting/widgets/appbar_widget.dart';

class AlarmListView extends StatelessWidget {
  AlarmListView({Key? key}) : super(key: key);
  AlarmListController alarmListController = Get.put(AlarmListController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: '알림'),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20,10,20,10),
        child: Column(children: [

        ]),
      ),
    );
  }
}
