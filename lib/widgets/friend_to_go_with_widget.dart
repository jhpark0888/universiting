import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/check_people_controller.dart';
import 'package:universiting/controllers/create_room_controller.dart';
import 'package:universiting/views/select_friends_view.dart';

class FriendToGoWithWidget extends StatelessWidget {
  FriendToGoWithWidget({Key? key, required this.text}) : super(key: key);
  CreateRoomController createRoomController = Get.find();
  int text;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          GestureDetector(
            onTap: (){CheckPeopleController.to.selectPeople(text);
            Get.to(()=>SelectMemberView());
            },
            child: Container(
              child: Icon(Icons.add),
              width: Get.width / 7,
              height: Get.width / 7,
              decoration: BoxDecoration(
                border: Border.all(),
                  borderRadius: BorderRadius.circular(30),
                  color: createRoomController.members.length == text ? kMainBlack.withOpacity(0.38) : kMainWhite),
            ),
          ),
          SizedBox(width: 8)
        ],
      ),
    );
  }
}
