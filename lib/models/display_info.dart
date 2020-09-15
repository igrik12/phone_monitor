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
    this.name = json['name'];
    this.isHrd = json['isHdr'];
    this.density = json['density'];
    this.densityDpi = json['densityDpi'];
    this.heightPixels = json['heightPixels'];
    this.widthPixels = json['widthPixels'];
    this.scaledDensity = json['scaledDensity'];
    this.xdpi = json['xdpi'];
    this.ydpi = json['ydpi'];
    this.refreshRate = json['refreshRate'];
    this.screenSize = calcScreenSize(this);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }

  double calcScreenSize(DisplayInfo displayInfo) {
    double x = pow(displayInfo.widthPixels / displayInfo.xdpi, 2);
    double y = pow(displayInfo.heightPixels / displayInfo.ydpi, 2);
    return double.parse(sqrt(x + y).toStringAsPrecision(2));
  }
}
