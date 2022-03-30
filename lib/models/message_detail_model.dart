import 'package:kakao_flutter_sdk/talk.dart';
import 'package:universiting/models/message_model.dart';

class MessageDetail {
  String userType;
  List<Message> message;

  MessageDetail({required this.userType, required this.message});
  factory MessageDetail.fromJson(Map<String, dynamic> json) => MessageDetail(
      message: List<Map<String, dynamic>>.from(json['message'])
          .map((message) => Message.fromJson(message))
          .toList(),
      userType: json['user_type']);
}
