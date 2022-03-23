import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/api/profile_api.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/profile_controller.dart';
import 'package:universiting/widgets/appbar_widget.dart';
import 'package:universiting/widgets/button_widget.dart';
import 'package:universiting/widgets/custom_button_widget.dart';
import 'package:universiting/widgets/empty_back_textfield_widget.dart';

import '../widgets/background_textfield_widget.dart';

class ProfileUpdate extends StatelessWidget {
  ProfileUpdate({Key? key}) : super(key: key);
  ProfileController profileController = Get.find();
  //image, profile
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: '프로필 수정'),
      backgroundColor: kMainWhite,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('이름 또는 닉네임', style: kSubtitleStyle2),
              const SizedBox(height: 12),
              BackgroundTextfieldWidget(
                controller: profileController.nameController,
                hinttext: '최대 8자',
              ),
              const SizedBox(height: 24),
              const Text('학과', style: kSubtitleStyle2),
              const SizedBox(height: 12),
              BackgroundTextfieldWidget(controller: profileController.departmentController, hinttext: 'SELECT'),
              const SizedBox(height: 24),
              Text('간단한 소개', style: kSubtitleStyle2),
              const SizedBox(height: 12),
              BackgroundTextfieldWidget(
                controller: profileController.introController,
                hinttext: '간단하게 자신을 소개해주세요',
              ),
              const SizedBox(height: 24),
              CustomButtonWidget(
                buttonTitle: '저장하기',
                buttonState: ButtonState.primary,
                onTap: () {
                  updateMyProfile(ProfileType.profile, File(''));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
