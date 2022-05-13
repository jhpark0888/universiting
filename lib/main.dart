import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:universiting/app.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/notifications_controller.dart';
import 'package:universiting/views/first_view.dart';
import 'package:universiting/views/home_view.dart';
import 'package:universiting/views/univ_room_view.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform, name: 'universiting');

    // print(Firebase.apps.length);
  } else {
    Firebase.app();
  }
  NotificationController notificationController =
      Get.put(NotificationController());
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
  String? temptoken = await const FlutterSecureStorage().read(key: 'token');
  print(temptoken);
  String? lat = await const FlutterSecureStorage().read(key: 'lat');
  String? lng = await const FlutterSecureStorage().read(key: 'lng');

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    print('error : ${details.library}');
    // if (kReleaseMode) exit(1);
  };
  runApp(MyApp(
    token: temptoken,
    lat: lat,
    lng: lng,
  ));
}

class MyApp extends StatefulWidget {
  final String? token;
  final String? lat;
  final String? lng;
  MyApp({required this.token, required this.lat, required this.lng});
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
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundWhite,
        fontFamily: 'SUIT',
        appBarTheme: const AppBarTheme(
          backgroundColor: kBackgroundWhite,
          foregroundColor: kMainBlack,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: kMainBlack,
            splashFactory: NoSplash.splashFactory,
          ),
        ),
        bottomSheetTheme:
            BottomSheetThemeData(backgroundColor: Colors.transparent),
        // bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.transparent),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      home: widget.token == null
          ? HomeView(
              login: false,
              tag: '첫 화면',
              lat: 37.563600,
              lng: 126.962370,
            )
          : App(lat: double.parse(widget.lat!), lng: double.parse(widget.lng!)),
      getPages: [
        GetPage(
            name: '/',
            page: () => HomeView(
                  login: false,
                  tag: '첫 화면',
                  lat: 37.563600,
                  lng: 126.962370,
                )),
        GetPage(
            name: '/first',
            page: () => UnivRoomView(),
            transition: Transition.downToUp)
      ],
    );
  }
}
