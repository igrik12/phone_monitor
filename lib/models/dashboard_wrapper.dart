import 'package:phone_monitor/models/battery_info.dart';
import 'package:phone_monitor/models/display_info.dart';

class DashboardInfoWrapper {
  int totalRamUsage;
  BatteryInfo battery;
  DisplayInfo display;
  int diskSpaceUsedInPersent;
  double diskSpaceUsed;
  double totalSpaceAvailable;
  double totalDiskSpaceAvailable;
}
