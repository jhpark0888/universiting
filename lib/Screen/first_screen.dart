import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/Screen/login_screen.dart';
import 'package:universiting/Screen/signup_university_screen.dart';
import 'package:universiting/function/global_variable.dart';


class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  late ConnectivityResult result = ConnectivityResult.mobile;
  @override
  void initState(){
    checkConnectionStatus().then((value) => result = value);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(result != ConnectivityResult.none){
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  Get.to(() => SignupScreen());
                },
                child: const Text('회원가입', style: TextStyle(color: Colors.black),textAlign: TextAlign.center),
                style: TextButton.styleFrom(primary: Colors.white)),
            TextButton(
                onPressed: () {
                  Get.to(() => LoginScreen(isSignup: false,));
                },
                child: const Text('로그인', style: TextStyle(color: Colors.black),textAlign: TextAlign.center),
                style: TextButton.styleFrom(primary: Colors.white))
          ],
        ),
      ),
    );
  }
  else return Scaffold(body: Center(child: Text('네트워크 상태를 확인해주세요')));
  }
}
