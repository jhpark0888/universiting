import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:universiting/main.dart';

class AdmobController extends GetxController {
  static AdmobController get to => Get.find();
  TargetPlatform? os;
  late BannerAd banner;

  BannerAd getBanner() {
    os = Theme.of(Get.context!).platform;
    BannerAd banner = BannerAd(
      listener: BannerAdListener(
        onAdFailedToLoad: (Ad ad, LoadAdError error) {},
        onAdLoaded: (_) {},
      ),
      size: AdSize(height: 40, width: Get.width.round()),
      adUnitId: UNIT_ID[os == TargetPlatform.iOS ? 'ios' : 'android']!,
      request: AdRequest(),
    );
    return banner;
  }
}
