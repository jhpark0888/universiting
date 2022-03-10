// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:universiting/constant.dart';
// import '../api/signup_api.dart';
// import '../views/signup_check_email_view.dart';
// import '../views/signup_profile_view.dart';
// import '../controllers/signup_controller.dart';
// import '../utils/check_validator.dart';
// import '../utils/global_variable.dart';
// import '../widgets/appbar_widget.dart';
// import '../widgets/textformfield_widget.dart';

// class SignupUserView extends StatelessWidget {
//   SignupUserView({Key? key}) : super(key: key);
//   SignupController signupController = Get.find();
//   final _key = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBarWidget(
//         title: '회원 가입',
//         actions: [
//           IconButton(
//               onPressed: () async {
//                 if (_key.currentState!.validate()) {
//                   resultOfConnection().then(
//                     (value) {
//                       if (value) {
//                         checkEmail();
//                         Get.to(() => SignupCheckEmailView());
//                       } else {
//                         showCustomDialog('네트워크를 확인해주세요', 3000);
//                       }
//                     },
//                   );
//                 }
//               },
//               icon: Text('다음',
//                   style: _key.currentState?.validate() != null &&
//                           _key.currentState?.validate() == true
//                       ? kStyleAppbar.copyWith(color: Colors.blue)
//                       : kStyleAppbar.copyWith(
//                           color: Colors.black.withOpacity(0.6))))
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
//           child: GestureDetector(
//             onTap: () {
//               FocusScope.of(context).unfocus();
//             },
//             child: Form(
//               key: _key,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   SizedBox(height: Get.height / 20),
//                   RichText(
//                     text: TextSpan(children: [
//                       TextSpan(
//                           text: '계정',
//                           style: kStyleHeader.copyWith(color: Colors.blue)),
//                       const TextSpan(text: '을 만들어주세요', style: kStyleHeader)
//                     ]),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: Get.height / 20),
//                   Text(
//                     '${signupController.universityController.text} 이메일 주소',
//                     style: kStyleContent.copyWith(fontSize: 14),
//                     textAlign: TextAlign.start,
//                   ),
//                   Row(children: [
//                     Expanded(
//                         child: CustomTextFormField(
//                             controller: signupController.emailController)),
//                     Text(signupController.univLink.value)
//                   ]),
//                   SizedBox(height: Get.height / 20),
//                   Text(
//                     '비밀번호',
//                     style: kStyleContent.copyWith(fontSize: 14),
//                     textAlign: TextAlign.start,
//                   ),
//                   CustomTextFormField(
//                     controller: signupController.passwordController,
//                     obsecuretext: true,
//                     validator: ((value) =>
//                         CheckValidate().validatePassword(value!)),
//                   ),
//                   SizedBox(height: Get.height / 20),
//                   Text(
//                     '비밀번호 확인',
//                     style: kStyleContent.copyWith(fontSize: 14),
//                     textAlign: TextAlign.start,
//                   ),
//                   CustomTextFormField(
//                     controller: signupController.passwordCheckController,
//                     obsecuretext: true,
//                     validator: ((value) =>
//                         CheckValidate().validatePasswordCheck(value!)),
//                   ),
//                   SizedBox(height: Get.height / 20),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
