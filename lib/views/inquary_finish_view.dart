import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/widgets/appbar_widget.dart';

class InquaryFinishView extends StatelessWidget {
  const InquaryFinishView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: '문의',
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              Get.back();
            },
            child: Text(
              '완료',
              style: k16Medium.copyWith(color: kPrimary),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 24, 32, 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  '문의해주셔서 감사합니다',
                  style: k16Medium,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Center(
                child: Text(
                  '최대한 빠르게 답변드리도록 하겠습니다!\n메일 문의 : main@universiting.com',
                  style: kActiveButtonStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
