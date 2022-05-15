import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:universiting/main.dart';

class AdmobController extends GetxController{
  static AdmobController get to => Get.find();
  TargetPlatform os = Theme.of(Get.context!).platform;
  late BannerAd banner;

  @override
  void onInit() {
    banner = BannerAd(
    listener: BannerAdListener(
      onAdFailedToLoad: (Ad ad, LoadAdError error) {},
      onAdLoaded: (_) {},
    ),
    size: AdSize(height: 50, width:  Get.width.round()),
    adUnitId: UNIT_ID[os == TargetPlatform.iOS ? 'ios' : 'android']!,
    request: AdRequest(),
  )..load();
    super.onInit();
  }

  BannerAd getBanner(){
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