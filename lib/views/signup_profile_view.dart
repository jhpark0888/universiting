// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:universiting/constant.dart';
// import '../api/signup_api.dart';
// import '../controllers/signup_controller.dart';
// import '../utils/global_variable.dart';
// import '../widgets/appbar_widget.dart';
// import '../widgets/textformfield_widget.dart';

// class SignupProfileView extends StatelessWidget {
//   SignupProfileView({Key? key}) : super(key: key);
//   SignupController signupController = Get.find();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBarWidget(
//         title: '회원 가입',
//         actions: [
//           IconButton(
//               onPressed: () async {
//                 await resultOfConnection().then(
//                   (value) => value
//                       ? postProfile()
//                       : showCustomDialog('네트워크를 확인해주세요', 3000),
//                 );
//               },
//               icon: Text(
//                 '다음',
//                 style: kStyleAppbar,
//               ))
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
//         child: SingleChildScrollView(
//           child:
//               Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
//             SizedBox(
//               height: Get.height / 20,
//             ),
//             RichText(
//                 textAlign: TextAlign.center,
//                 text: TextSpan(children: [
//                   TextSpan(
//                       text: '프로필',
//                       style: kStyleHeader.copyWith(color: Colors.blue)),
//                   const TextSpan(text: '을 작성해주세요', style: kStyleHeader)
//                 ])),
//             SizedBox(
//               height: Get.height / 20,
//             ),
//             Text(
//               '닉네임',
//               style: kStyleContent.copyWith(fontSize: 14),
//               textAlign: TextAlign.start,
//             ),
//             CustomTextFormField(controller: signupController.nameController),
//             SizedBox(height: Get.height / 20),
//             Text(
//               '생년월일',
//               style: kStyleContent.copyWith(fontSize: 14),
//               textAlign: TextAlign.start,
//             ),
//             SizedBox(height: Get.height / 30),
//             Obx(() => GestureDetector(
//                 onTap: () {
//                   customBottomSheet();
//                 },
//                 child: Text(
//                     '${signupController.datetime[0].year}년 ${signupController.datetime[0].month}월 ${signupController.datetime[0].day}일'))),
//             SizedBox(height: Get.height/ 20),
//             Text(
//               '성별',
//               style: kStyleContent.copyWith(fontSize: 14),
//               textAlign: TextAlign.start,
//             ),
//             Row(
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     signupController.gender.value = 'M';
//                   },
//                   child: const Text('남'),
//                   style: ElevatedButton.styleFrom(
//                       primary: Colors.black.withOpacity(0.6)),
//                 ),
//                 ElevatedButton(
//                     onPressed: () {
//                       signupController.gender.value = 'F';
//                     },
//                     child: const Text('여')),
//               ],
//             ),
//             SizedBox(height: Get.height / 20),
//           ]),
//         ),
//       ),
//     );
//   }

//   void customBottomSheet() {
//     Get.bottomSheet(
//         Container(
//             child: Column(mainAxisSize: MainAxisSize.min, children: [
//           Container(
//               height: 200,
//               child: CupertinoDatePicker(
//                 mode: CupertinoDatePickerMode.date,
//                 initialDateTime: signupController.datetime[0],
//                 minimumDate: DateTime(1900, 1, 1),
//                 maximumDate: DateTime.now(),
//                 onDateTimeChanged: (DateTime newDateTime) {
//                   signupController.datetime[0] = newDateTime;
//                   print(newDateTime);
//                   print(newDateTime.year);
//                 },
//               ))
//         ])),
//         backgroundColor: Colors.white);
//   }
// }
