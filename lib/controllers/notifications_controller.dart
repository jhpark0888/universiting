import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/main.dart';
import 'package:universiting/models/notifications_model.dart';

class NotificationController extends GetxController {
  static NotificationController get to => Get.find();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  RxInt a = 0.obs;
  final notificationInfo = Notifications().obs;
  @override
  void onInit() {
    // FirebaseMessaging.instance.getInitialMessage();

    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;
    //   if (notification != null && android != null && !kIsWeb) {
    //     flutterLocalNotificationsPlugin.show(
    //       notification.hashCode,
    //       notification.title,
    //       notification.body,
    //       NotificationDetails(
    //         android: AndroidNotificationDetails(
    //           channel.id,
    //           channel.name,
    //           icon: 'launch_background',
    //         ),
    //       ),
    //     );
    //   }
    // });
    registerNotification();

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Notifications notification = Notifications(
          title: message.notification?.title,
          body: message.notification?.body,
          dataTitle: message.data['title'],
          dataBody: message.data['body']);
      a.value++;
      notificationInfo.value = notification;
      print('바디: ${notificationInfo.value.body}');
      print('title : ${notificationInfo.value.title}');

      print('dataTitle : ${notificationInfo.value.dataTitle}');
      print('dataBody : ${notificationInfo.value.dataBody}');
    });

    super.onInit();
  }

  Future<String?> getToken() async {
    try {
      String? userMessageToken = await messaging.getToken(
          //TODO: WEB KEY 추가
          // vapidKey:
          //     'BCLIUKVcUhNC9-qwvJ01m_YQ3l46lrehYmmBVcXOtMp21iwY6x-EKTOLg8v4wNPNRcjrLMReFfAq0ohfvHjWZOw',
          );
      // messaging.deleteToken();
      print('token : $userMessageToken');
      return userMessageToken ?? '';
    } catch (e) {
      print(e);
    }
  }

  //register notification
  void registerNotification() async {
    // await Firebase.initializeApp();
    messaging = FirebaseMessaging.instance;

    //instance type -- not determined(null), granted(true) and decline(false)
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('user granted the permission');

      //main message

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        Notifications notification = Notifications(
            title: message.notification!.title,
            body: message.notification!.body,
            dataTitle: message.data['title'],
            dataBody: message.data['body']);
        a.value++;
        notificationInfo.value = notification;
        showCustomSnacbar(
            message.notification!.title, message.notification!.body);
            print(message.notification!.title);
            print(message.notification!.body);
      });
    } else {
      print('permission declined by user');
    }
  }

  void showCustomSnacbar(String? title, String? body) {
    Get.snackbar(
      title!,
      body!,
      titleText: Text(
        title,
        style: kActiveButtonStyle,
      ),
      messageText: Text(
        body,
        style: kActiveButtonStyle,
      ),
      backgroundColor: kMainWhite
    );
  }
}


// FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification?.android;
//       var androidNotiDetails = AndroidNotificationDetails(
//         channel.id,
//         channel.name,
//         channelDescription: channel.description,
//       );
//       var iOSNotiDetails = const IOSNotificationDetails();
//       var details =
//           NotificationDetails(android: androidNotiDetails, iOS: iOSNotiDetails);
//       if (notification != null) {
//         flutterLocalNotificationsPlugin.show(
//           notification.hashCode,
//           notification.title,
//           notification.body,
//           details,
//         );
//       }
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       print(message);
//     });
