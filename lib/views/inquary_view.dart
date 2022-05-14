import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/inquary_controller.dart';
import 'package:universiting/views/inquary_finish_view.dart';
import 'package:universiting/widgets/appbar_widget.dart';
import 'package:universiting/widgets/empty_back_textfield_widget.dart';
import 'package:universiting/widgets/under_line_textfield_widget.dart';

class InquaryView extends StatelessWidget {
  InquaryView({ Key? key }) : super(key: key);
  InquaryController controller = Get.put(InquaryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: '문의',
        actions: [
          TextButton(
            onPressed: () {
              Get.to(() => InquaryFinishView());
            },
            child: Text(
              '보내기',
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
              '답변 받으실 이메일 주소',
              style: k16Medium,
            ),
            const SizedBox(
              height: 16,
            ),
            UnderLineTexField(counterText: null,
              maxLength: null,
              textController: controller.emailController,
              hintText: '이메일 주소',
              validator: null,
              obscureText: false,
              maxLines: 5),
            SizedBox(
              height: 32,
            ),
            Text(
              '문의 내용',
              style: k16Medium,
            ),
            SizedBox(
              height: 16,
            ),
            UnderLineTexField(counterText: null,
              maxLength: null,
              textController: controller.contentcontroller,
              hintText: '문의 내용',
              validator: null,
              obscureText: false,
              maxLines: 12,),
          ],
        ),
      ),
    );
  }
}