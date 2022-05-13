import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl/intl.dart';
import 'package:universiting/api/chat_api.dart';
import 'package:universiting/api/status_api.dart';
import 'package:universiting/app.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/app_controller.dart';
import 'package:universiting/controllers/chat_list_controller.dart';
import 'package:universiting/controllers/message_detail_controller.dart';
import 'package:universiting/controllers/profile_controller.dart';
import 'package:universiting/controllers/status_controller.dart';
import 'package:universiting/controllers/status_room_tab_controller.dart';
import 'package:universiting/models/notifications_model.dart';
import 'package:universiting/utils/global_variable.dart';
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
    if (message.data['type'].contain('msg')) {
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

    print(settings.authorizationStatus);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('user granted the permission');
      messaging.getToken();
      //main message
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        Notifications notification = Notifications(
            title: message.notification!.title,
            body: message.notification!.body,
            dataTitle: message.data['title'],
            dataBody: message.data['body']);
        a.value++;
        notificationInfo.value = notification;
        if (ChatListController.to.isInDetailMessage.value == false) {
          showCustomSnacbar(
              message.notification!.title, message.notification!.body, (a) {
            if (message.data['type'].contains('msg')) {
              Get.to(
                  () => MessageDetailScreen(groupId: message.data['group_id']));
              postTime(int.parse(message.data['group_id']),
                  ProfileController.to.profile.value.userId);
              AppController.to..changePageIndex(2);
              ChatListController
                  .to
                  .chatRoomList[ChatListController.to.chatRoomList.indexWhere(
                      (chatRoomWidget) =>
                          chatRoomWidget.chatRoom.value.group.id.toString() ==
                          message.data['group_id'])]
                  .chatRoom
                  .value
                  .newMsg = 0;
              ChatListController
                  .to
                  .chatRoomList[ChatListController.to.chatRoomList.indexWhere(
                      (chatRoomWidget) =>
                          chatRoomWidget.chatRoom.value.group.id.toString() ==
                          message.data['group_id'])]
                  .chatRoom
                  .refresh();
            }
          });
        }
        print('메세지 받음');
        print(message.notification!.title);
        print(message.notification!.body);
        print('메세지 type : ${message.data['type']}');
        print('메세지 title :${message.data['title']}');
        print('메세지 body: ${message.data['body']}');
        print(message.data);
        if (message.data['type'] == 'msg') {
          if (ChatListController.to.isInDetailMessage.value == true) {
            MessageDetailController.to.messageList.add(ChatWidget(
                message: Message(
                  id: MessageDetailController
                          .to.messageDetail.value.message.last.id +
                      1,
                  message: message.notification!.body!,
                  date: DateTime.now(),
                ),
                userType:
                    MessageDetailController.to.messageDetail.value.userType,
                profile: MessageDetailController.to.getFindProfile(Message(
                    id: MessageDetailController
                            .to.messageDetail.value.message.last.id +
                        1,
                    message: message.notification!.body!,
                    sender: int.parse(message.data['user_id']),
                    date: DateTime.now()))[0]));
            print(MessageDetailController.to.getFindProfile(Message(
                id: MessageDetailController
                        .to.messageDetail.value.message.last.id +
                    1,
                message: message.notification!.body!,
                sender: int.parse(message.data['user_id']),
                date: DateTime.now())));
            postTime(int.parse(message.data['group_id']),
                ProfileController.to.profile.value.userId);
            print(message.data);
            ChatListController
                .to
                .chatRoomList[ChatListController.to.chatRoomList.indexWhere(
                    (chatRoomWidget) =>
                        chatRoomWidget.chatRoom.value.group.id.toString() ==
                        message.data['group_id'])]
                .chatRoom
                .value
                .newMsg = 0;
          } else {
            ChatListController
                .to
                .chatRoomList[ChatListController.to.chatRoomList.indexWhere(
                    (chatRoomWidget) =>
                        chatRoomWidget.chatRoom.value.group.id.toString() ==
                        message.data['group_id'])]
                .chatRoom
                .value
                .newMsg += 1;
          }
          ChatListController
              .to
              .chatRoomList[ChatListController.to.chatRoomList.indexWhere(
                  (chatRoomWidget) =>
                      chatRoomWidget.chatRoom.value.group.id.toString() ==
                      message.data['group_id'])]
              .chatRoom
              .value
              .message
              .message = message.notification!.body!;
          ChatListController
              .to
              .chatRoomList[ChatListController.to.chatRoomList.indexWhere(
                  (chatRoomWidget) =>
                      chatRoomWidget.chatRoom.value.group.id.toString() ==
                      message.data['group_id'])]
              .chatRoom
              .refresh();
        } else if (message.data['type'] == 'time_update/msg') {
          if (ChatListController.to.isInDetailMessage.value == true) {
            MessageDetailController.to.messageList.add(ChatWidget(
                message: Message(
                  sender: 1,
                  id: MessageDetailController
                          .to.messageDetail.value.message.last.id +
                      1,
                  message: message.notification!.body!,
                  date: DateTime.now(),
                ),
                userType:
                    MessageDetailController.to.messageDetail.value.userType,
                profile: MessageDetailController.to.getFindProfile(Message(
                    id: MessageDetailController
                            .to.messageDetail.value.message.last.id +
                        1,
                    message: message.notification!.body!,
                    sender: int.parse(message.data['user_id']),
                    date: DateTime.now()))[0]));
            postTime(int.parse(message.data['group_id']),
                ProfileController.to.profile.value.userId);
          } else {
            ChatListController
                .to
                .chatRoomList[ChatListController.to.chatRoomList.indexWhere(
                    (chatRoomWidget) =>
                        chatRoomWidget.chatRoom.value.group.id.toString() ==
                        message.data['group_id'])]
                .chatRoom
                .value
                .newMsg += 1;
          }
          ChatListController
              .to
              .chatRoomList[ChatListController.to.chatRoomList.indexWhere(
                  (chatRoomWidget) =>
                      chatRoomWidget.chatRoom.value.group.id.toString() ==
                      message.data['group_id'])]
              .chatRoom
              .value
              .group
              .date = DateTime.parse(message.data['time']);
          ChatListController
              .to
              .chatRoomList[ChatListController.to.chatRoomList.indexWhere(
                  (chatRoomWidget) =>
                      chatRoomWidget.chatRoom.value.group.id.toString() ==
                      message.data['group_id'])]
              .chatRoom
              .value
              .message
              .message = message.notification!.body!;
          ChatListController
              .to
              .chatRoomList[ChatListController.to.chatRoomList.indexWhere(
                  (chatRoomWidget) =>
                      chatRoomWidget.chatRoom.value.group.id.toString() ==
                      message.data['group_id'])]
              .chatRoom
              .refresh();
        } else if (message.data['type'] == 'exit/msg') {
          print(ChatListController.to.isInDetailMessage.value);
          if (ChatListController.to.isInDetailMessage.value == true) {
            MessageDetailController.to.messageList.add(ChatWidget(
                message: Message(
                  sender: 1,
                  id: MessageDetailController
                          .to.messageDetail.value.message.last.id +
                      1,
                  message: message.notification!.body!,
                  date: DateTime.now(),
                ),
                userType:
                    MessageDetailController.to.messageDetail.value.userType,
                profile: MessageDetailController.to.getFindProfile(Message(
                    id: MessageDetailController
                            .to.messageDetail.value.message.last.id +
                        1,
                    message: message.notification!.body!,
                    sender: int.parse(message.data['user_id']),
                    date: DateTime.now()))[0]));
            postTime(int.parse(message.data['group_id']),
                ProfileController.to.profile.value.userId);
          } else {
            ChatListController
                .to
                .chatRoomList[ChatListController.to.chatRoomList.indexWhere(
                    (chatRoomWidget) =>
                        chatRoomWidget.chatRoom.value.group.id.toString() ==
                        message.data['group_id'])]
                .chatRoom
                .value
                .newMsg += 1;
          }
          ChatListController
              .to
              .chatRoomList[ChatListController.to.chatRoomList.indexWhere(
                  (chatRoomWidget) =>
                      chatRoomWidget.chatRoom.value.group.id.toString() ==
                      message.data['group_id'])]
              .chatRoom
              .value
              .message
              .message = message.notification!.body!;
          ChatListController.to.getList();
          ChatListController
              .to
              .chatRoomList[ChatListController.to.chatRoomList.indexWhere(
                  (chatRoomWidget) =>
                      chatRoomWidget.chatRoom.value.group.id.toString() ==
                      message.data['group_id'])]
              .chatRoom
              .refresh();
        } else if (message.data['type'] == 'receive/host_invite') {
          // await getReceiveStatus().then((httpresponse) {
          //   if (httpresponse.isError == false) {
          //     StatusController.to.receiveList(httpresponse.data);
          //   }
          // });
          // StatusController.to.makeAllReceiveList();
          print('완료');
        } else if (message.data['type'] == 'chat_group') {
          // await getReceiveStatus().then((httpresponse) {
          //   if (httpresponse.isError == false) {
          //     StatusController.to.receiveList(httpresponse.data);
          //   }
          // });

          // StatusController.to.makeAllReceiveList();
          // await getSendStatus().then((httpresponse) {
          //   if (httpresponse.isError == false) {
          //     StatusController.to.sendList(httpresponse.data);
          //   }
          // });
          // StatusController.to.makeAllSendList();
          String groupId = message.data['group_id'];
          getbacks(1);
          AppController.to.changePageIndex(2);
          ChatListController.to.chatList.value = await getChatList();
          ChatListController.to.chatRoomList.value =
              ChatListController.to.getChatRoomList();
          Get.to(MessageDetailScreen(
            groupId: groupId,
          ));
        }
      });
    } else {
      print('permission declined by user');
    }
  }

  void showCustomSnacbar(
      String? title, String? body, void Function(GetSnackBar)? ontap) {
    Get.snackbar(title!, body!,
        titleText: Text(
          title,
          style: kActiveButtonStyle,
        ),
        messageText: Text(
          body,
          style: kActiveButtonStyle,
        ),
        backgroundColor: kMainWhite,
        onTap: ontap);
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
