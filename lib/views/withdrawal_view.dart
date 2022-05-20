import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:universiting/api/profile_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/admob_controller.dart';
import 'package:universiting/controllers/app_controller.dart';
import 'package:universiting/controllers/chat_list_controller.dart';
import 'package:universiting/controllers/home_controller.dart';
import 'package:universiting/controllers/inquary_controller.dart';
import 'package:universiting/controllers/management_controller.dart';
import 'package:universiting/controllers/map_controller.dart';
import 'package:universiting/controllers/modal_controller.dart';
import 'package:universiting/controllers/profile_controller.dart';
import 'package:universiting/controllers/status_controller.dart';
import 'package:universiting/utils/check_validator.dart';
import 'package:universiting/utils/global_variable.dart';
import 'package:universiting/views/home_view.dart';
import 'package:universiting/views/inquary_finish_view.dart';
import 'package:universiting/widgets/appbar_widget.dart';
import 'package:universiting/widgets/empty_back_textfield_widget.dart';
import 'package:universiting/widgets/loading_widget.dart';
import 'package:universiting/widgets/under_line_textfield_widget.dart';

const List kWithdrawalOptions = [
  '사용하기 불편했어요',
  '필요한 정보를 얻을 수 없었어요',
  '활성화가 잘 안되어있었어요',
  '오류가 많았어요',
  '그 외 다른 사유가 있어요',
];

class WithDrawalView extends StatelessWidget {
  WithDrawalView({Key? key}) : super(key: key);

  RxBool iswithdrawalloading = false.obs;

  List<SelectedOptionWidget> reasonlist = kWithdrawalOptions
      .map((reason) => SelectedOptionWidget(text: reason.toString()))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: '회원탈퇴',
        actions: [
          TextButton(
            onPressed: () {
              TextEditingController pwcontroller = TextEditingController();
              showTextFieldDialog(
                  isWithdrawal: true,
                  title: "현재 비밀번호를 입력해주세요",
                  hintText: "8자리 이상",
                  textEditingController: pwcontroller,
                  obscureText: true,
                  validator: (value) =>
                      CheckValidate().validatePassword(value!),
                  leftFunction: () => Get.back(),
                  rightFunction: () {
                    FocusScope.of(context).unfocus();
                    Get.to(() => const LoadingWidget(), opaque: false);

                    deleteuser(pwcontroller.text, reasonlist)
                        .then((httpresponse) {
                      Get.back();
                      if (httpresponse.isError == false) {
                        const FlutterSecureStorage().delete(key: "token");
                        const FlutterSecureStorage().delete(key: "id");
                        const FlutterSecureStorage().delete(key: "lng");
                        const FlutterSecureStorage().delete(key: "lat");
                        Get.delete<HomeController>(tag: '다음 화면');
                        Get.delete<HomeController>(tag: '첫 화면');
                        Get.delete<ManagementController>();
                        Get.delete<StatusController>();
                        Get.delete<ChatListController>();
                        Get.delete<ProfileController>();
                        Get.delete<MapController>();
                        Get.offAll(() => HomeView(
                              login: false,
                              tag: '첫 화면',
                              lat: 37.563600,
                              lng: 126.962370,
                            ));
                        Get.put(HomeController(), tag: '첫 화면');
                        AppController.to.currentIndex.value = 0;
                      } else {
                        if (httpresponse.errorData!['statusCode'] == 401) {
                          showCustomDialog("비밀번호를 다시 입력해주세요", 1000);
                        } else if (httpresponse.errorData!['statusCode'] ==
                            406) {
                          showCustomDialog(
                              "참여중인 방이 있어요, 방을 나간 후 회원탈퇴를 진행해주세요", 1000);
                        } else {
                          errorSituation(httpresponse);
                        }
                      }
                    });
                  });
            },
            child: Text(
              '탈퇴하기',
              style: k16Medium.copyWith(color: kPrimary),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(32, 24, 32, 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '탈퇴 사유를 선택해주세요',
              style: k16Medium,
            ),
            const SizedBox(
              height: 16,
            ),
            ListView(
              shrinkWrap: true,
              children: reasonlist,
            ),
          ],
        ),
      ),
    );
  }
}

class SelectedOptionWidget extends StatelessWidget {
  SelectedOptionWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;
  RxBool isSelected = false.obs;
  void selectOption() {
    isSelected.value = !isSelected.value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text),
            Obx(
              () => GestureDetector(
                onTap: selectOption,
                child: isSelected.value
                    ? SvgPicture.asset(
                        "assets/icons/check_active.svg",
                        width: 24,
                        height: 24,
                      )
                    : SvgPicture.asset(
                        "assets/icons/check_inactive.svg",
                        width: 24,
                        height: 24,
                      ),
              ),
            ),
          ],
        ),
      ),
      Divider()
    ]);
  }
}
