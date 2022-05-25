import 'package:get/get.dart';
import 'package:universiting/constant.dart';
import 'package:universiting/controllers/admob_controller.dart';
import 'package:universiting/controllers/app_controller.dart';
import 'package:universiting/models/profile_model.dart';

import '../api/profile_api.dart';

class OtherProfileController extends GetxController {
  AdmobController controller = Get.put(AdmobController(), tag: 'otherProfile');
  String id;
  Rx<Screenstate> screenstate = Screenstate.loading.obs;
  final otherProfile = Profile(
          age: 0,
          gender: '',
          introduction: '',
          nickname: '',
          profileImage: '',
          university: '',
          department: '',
          userId: 0)
      .obs;
  OtherProfileController({required this.id});
  
  @override
  void onInit() async {
    AppController.to.addPage();
    print(AppController.to.stackPage);
    await getOtherProfile(id).then((httpresponse){
    if (httpresponse.isError == false) {
        otherProfile.value = httpresponse.data;
        AppController.to.addPage();
        print(AppController.to.stackPage);
        screenstate(Screenstate.success);
        print(screenstate.value);
      } else {
        if (httpresponse.errorData!['statusCode'] == 59) {
          screenstate(Screenstate.network);
        } else {
          screenstate(Screenstate.error);
        }
      }});
    super.onInit();
  }

  @override
  void onClose() {
    AppController.to.deletePage();
    print(AppController.to.stackPage);
    super.onClose();
  }
}
