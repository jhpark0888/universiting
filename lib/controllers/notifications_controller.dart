// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// class NotificationController extends GetxController {
//     static NotificationController get to => Get.find();
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
// Future<String?> getToken() async {
//     try {
//       String? userMessageToken = await messaging.getToken(
//           //TODO: WEB KEY 추가
//           // vapidKey:
//           //     'BCLIUKVcUhNC9-qwvJ01m_YQ3l46lrehYmmBVcXOtMp21iwY6x-EKTOLg8v4wNPNRcjrLMReFfAq0ohfvHjWZOw',
//           );
//       // messaging.deleteToken();
//       print('token : $userMessageToken');
//       return userMessageToken ?? '';
//     } catch (e) {
//       print(e);
//     }
//   }
// }