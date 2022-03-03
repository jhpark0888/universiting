// import 'package:flutter/material.dart';
// import 'package:kakao_flutter_sdk/all.dart';
// import 'package:kakao_flutter_sdk/link.dart';
// import 'package:universiting/kakao.dart';

// class MainScreen extends StatefulWidget {
//   const MainScreen({Key? key}) : super(key: key);

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   void initState() {
//     String kakaoAppKey = "eb18509049dc9fe5b2261f98dae73979";
//     // KakaoContext.clientId = kakaoAppKey;

//     super.initState();
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment : MainAxisAlignment.center,
//           children: [
//             TextButton(
//               onPressed: () async{
//                 await KakaoShareManager().isKakaotalkInstalled().then((value) { print(value);
//                   if (value) {
//                     KakaoShareManager().shareMyCode();
//                   }
//                 });
//               },
//               child: Text('카카오톡과 연동하기'),
//             ),
//             TextButton(onPressed: ()async{await KakaoShareManager().loginWithWeb();}, child: Text('카카오톡 로그인'))
//           ],
//         ),
//       ),
//     );
//   }
// }

