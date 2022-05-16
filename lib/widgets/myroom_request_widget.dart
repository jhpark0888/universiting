import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/models/myroom_request_model.dart';
import 'package:universiting/views/myroom_request_detail_view.dart';
import 'package:universiting/widgets/button_widget.dart';
import 'package:universiting/widgets/profile_image_widget.dart';
import 'package:universiting/widgets/room_info_widget.dart';
import 'package:universiting/widgets/scroll_noneffect_widget.dart';

class MyroomRequestWidget extends StatelessWidget {
  MyroomRequestWidget(
      {Key? key,
      required this.request,
      required this.isrequestinfo,
      required this.roomId,
      this.width,
      this.isbottompadding})
      : super(key: key);

  MyRoomRequest request;
  bool isrequestinfo;
  int roomId;
  double? width;
  bool? isbottompadding;

  void onTap() {
    Get.to(() => MyRoomRequestDetailView(
          roomId: roomId,
          request: request,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          isbottompadding == true ? const EdgeInsets.only(bottom: 10) : null,
      child: InkWell(
        onTap: onTap,
        splashColor: kSplashColor,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: width,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: kCardColor.withOpacity(0.3),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  height: 50,
                  child: ScrollNoneffectWidget(
                    child: ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => ProfileImageWidget(
                              type: ViewType.statusSendView,
                              width: 50,
                              height: 50,
                              host: request.members![index],
                            ),
                        separatorBuilder: (context, index) => const SizedBox(
                              width: 8,
                            ),
                        itemCount: request.members!.length),
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              isrequestinfo == true
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          request.joinInfo.introduction,
                          style: k16Medium.copyWith(height: 1.5),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        RoomInfoWidget(
                          avgAge: request.joinInfo.age!,
                          mypersonnum: request.members!.length,
                          yourpersonnum: request.members!.length,
                          gender: request.joinInfo.gender,
                          univ: request.joinInfo.uni,
                        )
                      ],
                    )
                  : Text(
                      request.joinInfo.uni!,
                      style: k16Medium,
                    ),
              const SizedBox(
                height: 18,
              ),
              GestureDetector(
                  onTap: onTap,
                  child: PrimaryButton(
                      height: 42,
                      width: 148,
                      text: '신청 확인하기',
                      isactive: true.obs))
            ],
          ),
        ),
      ),
    );
  }
}
