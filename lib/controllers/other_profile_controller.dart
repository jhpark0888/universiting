import 'package:get/get.dart';
import 'package:universiting/api/profile_api.dart';
import 'package:universiting/models/profile_model.dart';

class OtherProfileController extends GetxController{
  String id;
  final otherProfile = Profile(age: 0, gender: '', introduction: '', nickname: '', profileImage: '', userId: 0).obs;
  OtherProfileController({required this.id});

  @override
  void onInit() async{
    print(id);
    otherProfile.value = await getOtherProfile(id);
    super.onInit();
  }
}