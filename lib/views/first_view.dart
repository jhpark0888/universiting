// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:universiting/utils/global_variable.dart';
// import 'package:universiting/views/home_view.dart';
// import 'package:universiting/views/login_view.dart';
// import 'package:universiting/views/signup_university_view.dart';

// class FirstView extends StatefulWidget {
//   const FirstView({Key? key}) : super(key: key);

//   @override
//   State<FirstView> createState() => _FirstViewState();
// }

// class _FirstViewState extends State<FirstView> {
//   late ConnectivityResult result = ConnectivityResult.mobile;
//   @override
//   void initState() {
//     checkConnectionStatus().then((value) => result = value);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (result != ConnectivityResult.none) {
//       return Scaffold(
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextButton(
//                   onPressed: () {
//                     Get.to(() => SignupView());
//                   },
//                   child: const Text('회원가입',
//                       style: TextStyle(color: Colors.black),
//                       textAlign: TextAlign.center),
//                   style: TextButton.styleFrom(primary: Colors.white)),
//               TextButton(
//                   onPressed: () {
//                     Get.to(() => LoginView(
//                           isSignup: false,
//                         ));
//                   },
//                   child: const Text('로그인',
//                       style: TextStyle(color: Colors.black),
//                       textAlign: TextAlign.center),
//                   style: TextButton.styleFrom(primary: Colors.white)),
//               TextButton(
//                   onPressed: () {
//                     Get.to(() => HomeView());
//                   },
//                   child: const Text('지도',
//                       style: TextStyle(color: Colors.black),
//                       textAlign: TextAlign.center),
//                   style: TextButton.styleFrom(primary: Colors.white))
//             ],
//           ),
//         ),
//       );
//     } else
//       return Scaffold(body: Center(child: Text('네트워크 상태를 확인해주세요')));
//   }
// }
