import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/models/host_model.dart';
import 'package:universiting/models/room_model.dart';
import 'package:universiting/models/send_request_model.dart';

class MyRoomRequest {
  MyRoomRequest({
    required this.id,
    required this.joinInfo,
    this.members,
  });

  int id;
  List<Host>? members;
  JoinInfo joinInfo;

  factory MyRoomRequest.fromJson(Map<String, dynamic> json) => MyRoomRequest(
        id: json["id"],
        joinInfo: JoinInfo.fromJson(json["join_info"]),
        members: json['member'] != null
            ? List<Map<String, dynamic>>.from(json['member'])
                .map((value) => Host.fromJson(value))
                .toList()
            : null,
      );
}
