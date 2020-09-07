import 'dart:io';

class AdManager {
  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-8553583576390987~6421066446";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-8553583576390987/4063508172";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
