import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/participate_controller.dart';
import 'package:universiting/controllers/profile_controller.dart';
import 'package:universiting/controllers/room_info_controller.dart';
import 'package:universiting/controllers/select_member_controller.dart';
import 'package:universiting/models/profile_model.dart';
import 'package:universiting/models/select_member_model.dart';

class SelectedNameWidget extends StatelessWidget {
  SelectedNameWidget(
      {Key? key,
      required this.selectMember,
      required this.roomManager,
      required this.type})
      : super(key: key);
  Profile selectMember;
  AddFriends type;
  bool roomManager;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            decoration: BoxDecoration(
                color: kLightGrey, borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 7, 14, 7),
              child: Row(
                children: [
                  Text(
                    selectMember.nickname,
                    style: k16Medium,
                  ),
                  if (!roomManager) const SizedBox(width: 4),
                  if (!roomManager)
                    GestureDetector(
                        onTap: () {
                          SelectMemberController.to.membersProfile.value =
                              SelectMemberController.to.membersProfile
                                  .where((profile) => profile != selectMember)
                                  .toList();
                        },
                        child: SvgPicture.asset(
                          'assets/icons/delete.svg',
                        ))
                ],
              ),
            )),
        const SizedBox(
          width: 8,
        )
      ],
    );
  }
}
