import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:universiting/main.dart';
import 'package:universiting/widgets/loading_widget.dart';

class AdmobController extends GetxController {
  // static AdmobController get to => Get.put(AdmobController());
  TargetPlatform? os;
  late Rx<BannerAd> banners;
  Rx<BannerAd>? anchoredAdaptiveAd;
  final size = AdSize.fullBanner.obs;
  late Rx<AnchoredAdaptiveBannerAdSize?>sizes;
  // AdSize(height: 60, width : Get.width.toInt()).obs;
  // final adSize =AdSize.getInlineAdaptiveBannerAdSize(Get.width.toInt(), 70).obs ;
  Orientation currentOrientation = MediaQuery.of(Get.context!).orientation;
  late Rx<Widget> adWidget;
  RxBool isLoad = false.obs;

  @override
  void onInit() async{
    anchoredAdaptiveAd?.value.dispose();
    await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            MediaQuery.of(Get.context!).size.width.truncate()).then((value) => sizes = value.obs);
    // getAnchorBanner().then((value) => print(anchoredAdaptiveAd?.value.size));
    
    super.onInit();
  }

  BannerAd getBanner() {
    os = Theme.of(Get.context!).platform;
    BannerAd banner = BannerAd(
        size: size.value,
        listener:
            BannerAdListener(onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        }, onAdLoaded: (Ad ad) {
          Future.delayed(Duration(seconds: 2), () {
            isLoad(true);
            print(isLoad.value);
            print('광고는');
          });
        }, onAdClosed: (ad) {
          ad.dispose();
        }),
        adUnitId: UNIT_ID[os == TargetPlatform.iOS ? 'ios' : 'android']!,
        request: AdRequest());
    return banner;
  }

  BannerAd getAnchorBanner()  {
    // anchoredAdaptiveAd?.value.dispose();
    // anchoredAdaptiveAd = null;
    isLoad.value = false;
    // final AnchoredAdaptiveBannerAdSize? size =
    //     await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
    //         MediaQuery.of(Get.context!).size.width.truncate());
    if (sizes.value == null) {
      print('Unable to get height of anchored banner.');
    }
    // sizes = size.obs;
    os = Theme.of(Get.context!).platform;
      print(sizes.value?.width);
    BannerAd anchoredAdaptiveAd = BannerAd(
            size: sizes.value as AdSize,
            listener:
                BannerAdListener(onAdFailedToLoad: (Ad ad, LoadAdError error) {
              ad.dispose();
            }, onAdLoaded: (Ad ad) {
              // anchoredAdaptiveAd!.value = ad as BannerAd;
                isLoad(true);  
            }, onAdClosed: (ad) {
              ad.dispose();
            }),
            adUnitId: UNIT_ID[os == TargetPlatform.iOS ? 'ios' : 'android']!,
            request: AdRequest())
        ;
    return anchoredAdaptiveAd;
  }

  Widget getAdWidget() {
    
    return OrientationBuilder(builder: (context, orientation) {
      if (currentOrientation == orientation && anchoredAdaptiveAd != null && isLoad.value ==true ) {
        return Container(
          color: Colors.transparent,
          width: anchoredAdaptiveAd!.value.size.width.toDouble(),
          height: anchoredAdaptiveAd!.value.size.height.toDouble(),
          child: AdWidget(ad: anchoredAdaptiveAd!.value, key: UniqueKey()),
        );
      }
      if (currentOrientation != orientation) {
        currentOrientation = orientation;
        getAnchorBanner();
      }
      return Container();
    });
  }

  Widget loadingWidget(){
    return Container(
      color: Colors.transparent,
          width: anchoredAdaptiveAd?.value.size.width.toDouble(),
          height: anchoredAdaptiveAd?.value.size.height.toDouble(),
      child: Center(
        child: Image.asset(
          'assets/icons/loading.gif',
          scale: 8,
        ),
      ),
    );
  }
  @override
  void dispose() {
    anchoredAdaptiveAd?.value.dispose();
    super.dispose();
  }
}
