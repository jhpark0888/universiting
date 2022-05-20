import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:universiting/main.dart';

class AdmobController extends GetxController {
  static AdmobController get to => Get.find();
  TargetPlatform? os;
  late Rx<BannerAd> banners;
  final size = AdSize.banner.obs;
  final adSize =AdSize.getInlineAdaptiveBannerAdSize(Get.width.toInt(), 70).obs ;
  RxBool isLoad = false.obs;
  
  void oninit(){
    
  print(adSize);
  super.onInit();
  }

  BannerAd getBanner() {
    os = Theme.of(Get.context!).platform;
    BannerAd banner = BannerAd(
      size : AdSize.banner,
      listener: BannerAdListener(
        onAdFailedToLoad: (Ad ad, LoadAdError error) {ad.dispose();},
        onAdLoaded: (Ad ad) {}
      ),
      adUnitId: UNIT_ID[os == TargetPlatform.iOS ? 'ios' : 'android']!,
      request: AdRequest()
    );
    return banner;
  }
}
