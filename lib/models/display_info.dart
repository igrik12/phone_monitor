import 'dart:math';

class DisplayInfo {
  int density;
  int densityDpi;
  int heightPixels;
  int widthPixels;
  double screenSize;
  double scaledDensity;
  double xdpi;
  double ydpi;

  DisplayInfo();

  DisplayInfo.fromJson(Map<String, dynamic> json) {
    this.density = json['id'];
    this.densityDpi = json['densityDpi'];
    this.heightPixels = json['heightPixels'];
    this.widthPixels = json['widthPixels'];
    this.scaledDensity = json['scaledDensity'];
    this.xdpi = json['xdpi'];
    this.ydpi = json['ydpi'];
    this.screenSize = calcScreenSize(this);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['density'] = this.density;
    return data;
  }

  double calcScreenSize(DisplayInfo displayInfo) {
    double x = pow(displayInfo.widthPixels / displayInfo.xdpi, 2);
    double y = pow(displayInfo.heightPixels / displayInfo.ydpi, 2);
    return double.parse(sqrt(x + y).toStringAsPrecision(2));
  }
}
