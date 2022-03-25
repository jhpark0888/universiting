import 'package:flutter/material.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/models/chat_list_model.dart';
import 'package:universiting/widgets/profile_image_widget.dart';

class ChatRoomWidget extends StatelessWidget {
  ChatRoomWidget({Key? key, required this.chatRoom, required this.imageList})
      : super(key: key);
  ChatRoom chatRoom;
  List<ProfileImageWidget> imageList;
  @override
  Widget build(BuildContext context) {
    print(imageList);
    return Container(
      decoration: BoxDecoration(
          color: kMainBlack, borderRadius: BorderRadius.circular(28)),
      child: Row(
        children: [
          Column(
            children: [imageList[0], imageList[1],Row(children: [imageList[2], imageList[3]],)],
            
          )
        ],
      ),
    );
  }
}
