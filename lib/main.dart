import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/views/first_view.dart';
import 'package:universiting/views/home_view.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  var token = await FirebaseMessaging.instance.getToken();
  print("token : ${token ?? 'token NULL!'}");
  FlutterSecureStorage().write(key: 'fcm_token', value: token);
  try {
    if (Platform.isIOS || Platform.isAndroid) {
      Intl.systemLocale = await findSystemLocale();
    }
  } catch (e) {
    print(e);
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;
    //   var androidNotiDetails = AndroidNotificationDetails(
    //     channel.id,
    //     channel.name,
    //     channelDescription: channel.description,
    //   );
    //   var iOSNotiDetails = const IOSNotificationDetails();
    //   var details =
    //       NotificationDetails(android: androidNotiDetails, iOS: iOSNotiDetails);
    //   if (notification != null) {
    //     flutterLocalNotificationsPlugin.show(
    //       notification.hashCode,
    //       notification.title,
    //       notification.body,
    //       details,
    //     );
    //   }
    // });

    // FirebaseMessaging.onMessageOpenedApp.listen((message) {
    //   print(message);
    // });

    // _initKaKaoTalkInstalled();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaleFactor: 1.0,
        ),
        child: child!,
      ),
      //  localizationsDelegates: const [
      //   GlobalMaterialLocalizations.delegate,
      //   Glob
      //   GlobalW.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // supportedLocales: const [
      //   Locale('ko'),
      // ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: kBackgroundWhite),
      home: HomeView(
        login: false,
        tag: '첫 화면',
        lat: 37.563600,
        lng: 126.962370,
      ),
    );
  }
}
