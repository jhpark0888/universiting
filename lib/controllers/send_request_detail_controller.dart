import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/api/status_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/models/host_model.dart';
import 'package:universiting/models/room_model.dart';
import 'package:universiting/models/send_request_model.dart';
import 'package:universiting/utils/global_variable.dart';

class SendRequestDetailController extends GetxController {
  SendRequestDetailController(
      {required this.id, required this.stateManagement});
  int id;
  StateManagement stateManagement;
  Rx<SendRequest> sendRequest = SendRequest(
      id: 0,
      joinInfo: JoinInfo(
          id: 0, introduction: '', type: 0, age: 0, uni: '', gender: 'M'),
      type: 0,
      members: <Host>[]).obs;
  Rx<Screenstate> morerequeststate = Screenstate.loading.obs;
  @override
  void onInit() async {
    await getSendRequest();

    super.onInit();
  }

  Future getSendRequest() async {
    await getDetailSendView(id, stateManagement).then((httpResponse) {
      if (httpResponse.isError == false) {
        sendRequest(httpResponse.data);
        morerequeststate.value = Screenstate.success;
      } else {
        errorSituation(httpResponse);
      }
      ;
    });
  }
}
