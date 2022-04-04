import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/check_people_controller.dart';
import 'package:universiting/controllers/room_info_controller.dart';
import 'package:universiting/controllers/participate_controller.dart';
import 'package:universiting/views/select_friend_view.dart';

class FriendToGoWithWidget extends StatelessWidget {
  FriendToGoWithWidget(
      {Key? key,
      required this.text,
      required this.humanNum,
      required this.type})
      : super(key: key);
  int text;
  int humanNum;
  AddFriends type;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          GestureDetector(
            onTap: () {
              Get.to(() => SelectFriendView(text: text + 2,type: type));
              print('$humanNum입니다');
              print('$text입니다');
            },
            child: Container(
              child: type == AddFriends.myRoom
                      ? RoomInfoController.to.members != []
                          ? RoomInfoController.to.members.length == humanNum
                              ? ClipOval(
                                child: RoomInfoController.to.memberProfile[humanNum-1].profileImage != '' ?CachedNetworkImage(
                                  imageUrl : RoomInfoController.to.memberProfile[humanNum-1].profileImage,
                                  width: 48,
                                  height: 48,
                                  fit: BoxFit.cover,
                                ) : SvgPicture.asset(
                                'assets/illustrations/default_profile.svg',
                                height:  48,
                                width:  48,
                                fit: BoxFit.cover,
                              ),
                              )
                              //  Text(RoomInfoController.to.memberProfile[humanNum-1].age.toString())
                              : const Icon(Icons.add)
                          : const Icon(Icons.add)
                      : ParticipateController.to.members != []
                      ? ParticipateController.to.members.length >= humanNum
                      ? ClipOval(
                                child: ParticipateController.to.memberProfile[humanNum-1].profileImage != '' ?CachedNetworkImage(
                                  imageUrl : ParticipateController .to.memberProfile[humanNum-1].profileImage,
                                  width: 48,
                                  height: 48,
                                  fit: BoxFit.cover,
                                ) : SvgPicture.asset(
                                'assets/illustrations/default_profile.svg',
                                height:  48,
                                width:  48,
                                fit: BoxFit.cover,
                              ),
                              ):const Icon(Icons.add) : const Icon(Icons.add),
              width: Get.width / 7,
              height: Get.width / 7,
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(30),
                  color: type == AddFriends.myRoom
                      ? RoomInfoController.to.members != []
                          ? RoomInfoController.to.members.length >= humanNum
                              ? kMainBlack.withOpacity(0.38)
                              : kMainWhite
                          : kMainWhite
                      : ParticipateController.to.members != []
                      ? ParticipateController.to.members.length >= humanNum
                      ? kMainBlack.withOpacity(0.38):kMainWhite : kMainWhite),
            )
          ),
          const SizedBox(width: 8)
        ],
      ),
    );
  }
}
