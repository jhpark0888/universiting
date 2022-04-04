import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/participate_controller.dart';
import 'package:universiting/controllers/room_info_controller.dart';
import 'package:universiting/models/profile_model.dart';
import 'package:universiting/models/select_member_model.dart';

class SelectedNameWidget extends StatelessWidget {
  SelectedNameWidget({Key? key, required this.selectMember, required this.roomManager, required this.type})
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
                    style: kInActiveButtonStyle,
                  ),
                  if (!roomManager) const SizedBox(width: 4),
                  if (!roomManager)
                    GestureDetector(
                        onTap: () {
                          if(type == AddFriends.myRoom){
                          RoomInfoController.to.seletedMembers.value =
                              RoomInfoController.to.seletedMembers
                                  .where((element) => element.selectMember != selectMember)
                                  .toList();
                          RoomInfoController.to.members.value = RoomInfoController.to.members.where((id) => id != selectMember.userId).toList();        
                          }else{
                            {
                          ParticipateController.to.selectedMembers.value =
                              ParticipateController.to.selectedMembers
                                  .where((element) => element.selectMember != selectMember)
                                  .toList();
                          ParticipateController.to.members.value = ParticipateController.to.members.where((id) => id != selectMember.userId).toList();        
                          }
                          }
       
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
