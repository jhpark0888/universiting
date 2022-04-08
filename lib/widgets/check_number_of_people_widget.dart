import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/check_people_controller.dart';
import 'package:universiting/widgets/button_widget.dart';

class CheckNumberOfPeopleWidget extends StatelessWidget {
  CheckNumberOfPeopleWidget({Key? key, required this.text}) : super(key: key);
  CheckPeopleController checkPeopleController =
      Get.put(CheckPeopleController(type: AddFriends.myRoom));
  int text;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          GestureDetector(
              onTap: () {
                checkPeopleController.changeColor(text);
                checkPeopleController.selectPeople(text);
              },
              child: PrimaryButton(
                text: '${text.toString()}명',
                width: Get.width / 6,
                backColor: checkPeopleController.backColors[text - 2],
                textColor: checkPeopleController.textColors[text - 2],
              )),
          SizedBox(width: 12)
        ],
      ),
    );
  }
}
