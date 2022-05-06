import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/models/host_model.dart';
import 'package:universiting/models/room_model.dart';

class SendRequest {
  SendRequest({
    required this.id,
    required this.joinInfo,
    this.members,
    required this.type,
    this.room,
    this.requeststate,
  });

  int id;
  List<Host>? members;
  int type;
  Room? room;
  JoinInfo joinInfo;
  Rx<StateManagement>? requeststate;

  factory SendRequest.fromJson(Map<String, dynamic> json) => SendRequest(
      id: json["id"],
      joinInfo: JoinInfo.fromJson(json["join_info"]),
      room: json['room_info'] != null ? Room.fromJson(json['room_info']) : null,
      type: json['type'],
      members: json['member'] != null
          ? List<Map<String, dynamic>>.from(json['member'])
              .map((value) => Host.fromJson(value))
              .toList()
          : null,
      requeststate: json['type'] == 0
          ? StateManagement.sendme.obs
          : json["join_info"]['type'] == 0
              ? StateManagement.waitingFriend.obs
              : json["join_info"]['type'] == 1
                  ? StateManagement.waitingThey.obs
                  : json["join_info"]['type'] == 2
                      ? StateManagement.friendReject.obs
                      : StateManagement.theyReject.obs);
}

class JoinInfo {
  JoinInfo({
    required this.id,
    this.uni,
    required this.introduction,
    required this.type,
    this.age,
    this.gender,
  });

  int id;
  String? uni;
  String introduction;
  int type;
  double? age;
  String? gender;

  factory JoinInfo.fromJson(Map<String, dynamic> json) => JoinInfo(
        id: json["id"],
        uni: json["uni"],
        introduction: json["introduction"],
        type: json["type"],
        age: json["age"],
        gender: json['gender'] == 'M'
            ? '남성'
            : json['gender'] == 'F'
                ? '여성'
                : '혼성',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uni": uni,
        "introduction": introduction,
        "type": type,
        "age": age,
        "gender": gender,
      };
}
