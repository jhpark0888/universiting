import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/inquary_controller.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/controllers/profile_controller.dart';
import 'package:universiting/controllers/pw_find_controller.dart';
import 'package:universiting/controllers/signup_controller.dart';
import 'package:universiting/models/httpresponse_model.dart';
import 'package:universiting/models/profile_model.dart';
import 'package:universiting/utils/global_variable.dart';
import 'package:http/http.dart' as http;
import 'package:universiting/utils/user_device_info.dart';
import 'package:universiting/views/pw_find_change_view.dart';
import 'package:universiting/views/withdrawal_view.dart';
import 'package:universiting/models/environment_model.dart';

Future<void> getMyProfile() async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = const FlutterSecureStorage();
  ProfileController profileController = Get.find();
  var url = Uri.parse('${Environment.apiUrl}/user_api/profile');
  String? token = await storage.read(key: 'token');
  Map<String, String> headers = {'Authorization': 'Token $token'};
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400);
  } else {
    try {
      var response = await http.get(url, headers: headers);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        String responsebody = utf8.decode(response.bodyBytes);
        profileController.profile.value =
            Profile.fromJson(jsonDecode(responsebody));
        print(response.statusCode);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
      showCustomDialog('서버 점검중입니다.', 1200);
    }
  }
}

Future<void> updateMyProfile(ProfileType profileType, File? image) async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = const FlutterSecureStorage();
  ProfileController profileController = Get.find();
  var url = Uri.parse(
      '${Environment.apiUrl}/user_api/profile?type=${profileType.name}');
  String? token = await storage.read(key: 'token');
  Map<String, String> headers = {'Authorization': 'Token $token'};
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400);
  } else {
    try {
      var request = http.MultipartRequest('PUT', url);
      request.headers.addAll(headers);

      if (profileType != ProfileType.image) {
        request.fields['nickname'] = profileController.nameController.text;
        request.fields['introduction'] = profileController.introController.text;
        request.fields['department_name'] =
            profileController.departmentController.text;
        request.fields['age'] = profileController.profile.value.age.toString();
      }
      if (profileType == ProfileType.image) {
        if (image != null) {
          print('이것도 클릭됨');
          var multipartFile =
              await http.MultipartFile.fromPath('image', image.path);
          request.files.add(multipartFile);
          // profileController.profile.value.profileImage = image.path;
        } else if (image == null) {
          request.fields['image'] = jsonEncode(null);
          // profileController.profile.value.profileImage = '';
        }
      }
      http.StreamedResponse response = await request.send();
      if (response.statusCode >= 200 && response.statusCode < 300) {
        String responsebody = await response.stream.bytesToString();
        // profileController.profile.value.nickname ==
        //     profileController.nameController.text;
        // profileController.profile.value.age ==
        //     int.parse(profileController.ageController.text);
        // profileController.profile.value.introduction ==
        //     profileController.introController.text;
        profileController.profile.value =
            Profile.fromJson(jsonDecode(responsebody));
        print(response.statusCode);
        profileController.profile.value.nickname =
            profileController.nameController.text;
        profileController.profile.value.introduction =
            profileController.introController.text;
        profileController.profile.value.department =
            profileController.departmentController.text;
        profileController.profile.value.age =
            profileController.profile.value.age;
        print(responsebody);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
      showCustomDialog('서버 점검중입니다.', 1200);
    }
  }
}
// Future<HTTPResponse> getDetailRoom(String id) async {
//   ConnectivityResult result = await checkConnectionStatus();
//   FlutterSecureStorage storage = FlutterSecureStorage();
//   String? token = await storage.read(key: 'token');
//   var url = Uri.parse('${Environment.apiUrl}/room_api/room?type=room&room_id=${id}');
//   var headers = {'Authorization': 'Token $token'};
//   if (result == ConnectivityResult.none) {
//     showCustomDialog('네트워크를 확인해주세요', 1400);
//     return HTTPResponse.networkError();
//   } else {
//     try {
//       var response = await http.get(url, headers: headers);
//       print('방 로드api : ${response.statusCode}');
//       String responsebody = utf8.decode(response.bodyBytes);
//       if (response.statusCode >= 200 && response.statusCode < 300) {
//         print(responsebody);
//         return HTTPResponse.success(Room.fromJson(jsonDecode(responsebody)));
//       } else {
//         return HTTPResponse.apiError('', response.statusCode);
//       }
//     } on SocketException {
//       return HTTPResponse.serverError();
//     } catch (e) {
//       print(e);
//       // showcustomCustomDialog(1200);
//       return HTTPResponse.unexpectedError(e);
//     }
//   }
// }

Future<HTTPResponse> getOtherProfile(String id) async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = const FlutterSecureStorage();

  var url = Uri.parse('${Environment.apiUrl}/user_api/profile_info?id=$id');
  String? token = await storage.read(key: 'token');
  Map<String, String> headers = {'Authorization': 'Token $token'};
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400);
    return HTTPResponse.networkError();
  } else {
    try {
      var response = await http.get(url, headers: headers);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        String responsebody = utf8.decode(response.bodyBytes);
        print(responsebody);
        print(response.statusCode);
        return HTTPResponse.success(Profile.fromJson(jsonDecode(responsebody)));
      } else {
        print(response.statusCode);
        return HTTPResponse.apiError('', response.statusCode);
      }
    } on SocketException {
      return HTTPResponse.serverError();
    } catch (e) {
      print(e);
      return HTTPResponse.unexpectedError(e);
    }
  }
}

Future<HTTPResponse> postInquary(
    String email, String content, String name) async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  UserDeviceInfo userDeviceInfo = Get.put(UserDeviceInfo());
  String? token = await storage.read(key: 'token');
  var url = Uri.parse('${Environment.apiUrl}/user_api/ask');
  // var headers = {'Authorization': 'Token $token'};

  var body = {
    'email': email,
    'content': content,
    'real_name': name,
    'os': userDeviceInfo.deviceData.isNotEmpty
        ? "${userDeviceInfo.deviceData.values.first}"
        : "",
    'app_ver': userDeviceInfo.appInfoData.isNotEmpty
        ? userDeviceInfo.appInfoData.keys.first +
            ' ' +
            userDeviceInfo.appInfoData.values.first
        : "",
    'device': userDeviceInfo.deviceData.isNotEmpty
        ? "${userDeviceInfo.deviceData.values.last}"
        : ""
  };
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400000000000000);
    return HTTPResponse.networkError();
  } else {
    // try {
    var response = await http.post(url, body: body);
    String responsebody = utf8.decode(response.bodyBytes);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      print(response.statusCode);
      // selectMemberController.seletedMember.value =
      //     SelectMember.fromJson(jsonDecode(responsebody));
      return HTTPResponse.success('');
    } else {
      return HTTPResponse.apiError('', response.statusCode);
    }
    // } on SocketException {
    //   return HTTPResponse.serverError();
    // } catch (e) {
    //   print(e);
    //   return HTTPResponse.unexpectedError(e);
    // }
  }
}

Future<void> pwfindemailcheck() async {
  ConnectivityResult result = await checkConnectionStatus();
  PwController pwController = Get.find();
  if (result == ConnectivityResult.none) {
    pwController.emailcheckstate(EmailCheckState.fill);
    showCustomDialog('네트워크를 확인해주세요', 1400);
  } else {
    showCustomDialog('입력하신 이메일로 들어가서 링크를 클릭해 본인 인증을 해주세요', 1400);
    pwController.emailcheckstate(EmailCheckState.waiting);
    Uri uri = Uri.parse('${Environment.apiUrl}/user_api/password');

    //이메일 줘야 됨
    final email = {
      'email': pwController.emailController.text.trim(),
    };

    try {
      pwController.emailcheckstate(EmailCheckState.waiting);
      showemailchecksnackbar(
          '${pwController.emailController.text.trim()}로 인증 메일을 보냈어요');

      http.Response response = await http.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: json.encode(email));

      print("비밀번호 찾기 이메일 체크 : ${response.statusCode}");
      if (response.statusCode == 200) {
        pwController.emailcheckstate(EmailCheckState.success);
        Get.to(() => PwFindChangeView());
        // _modalController.showCustomDialog('입력하신 이메일로 새로운 비밀번호를 알려드렸어요', 1400);
      } else if (response.statusCode == 401) {
        pwController.emailcheckstate(EmailCheckState.fill);
        print('에러1');
      } else {
        pwController.emailcheckstate(EmailCheckState.fill);
        print('에러');
      }
    } on SocketException {
      pwController.emailcheckstate(EmailCheckState.fill);
    } catch (e) {
      pwController.emailcheckstate(EmailCheckState.fill);
      print(e);
      // ErrorController.to.isServerClosed(true);
    }
  }
}

Future<void> pwfindchange() async {
  ConnectivityResult result = await checkConnectionStatus();
  PwController pwController = Get.find();

  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400);
  } else {
    Uri uri = Uri.parse('${Environment.apiUrl}/user_api/password?type=find');

    final user = {
      "email": pwController.emailController.text,
      'password': pwController.newpwController.text,
    };

    try {
      http.Response response = await http.put(uri,
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: json.encode(user));

      print("비밀번호 찾기 : ${response.statusCode}");
      if (response.statusCode >= 200 && response.statusCode < 300) {
        getbacks(3);
        showCustomDialog('비밀번호 변경이 완료되었습니다', 1400);
      } else if (response.statusCode == 401) {
        showCustomDialog('현재 비밀번호가 틀렸습니다.', 1400);
      } else {
        showCustomDialog('입력한 정보를 다시 확인해주세요', 1400);
      }
    } on SocketException {
    } catch (e) {
      print(e);
      showErrorDialog();
      // ErrorController.to.isServerClosed(true);
    }
  }
}

Future<void> pwchange() async {
  ConnectivityResult result = await checkConnectionStatus();
  PwController pwController = Get.find();
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400);
  } else {
    String? token = await const FlutterSecureStorage().read(key: "token");

    Uri uri = Uri.parse('${Environment.apiUrl}/user_api/password?type=change');

    //이메일 줘야 됨
    final password = {
      'origin_pw': pwController.originpwController.text,
      'new_pw': pwController.newpwController.text,
    };

    try {
      http.Response response = await http.put(uri,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Token $token',
          },
          body: json.encode(password));

      print("비밀번호 변경 : ${response.statusCode}");
      if (response.statusCode >= 200 && response.statusCode < 300) {
        Get.back();
        showCustomDialog('비밀번호 변경이 완료되었습니다', 1400);
      } else if (response.statusCode == 401) {
        showCustomDialog('현재 비밀번호가 틀렸습니다.', 1400);
      } else {
        showCustomDialog('입력한 정보를 다시 확인해주세요', 1400);
      }
    } on SocketException {
    } catch (e) {
      print(e);
      showErrorDialog();
      // ErrorController.to.isServerClosed(true);
    }
  }
}

Future<HTTPResponse> errorpost(String text) async {
  ConnectivityResult result = await checkConnectionStatus();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  var url = Uri.parse('${Environment.apiUrl}/user_api/error');
  // var headers = {'Authorization': 'Token $token'};

  var body = {'text': text};
  if (result == ConnectivityResult.none) {
    showCustomDialog('네트워크를 확인해주세요', 1400);
    return HTTPResponse.networkError();
  } else {
    try {
      var response = await http.post(url, body: body);
      String responsebody = utf8.decode(response.bodyBytes);
      print('에러 전송 : ${response.statusCode}');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return HTTPResponse.success('');
      } else {
        return HTTPResponse.apiError('', response.statusCode);
      }
    } on SocketException {
      return HTTPResponse.serverError();
    } catch (e) {
      print(e);
      return HTTPResponse.unexpectedError(e);
    }
  }
}

Future<HTTPResponse> deleteuser(
    String pw, List<SelectedOptionWidget> reasonlist) async {
  ConnectivityResult result = await checkConnectionStatus();

  if (result == ConnectivityResult.none) {
    return HTTPResponse.networkError();
  } else {
    String? token = await const FlutterSecureStorage().read(key: "token");
    print('user token: $token');

    var uri = Uri.parse("${Environment.apiUrl}/user_api/resign");

    String reason = "";
    for (var reasonwidget in reasonlist) {
      if (reasonwidget.isSelected.value == true) {
        reason += reasonwidget.text;
      }
    }

    final password = {
      'password': pw,
      'reason': reason,
    };

    try {
      http.Response response = await http.post(uri,
          headers: {
            'Content-Type': 'application/json',
            "Authorization": "Token $token"
          },
          body: json.encode(password));

      print("회원탈퇴: ${response.statusCode}");
      print(utf8.decode(response.bodyBytes));
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Get.offAll(() => StartScreen());

        // FlutterSecureStorage().delete(key: "token");
        // FlutterSecureStorage().delete(key: "id");
        // Get.delete<AppController>();
        // Get.delete<HomeController>();
        // Get.delete<SearchController>();
        // Get.delete<ProfileController>();

        return HTTPResponse.success('success');
      } else if (response.statusCode == 401) {
        return HTTPResponse.apiError('', response.statusCode);
      } else if (response.statusCode == 406) {
        return HTTPResponse.apiError('', response.statusCode);
      } else {
        return HTTPResponse.apiError('', response.statusCode);
      }
    } on SocketException {
      return HTTPResponse.serverError();
    } catch (e) {
      print(e);
      return HTTPResponse.unexpectedError(e);
      // ErrorController.to.isServerClosed(true);
    }
  }
}
