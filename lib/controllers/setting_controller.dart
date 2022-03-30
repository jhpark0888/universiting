import 'package:get/get.dart';
import 'package:universiting/controllers/app_controller.dart';

class SettingController extends GetxController{
  @override
  void onInit() {
    AppController.to.addPage();
    super.onInit();
  }

  @override
  void onClose() {
    AppController.to.deletePage();
    super.onClose();
  }
}