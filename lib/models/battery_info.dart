class BatteryInfo {
  int batteryLevel = 0;
  int healthy = 0;
  int dead;
  int pluggedUsb;
  int pluggedAc;
  int pluggedWireless;
  int currentNow;
  int voltage;
  int temperature;
  int health;
  int plugged;
  int chargeTimeRemaining;
  int currentAverage;
  bool isCharging;
  bool batteryFull;

  BatteryInfo(
      {batteryLevel = 100,
      health,
      healthy,
      dead,
      plugged,
      pluggedUsb,
      pluggedAc,
      pluggedWireless,
      currentNow,
      voltage,
      temperature,
      chargeTimeRemaining,
      currentAverage,
      isCharging = false,
      batteryFull});

  BatteryInfo.fromJson(Map<String, dynamic> json) {
    this.batteryLevel = json["batteryLevel"];
    this.healthy = json["healthy"];
    this.health = json["health"];
    this.dead = json["dead"];
    this.plugged = json["plugged"];
    this.pluggedUsb = json["pluggedUsb"];
    this.pluggedAc = json["pluggedAc"];
    this.pluggedWireless = json["pluggedWireless"];
    this.currentNow = json["currentNow"];
    this.voltage = json["voltage"];
    this.temperature = json["temperature"];
    this.isCharging = json["charging"];
    this.batteryFull = json["batteryFull"];
    this.chargeTimeRemaining = json["chargeTimeRemaining"] ~/ (1000 * 60);
    this.currentAverage = json["currentAverage"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}
