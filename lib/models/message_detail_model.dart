import 'package:kakao_flutter_sdk/talk.dart';
import 'package:universiting/models/message_model.dart';
import 'package:universiting/models/profile_model.dart';

class MessageDetail {
  String userType;
  String groupTitle;
  List<Profile> memberProfile;
  List<Message> message;

  MessageDetail({required this.userType, required this.message,required this.memberProfile, required this.groupTitle});
  factory MessageDetail.fromJson(Map<String, dynamic> json) => MessageDetail(
      message: List<Map<String, dynamic>>.from(json['message'])
          .map((message) => Message.fromJson(message))
          .toList(),
      groupTitle: json['group_title'],
      memberProfile: List<Map<String, dynamic>>.from(json['member_profile']).map((profile) => Profile.fromJson(profile)).toList(),
      userType: json['user_type']);
}
