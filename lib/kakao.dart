// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:kakao_flutter_sdk/all.dart';
// import 'package:http/http.dart'as http;
// import 'package:kakao_flutter_sdk/link.dart';

// class KakaoShareManager {

//   static final KakaoShareManager _manager = KakaoShareManager._internal();

//   factory KakaoShareManager() {
//     return _manager;
//   }

//   KakaoShareManager._internal() {
//     // 초기화 코드
//   }

//   void initializeKakaoSDK() {
//     String kakaoAppKey = "eb18509049dc9fe5b2261f98dae73979";
//     KakaoContext.clientId = kakaoAppKey;
//   }

//   Future<bool> isKakaotalkInstalled() async {
//     bool installed = await isKakaoTalkInstalled();
//     return installed;
//   }

//   void shareMyCode() async {
//     try {
//       var template = _getTemplate();
//       var uri = await LinkClient.instance.defaultWithTalk(template);
//       await LinkClient.instance.launchKakaoTalk(uri);
//     } catch (error) {
//       print(error.toString());
//     }
//   }

//   DefaultTemplate _getTemplate() {
//     String title = "안녕하세여";
//     Uri imageLink = Uri.parse("http://mud-kage.kakao.co.kr/dn/Q2iNx/btqgeRgV54P/VLdBs9cvyn8BJXB3o7N8UK/kakaolink40_original.png");
//     Link link = Link(
//         webUrl: Uri.parse("https://developers.kakao.com"),
//         mobileWebUrl: Uri.parse("https://developers.kakao.com")
//     );

//     Content content = Content(
//       title,
//       imageLink,
//       link,
//     );

//     FeedTemplate template = FeedTemplate(
//         content,
//         social: Social(likeCount: 286, commentCount: 45, sharedCount: 845),
//         buttons: [
//           Button("웹으로 보기",
//               Link(webUrl: Uri.parse("https://developers.kakao.com"))),
//           Button("앱으로 보기",
//               Link(webUrl: Uri.parse("https://developers.kakao.com"))),
//         ]
//     );

//     return template;
//   }
//   Future<void> _loginWithKakaoApp() async {
//     try {
//       var code = await AuthCodeClient.instance.requestWithTalk();
//       // await _issueAccessToken(code);
//     } catch (error) {
//       print(error.toString());
//     }

    
//   }
//   Future<void> loginWithWeb() async {
//     try {
//       var code = await AuthCodeClient.instance.request();
//       // await _issueAccessToken(code);
//     } catch (error) {
//       print(error.toString());
//     }
//   }
//   // Future<void> _issueAccessToken(String authCode) async {
//   //   try {
//   //     var token = await AuthApi.instance.issueAccessToken(authCode);
//   //     AccessTokenStore.instance.toStore(token);
//   //     final kakaoUrl = Uri.parse('[토큰 전달할 URL]');
//   //     http
//   //         .post(kakaoUrl, body: json.encode({'access_token': token}))
//   //         .then((res) => print(json.decode(res.body)))
//   //         .catchError((e) => print(e.toString()));
//   //     Navigator.pushNamed(context, '/');
//   //   } catch (error) {
//   //     print(error.toString());
//   //   }
//   // }
// }