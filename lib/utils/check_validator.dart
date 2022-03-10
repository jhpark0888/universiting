import '../controllers/signup_controller.dart';

class CheckValidate {
  String? validateName(String value) {
    if (value.isEmpty) {
      return '아직 아무것도 쓰지 않았어요';
    } else {
      // Pattern pattern = r'[\-\_\/\\\[\]\(\)\|\{\}*$@$!%*#?~^<>,.&+=]';
      // RegExp regExp = RegExp(pattern.toString());
      // if (regExp.hasMatch(value)) {
      //   return '특수문자는 쓸 수 없어요';
      // }
    }
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return '이메일을 입력하세요';
    } else {
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = RegExp(pattern.toString());
      if (!regExp.hasMatch(value)) {
        return '이메일 형식을 다시 확인해주세요';
      } else {
        return null;
      }
    }
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return '비밀번호를 입력해주세요';
    } else {
      // Pattern pattern =
      //     r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,15}$';
      // RegExp regExp = new RegExp(pattern.toString());
      if (value.length < 8) {
        return '8자 이상이어야해요';
      } else {
        return null;
      }
    }
  }

  String? validatePasswordCheck(String value) {
    if (value.isEmpty) {
      return '';
    } else {
      // Pattern pattern =
      //     r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,15}$';
      // RegExp regExp = new RegExp(pattern.toString());
      if (value != SignupController.to.passwordController.text) {
        return '비밀번호가 달라요';
      } else {
        return null;
      }
    }
  }

  String? validateSpecificWords(String value) {
    if (value.isEmpty) {
      return null;
    } else {
      Pattern pattern =
          r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,15}$';
      RegExp regExp = RegExp(pattern.toString());
      if (regExp.hasMatch(value)) {
        return '특수문자가 포함되어 있어요';
      } else {
        return null;
      }
    }
  }
}
