import 'dart:async';

import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';

class KeyboardController extends GetxController {
  late StreamSubscription<bool> keyboardSubscription;
  RxBool isVisible = false.obs;
  @override
  void onInit() {
    super.onInit();
    var keyboardVisibilityController = KeyboardVisibilityController();
    // Query
    print(
        'Keyboard visibility direct query: ${keyboardVisibilityController.isVisible}');

    // Subscribe
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      print('Keyboard visibility update. Is visible: $visible');
      isVisible.value = visible;
    });
  }

  @override
  void onClose() {
    keyboardSubscription.cancel();
    super.onClose();
  }
}
