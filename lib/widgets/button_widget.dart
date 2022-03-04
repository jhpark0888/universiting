// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:universiting/function/global_variable.dart';

// class SignupNextButton extends StatelessWidget {
//   String data;
//   SignupNextButton({ Key? key, required this.data,  }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       onPressed: (){resultOfConnection().then((value) => value
//                     ? signupController.isUniv.value
//                         ? Get.to(() => SignupDepartmentScreen())
//                         : print(signupController.isUniv.value)
//                     : showCustomDialog('네트워크를 확인해주세요', 3000));},
//       icon: Text('다음'),
//     );
//   }
// }