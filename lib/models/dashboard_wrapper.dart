import 'package:battery_info/model/android_battery_info.dart';
import 'package:phone_monitor/models/display_info.dart';

class DashboardInfoWrapper {
  int totalRamUsage;
  DisplayInfo display = DisplayInfo();
  AndroidBatteryInfo battery = AndroidBatteryInfo()
    ..batteryLevel = 0
    ..voltage = -1;
  int diskSpaceUsedInPersent;
  double diskSpaceUsed;
  double totalSpaceAvailable;
  double totalDiskSpaceAvailable;
}
