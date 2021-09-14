import 'package:flutter/material.dart';
import 'package:phone_monitor/widgets/custom_card.dart';

class SensorInfoHolder {
  SensorInfoHolder(
      this.name,
      this.type,
      this.vendorName,
      this.version,
      this.power,
      this.resolution,
      this.maxRange,
      this.maxDelay,
      this.minDelay,
      this.reportingMode,
      this.isWakeup,
      this.isDynamic,
      this.highestDirectReportRateValue,
      this.fifoMaxEventCount,
      this.fifoReservedEventCount) {
    type = '${_getTypeToName(type)} ($type)';
  }
  String name;
  String type;
  String vendorName;
  String version;
  String power;
  String resolution;
  String maxRange;
  String maxDelay;
  String minDelay;
  String reportingMode;
  String isWakeup;
  String isDynamic;
  String highestDirectReportRateValue;
  String fifoMaxEventCount;
  String fifoReservedEventCount;
  String _getTypeToName(String type) {
    return <String, String>{
      '1': 'Accelerometer',
      '35': 'Uncalibrated Accelerometer',
      '9': 'Gravity',
      '10': 'Linear Acceleration',
      '2': 'Magnetic Field',
      '3': 'Orientation',
      '4': 'Gyroscope',
      '16': 'Uncalibrated Gyroscope',
      '31': 'Heeat Beat',
      '5': 'Ambient Light',
      '6': 'Atmospheric Pressure',
      '8': 'Proximity',
      '11': 'Rotation Vector',
      '15': 'Game Rotation Vector',
      '20': 'Geo Magnetic Rotaion Vector',
      '12': 'Relative Humidity',
      '13': 'Ambient Room Temperature',
      '29': 'Stationary Detect',
      '30': 'Motion Detect',
      '34': 'Low Latency Off Body Detect',
    }[type];
  }

  List<Widget> displaySensorData() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            name,
            style: const TextStyle(
                color: Colors.blue, fontStyle: FontStyle.italic),
          ),
          Text(
            vendorName,
            style: TextStyle(
                color: Colors.greenAccent[400], fontWeight: FontWeight.bold),
          )
        ],
      ),
      const Divider(
        height: 14.0,
        color: Colors.black54,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text(
            'Type',
          ),
          Text(
            type,
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text(
            'Version',
          ),
          Text(
            version,
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text(
            'Power',
          ),
          Text(
            '$power mA',
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text(
            'Resolution',
          ),
          Text(
            '$resolution unit',
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text(
            'Maximum Range',
          ),
          Text(
            '$maxRange unit',
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text(
            'Maximum Delay',
          ),
          Text(
            '$maxDelay s',
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text(
            'Minimum Delay',
          ),
          Text(
            '$minDelay s',
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text(
            'Reporting Mode',
          ),
          Text(
            <String, String>{
              '0': 'Continuous',
              '1': 'On Change',
              '2': 'One Shot',
              '3': 'Special Trigger',
              'NA': 'NA',
            }[reportingMode],
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text(
            'Wake Up',
          ),
          Text(
            capitalize(isWakeup),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text(
            'Dynamic',
          ),
          Text(
            capitalize(isDynamic),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text(
            'Highest Direct Report Rate Value',
          ),
          Text(
            <String, String>{
              '0': 'Unsupported',
              '1': 'Normal',
              '2': 'Fast',
              '3': 'Very Fast',
              'NA': 'NA',
            }[highestDirectReportRateValue],
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text(
            'Fifo Max Event Count',
          ),
          Text(
            fifoMaxEventCount,
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text(
            'Fifo Reserved Event Count',
          ),
          Text(
            fifoReservedEventCount,
          ),
        ],
      )
    ];
  }

  List<Widget> appendThem(List<Widget> myList) {
    List<Widget> target = displaySensorData();
    for (var element in myList) {
      target.add(element);
    }
    return target;
  }

  String capitalize(String str) {
    return str.replaceFirst(str[0], str[0].toUpperCase());
  }
}

class Accelerometer {
  // type 1
  Accelerometer(this.sensor, this.x, this.y, this.z);
  SensorInfoHolder sensor;
  String x;
  String y;
  String z;
  Widget getCard() {
    return CustomCard(
      // Accelerometer

      child: Container(
        child: Column(
          children: sensor.appendThem([
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Along X-axis'),
                Text('$x m/s^2'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Along Y-axis'),
                Text('$y m/s^2'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Along Z-axis'),
                Text('$z m/s^2'),
              ],
            )
          ]),
        ),
        padding: const EdgeInsets.only(
            left: 10.0, right: 10.0, top: 12.0, bottom: 12.0),
      ),
    );
  }
}

class UncalibratedAccelerometer {
  // type 35
  UncalibratedAccelerometer(
      this.sensor,
      this.xUncalib,
      this.yUncalib,
      this.zUnclaib,
      this.estimatedXBias,
      this.estimatedYBias,
      this.estimatedZBias);
  SensorInfoHolder sensor;
  String xUncalib;
  String yUncalib;
  String zUnclaib;
  String estimatedXBias;
  String estimatedYBias;
  String estimatedZBias;
  Widget getCard() {
    return CustomCard(
      // Uncalibrated Accelerometer

      child: Container(
        child: Column(
          children: sensor.appendThem([
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('X Uncalibrated'),
                Text('$xUncalib m/s^2'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Y Uncalibrated'),
                Text('$yUncalib m/s^2'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Z Uncalibrated'),
                Text('$zUnclaib m/s^2'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Estimated X Bias'),
                Text('$estimatedXBias m/s^2'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Estimated Y Bias'),
                Text('$estimatedYBias m/s^2'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Estimated Z Bias'),
                Text('$estimatedZBias m/s^2'),
              ],
            ),
          ]),
        ),
        padding: const EdgeInsets.only(
            left: 10.0, right: 10.0, top: 12.0, bottom: 12.0),
      ),
    );
  }
}

class Gravity {
  // type 9
  Gravity(this.sensor, this.x, this.y, this.z);
  SensorInfoHolder sensor;
  String x;
  String y;
  String z;
  Widget getCard() {
    return CustomCard(
      // Gravity

      child: Container(
        child: Column(
          children: sensor.appendThem([
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Along X-axis'),
                Text('$x m/s^2'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Along Y-axis'),
                Text('$y m/s^2'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Along Z-axis'),
                Text('$z m/s^2'),
              ],
            ),
          ]),
        ),
        padding: const EdgeInsets.only(
            left: 10.0, right: 10.0, top: 12.0, bottom: 12.0),
      ),
    );
  }
}

class LinearAcceleration {
  // type 10
  LinearAcceleration(this.sensor, this.x, this.y, this.z);
  SensorInfoHolder sensor;
  String x;
  String y;
  String z;
  Widget getCard() {
    return CustomCard(
      // Linear Acceleration

      child: Container(
        child: Column(
          children: sensor.appendThem([
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Along X-axis'),
                Text('$x m/s^2'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Along Y-axis'),
                Text('$y m/s^2'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Along Z-axis'),
                Text('$z m/s^2'),
              ],
            ),
          ]),
        ),
        padding: const EdgeInsets.only(
            left: 10.0, right: 10.0, top: 12.0, bottom: 12.0),
      ),
    );
  }
}

class MagneticField {
  // type 2
  MagneticField(this.sensor, this.x, this.y, this.z);
  SensorInfoHolder sensor;
  String x;
  String y;
  String z;
  Widget getCard() {
    return CustomCard(
      // Magnetic Field
      child: Container(
        child: Column(
          children: sensor.appendThem([
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Along X-axis'),
                Text('$x uT'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Along Y-axis'),
                Text('$y uT'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Along Z-axis'),
                Text('$z uT'),
              ],
            ),
          ]),
        ),
        padding: const EdgeInsets.only(
            left: 10.0, right: 10.0, top: 12.0, bottom: 12.0),
      ),
    );
  }
}

class OrientationSensor {
  // type 3
  OrientationSensor(this.sensor, this.azimuth, this.pitch, this.roll);
  SensorInfoHolder sensor;
  String azimuth;
  String pitch;
  String roll;
  Widget getCard() {
    return CustomCard(
      // Orientation Sensor

      child: Container(
        child: Column(
          children: sensor.appendThem([
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Azimuth'),
                Text(azimuth),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Pitch'),
                Text(pitch),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Roll'),
                Text(roll),
              ],
            ),
          ]),
        ),
        padding:
            EdgeInsets.only(left: 10.0, right: 10.0, top: 12.0, bottom: 12.0),
      ),
    );
  }
}

class Gyroscope {
  // type 4
  Gyroscope(this.sensor, this.angularSpeedAroundX, this.angularSpeedAroundY,
      this.angularSpeedAroundZ);
  SensorInfoHolder sensor;
  String angularSpeedAroundX;
  String angularSpeedAroundY;
  String angularSpeedAroundZ;
  Widget getCard() {
    return CustomCard(
      // Gyroscope

      child: Container(
        child: Column(
          children: sensor.appendThem([
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Angular Speed around X'),
                Text('$angularSpeedAroundX rad/s'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Angular Speed around Y'),
                Text('$angularSpeedAroundY rad/s'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Angular Speed around Z'),
                Text('$angularSpeedAroundZ rad/s'),
              ],
            ),
          ]),
        ),
        padding:
            EdgeInsets.only(left: 10.0, right: 10.0, top: 12.0, bottom: 12.0),
      ),
    );
  }
}

class UncalibratedGyroscope {
  // type 16
  UncalibratedGyroscope(
      this.sensor,
      this.angularSpeedAroundX,
      this.angularSpeedAroundY,
      this.angularSpeedAroundZ,
      this.estimatedDriftAroundX,
      this.estimatedDriftAroundY,
      this.estimatedDriftAroundZ);
  SensorInfoHolder sensor;
  String angularSpeedAroundX;
  String angularSpeedAroundY;
  String angularSpeedAroundZ;
  String estimatedDriftAroundX;
  String estimatedDriftAroundY;
  String estimatedDriftAroundZ;
  Widget getCard() {
    return CustomCard(
      // Uncalibrated Gyroscope

      child: Container(
        child: Column(
          children: sensor.appendThem([
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Angular Speed around X'),
                Text('$angularSpeedAroundX rad/s'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Angular Speed around Y'),
                Text('$angularSpeedAroundY rad/s'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Angular Speed around Z'),
                Text('$angularSpeedAroundZ rad/s'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Estimated Drift around X'),
                Text('$estimatedDriftAroundX rad/s'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Estimated Drift around Y'),
                Text('$estimatedDriftAroundY rad/s'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Estimated Drift around Z'),
                Text('$estimatedDriftAroundZ rad/s'),
              ],
            ),
          ]),
        ),
        padding:
            EdgeInsets.only(left: 10.0, right: 10.0, top: 12.0, bottom: 12.0),
      ),
    );
  }
}

class HeartBeat {
  // type 31
  HeartBeat(this.sensor, this.confidence);
  SensorInfoHolder sensor;
  String confidence;
  Widget getCard() {
    return CustomCard(
      // HeartBeat Sensor

      child: Container(
        child: Column(
          children: sensor.appendThem([
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Confidence'),
                Text(confidence),
              ],
            ),
          ]),
        ),
        padding:
            EdgeInsets.only(left: 10.0, right: 10.0, top: 12.0, bottom: 12.0),
      ),
    );
  }
}

class AmbientLight {
  // type 5
  AmbientLight(this.sensor, this.level);
  SensorInfoHolder sensor;
  String level;
  Widget getCard() {
    return CustomCard(
      // Ambient Light Sensor

      child: Container(
        child: Column(
          children: sensor.appendThem([
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Ambient Light Level'),
                Text('$level lux'),
              ],
            ),
          ]),
        ),
        padding:
            EdgeInsets.only(left: 10.0, right: 10.0, top: 12.0, bottom: 12.0),
      ),
    );
  }
}

class AtmosphericPressure {
  // type 6
  AtmosphericPressure(this.sensor, this.pressure);
  SensorInfoHolder sensor;
  String pressure;
  Widget getCard() {
    return CustomCard(
      // Atmospheric Pressure

      child: Container(
        child: Column(
          children: sensor.appendThem([
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Atmospheric Pressure'),
                Text('$pressure hPa'),
              ],
            ),
          ]),
        ),
        padding:
            EdgeInsets.only(left: 10.0, right: 10.0, top: 12.0, bottom: 12.0),
      ),
    );
  }
}

class Proximity {
  // type 8
  Proximity(this.sensor, this.distance);
  SensorInfoHolder sensor;
  String distance;
  Widget getCard() {
    return CustomCard(
      // Proximity Sensor

      child: Container(
        child: Column(
          children: sensor.appendThem([
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Distance From Screen'),
                Text('$distance cm'),
              ],
            ),
          ]),
        ),
        padding:
            EdgeInsets.only(left: 10.0, right: 10.0, top: 12.0, bottom: 12.0),
      ),
    );
  }
}

class RotationVector {
  // type 11
  RotationVector(this.sensor, this.x, this.y, this.z, this.someVal,
      this.estimatedHeadingAccuracy);
  SensorInfoHolder sensor;
  String x;
  String y;
  String z;
  String someVal;
  String estimatedHeadingAccuracy;
  Widget getCard() {
    return CustomCard(
      // Rotation Vector Sensor

      child: Container(
        child: Column(
          children: sensor.appendThem([
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('X * Sin(\u{03b8}/2)'),
                Text(x),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Y * Sin(\u{03b8}/2)'),
                Text(y),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Z * Sin(\u{03b8}/2)'),
                Text(z),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Cos(\u{03b8}/2)'),
                Text(someVal),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Estimated Heading Accuracy'),
                Text('$estimatedHeadingAccuracy rad'),
              ],
            ),
          ]),
        ),
        padding:
            EdgeInsets.only(left: 10.0, right: 10.0, top: 12.0, bottom: 12.0),
      ),
    );
  }
}

class GameRotationVector {
  // type 15
  GameRotationVector(this.sensor, this.x, this.y, this.z, this.someVal,
      this.estimatedHeadingAccuracy);
  SensorInfoHolder sensor;
  String x;
  String y;
  String z;
  String someVal;
  String estimatedHeadingAccuracy;
  Widget getCard() {
    return CustomCard(
      // Game Rotation Vector Sensor

      child: Container(
        child: Column(
          children: sensor.appendThem([
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('X * Sin(\u{03b8}/2)'),
                Text(x),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Y * Sin(\u{03b8}/2)'),
                Text(y),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Z * Sin(\u{03b8}/2)'),
                Text(z),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Cos(\u{03b8}/2)'),
                Text(someVal),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Estimated Heading Accuracy'),
                Text('$estimatedHeadingAccuracy rad'),
              ],
            ),
          ]),
        ),
        padding:
            EdgeInsets.only(left: 10.0, right: 10.0, top: 12.0, bottom: 12.0),
      ),
    );
  }
}

class GeoMagneticRotationVector {
  // type 20
  GeoMagneticRotationVector(this.sensor, this.x, this.y, this.z, this.someVal,
      this.estimatedHeadingAccuracy);
  SensorInfoHolder sensor;
  String x;
  String y;
  String z;
  String someVal;
  String estimatedHeadingAccuracy;
  Widget getCard() {
    return CustomCard(
      // Geomagnetic Rotation Vector Sensor

      child: Container(
        child: Column(
          children: sensor.appendThem([
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('X * Sin(\u{03b8}/2)'),
                Text(x),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Y * Sin(\u{03b8}/2)'),
                Text(y),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Z * Sin(\u{03b8}/2)'),
                Text(z),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Cos(\u{03b8}/2)'),
                Text(someVal),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Estimated Heading Accuracy'),
                Text('$estimatedHeadingAccuracy rad'),
              ],
            ),
          ]),
        ),
        padding:
            EdgeInsets.only(left: 10.0, right: 10.0, top: 12.0, bottom: 12.0),
      ),
    );
  }
}

class RelativeHumidity {
  // type 12
  RelativeHumidity(this.sensor, this.humidity);
  SensorInfoHolder sensor;
  String humidity;
  Widget getCard() {
    return CustomCard(
      // Relative Humidity

      child: Container(
        child: Column(
          children: sensor.appendThem([
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Relative Air Humidity'),
                Text('$humidity %'),
              ],
            ),
          ]),
        ),
        padding:
            EdgeInsets.only(left: 10.0, right: 10.0, top: 12.0, bottom: 12.0),
      ),
    );
  }
}

class AmbientRoomTemperature {
  // type 13
  AmbientRoomTemperature(this.sensor, this.temperature);
  SensorInfoHolder sensor;
  String temperature;
  Widget getCard() {
    return CustomCard(
      // Gravity

      child: Container(
        child: Column(
          children: sensor.appendThem([
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Temperature'),
                Text('$temperature C'),
              ],
            ),
          ]),
        ),
        padding:
            EdgeInsets.only(left: 10.0, right: 10.0, top: 12.0, bottom: 12.0),
      ),
    );
  }
}

class LowLatencyOffBodyDetect {
  // type 34
  LowLatencyOffBodyDetect(this.sensor, this.offBodyState);
  SensorInfoHolder sensor;
  String offBodyState;

  String getStateText() {
    return offBodyState == '1.0' ? 'Device on-body' : 'Device off-body';
  }

  Widget getCard() {
    return CustomCard(
      // Low latency off body detect sensor

      child: Container(
        child: Column(
          children: sensor.appendThem([
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Off Body State'),
                Text(getStateText()),
              ],
            ),
          ]),
        ),
        padding:
            EdgeInsets.only(left: 10.0, right: 10.0, top: 12.0, bottom: 12.0),
      ),
    );
  }
}

SensorInfoHolder getMeAnInstanceOfSensorInfoHolder(Map<String, String> data) {
  return SensorInfoHolder(
      data['name'],
      data['type'],
      data['vendorName'],
      data['version'],
      data['power'],
      data['resolution'],
      data['maxRange'],
      data['maxDelay'],
      data['minDelay'],
      data['reportingMode'],
      data['isWakeup'],
      data['isDynamic'],
      data['highestDirectReportRateValue'],
      data['fifoMaxEventCount'],
      data['fifoReservedEventCount']);
} // g

class MotionDetect {
  // type 30
  MotionDetect(this.sensor, this.isInMotion);
  SensorInfoHolder sensor;
  String isInMotion;

  String getStateText() {
    return isInMotion == '1.0' ? 'Device in Motion' : 'Device not in Motion';
  }

  Widget getCard() {
    return CustomCard(
      // Motion detect sensor

      child: Container(
        child: Column(
          children: sensor.appendThem([
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Motion Detection'),
                Text(getStateText()),
              ],
            ),
          ]),
        ),
        padding:
            EdgeInsets.only(left: 10.0, right: 10.0, top: 12.0, bottom: 12.0),
      ),
    );
  }
}

class StationaryDetect {
  // type 29
  StationaryDetect(this.sensor, this.isImmobile);
  SensorInfoHolder sensor;
  String isImmobile;

  String getStateText() {
    return isImmobile == '1.0'
        ? 'Device in Stationary State'
        : 'Device not in Stationary State';
  }

  Widget getCard() {
    return CustomCard(
      // Motion detect sensor

      child: Container(
        child: Column(
          children: sensor.appendThem([
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Motion Detection'),
                Text(getStateText()),
              ],
            ),
          ]),
        ),
        padding:
            EdgeInsets.only(left: 10.0, right: 10.0, top: 12.0, bottom: 12.0),
      ),
    );
  }
}
