import 'dart:io';

class AdHelper {

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "<YOUR_ANDROID_BANNER_AD_UNIT_ID";
    } else if (Platform.isIOS) {
      return "<YOUR_IOS_BANNER_AD_UNIT_ID>";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get nativeAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-5195331284911428/6021673162";
    } else if (Platform.isIOS) {
      return "ca-app-pub-5195331284911428/7249874794";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}


// ios': 'ca-app-pub-5195331284911428/7249874794',
//         'android': 'ca-app-pub-5195331284911428/6021673162',