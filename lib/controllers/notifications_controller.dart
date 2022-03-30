import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:universiting/app.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/app_controller.dart';
import 'package:universiting/controllers/chat_list_controller.dart';
import 'package:universiting/controllers/message_detail_controller.dart';
import 'package:universiting/controllers/profile_controller.dart';
import 'package:universiting/controllers/status_room_tab_controller.dart';
import 'package:universiting/models/notifications_model.dart';
import 'package:universiting/views/message_detail_screen.dart';
import 'package:universiting/views/status_view.dart';
import 'package:universiting/views/status_view_received_view.dart';
import 'package:universiting/widgets/chat_widget.dart';
import 'package:universiting/models/message_model.dart';

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

    FirebaseMessaging.onMessageOpenedApp.listen(backgroundMessage);

    super.onInit();
  }

  void backgroundMessage(RemoteMessage message) async {
    print(message.data['type']);
    if (message.data['type'] == 'msg') {
      Get.to(() => MessageDetailScreen(groupId: message.data['group_id']));
    } else if (message.data['type'].contains('receive/')) {
      AppController.to.currentIndex.value = 2;
      StatusRoomTabController.to.currentIndex.value = 0;
      if (AppController.to.stackPage > 0) {
        AppController.to.getbacks();
      }
    } else if (message.data['type'] == 'okay_host') {
      AppController.to.currentIndex.value = 2;
      if (AppController.to.stackPage > 0) {
        AppController.to.getbacks();
      }
    }
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
        print('메세지 받음');
        print(message.notification!.title);
        print(message.notification!.body);
        print(message.data['type']);
        if (message.data['type'] == 'msg') {
          print(ChatListController.to.isInDetailMessage);
          if (ChatListController.to.isInDetailMessage.value == true) {
            MessageDetailController.to.messageList.add(ChatWidget(
                message: Message(
                  id: MessageDetailController
                          .to.messageDetail.value.message.last.id +
                      1,
                  message: message.notification!.body!,
                  date: DateTime.now(),
                ),
                userType: '1',
                profile: MessageDetailController.to.getFindProfile(Message(
                    id: MessageDetailController
                            .to.messageDetail.value.message.last.id +
                        1,
                    message: message.notification!.body!,
                    date: DateTime.now()))[0]));

            print(message.data);
          }
        }
      });
    } else {
      print('permission declined by user');
    }
  }

  void showCustomSnacbar(String? title, String? body) {
    Get.snackbar(title!, body!,
        titleText: Text(
          title,
          style: kActiveButtonStyle,
        ),
        messageText: Text(
          body,
          style: kActiveButtonStyle,
        ),
        backgroundColor: kMainWhite);
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
