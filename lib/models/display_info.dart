import 'dart:math';

class DisplayInfo {
  String name;
  int heightPixels;
  int widthPixels;
  double density;
  int densityDpi;
  double refreshRate;
  double screenSize;
  double scaledDensity;
  double xdpi;
  double ydpi;
  bool isHrd;

  DisplayInfo();

  DisplayInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isHrd = json['isHdr'];
    density = json['density'];
    densityDpi = json['densityDpi'];
    heightPixels = json['heightPixels'];
    widthPixels = json['widthPixels'];
    scaledDensity = json['scaledDensity'];
    xdpi = json['xdpi'];
    ydpi = json['ydpi'];
    refreshRate = json['refreshRate'];
    screenSize = calcScreenSize(this);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    return data;
  }

  double calcScreenSize(DisplayInfo displayInfo) {
    double x = pow(displayInfo.widthPixels / displayInfo.xdpi, 2);
    double y = pow(displayInfo.heightPixels / displayInfo.ydpi, 2);
    return double.parse(sqrt(x + y).toStringAsPrecision(2));
  }
}
