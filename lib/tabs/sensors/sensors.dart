import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phone_monitor/tabs/sensors/sensor_info_holder.dart';
import 'package:phone_monitor/utils/native_comms.dart';

class Sensors extends StatefulWidget {
  @override
  _SensorsState createState() => _SensorsState();
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
}

class _SensorsState extends State<Sensors> {
  EventChannel _eventChannel;
  final List<Accelerometer> _listAccelerometer = [];
  final List<UncalibratedAccelerometer> _listUncalibratedAccelerometer = [];
  final List<Gravity> _listGravity = [];
  final List<LinearAcceleration> _listLinearAcceleration = [];
  final List<MagneticField> _listMagneticField = [];
  final List<OrientationSensor> _listOrientationSensor = [];
  final List<Gyroscope> _listGyroscope = [];
  final List<UncalibratedGyroscope> _listUncalibratedGyroscope = [];
  final List<HeartBeat> _listHeartBeat = [];
  final List<AmbientLight> _listAmbientLight = [];
  final List<AtmosphericPressure> _listAtmosphericPressure = [];
  final List<Proximity> _listProximity = [];
  final List<RotationVector> _listRotationVector = [];
  final List<GameRotationVector> _listGameRotationVector = [];
  final List<GeoMagneticRotationVector> _listGeoMagneticRotationVector = [];
  final List<RelativeHumidity> _listRelativeHumidity = [];
  final List<AmbientRoomTemperature> _listAmbientRoomTemperature = [];
  final List<LowLatencyOffBodyDetect> _listLowLatencyOffBodyDetect = [];
  final List<MotionDetect> _listMotionDetect = [];
  final List<StationaryDetect> _listStationaryDetect = [];

  StreamSubscription _subscription;
  bool _mounted = false;

  Future<void> getSensorsList() async {
    Map<String, List<dynamic>> sensorCount;
    try {
      Map<dynamic, dynamic> tmp = await NativeComms.getSensors();
      sensorCount = Map<String, List<dynamic>>.from(tmp);
      sensorCount.forEach((String key, List<dynamic> value) {
        switch (key) {
          case '1':
            if (value.isNotEmpty) {
              for (var element in value) {
                _listAccelerometer.add(Accelerometer(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA',
                    'NA',
                    'NA'));
              }
            }
            break;
          case '35':
            if (value.isNotEmpty) {
              for (var element in value) {
                _listUncalibratedAccelerometer.add(UncalibratedAccelerometer(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA',
                    'NA',
                    'NA',
                    'NA',
                    'NA',
                    'NA'));
              }
            }
            break;
          case '9':
            if (value.isNotEmpty) {
              for (var element in value) {
                _listGravity.add(Gravity(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA',
                    'NA',
                    'NA'));
              }
            }
            break;
          case '10':
            if (value.isNotEmpty) {
              for (var element in value) {
                _listLinearAcceleration.add(LinearAcceleration(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA',
                    'NA',
                    'NA'));
              }
            }
            break;
          case '2':
            if (value.isNotEmpty) {
              for (var element in value) {
                _listMagneticField.add(MagneticField(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA',
                    'NA',
                    'NA'));
              }
            }
            break;
          case '3':
            if (value.isNotEmpty) {
              for (var element in value) {
                _listOrientationSensor.add(OrientationSensor(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA',
                    'NA',
                    'NA'));
              }
            }
            break;
          case '4':
            if (value.isNotEmpty) {
              for (var element in value) {
                _listGyroscope.add(Gyroscope(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA',
                    'NA',
                    'NA'));
              }
            }
            break;
          case '16':
            if (value.isNotEmpty) {
              for (var element in value) {
                _listUncalibratedGyroscope.add(UncalibratedGyroscope(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA',
                    'NA',
                    'NA',
                    'NA',
                    'NA',
                    'NA'));
              }
            }
            break;
          case '31':
            if (value.isNotEmpty) {
              for (var element in value) {
                _listHeartBeat.add(HeartBeat(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA'));
              }
            }
            break;
          case '5':
            if (value.isNotEmpty) {
              for (var element in value) {
                _listAmbientLight.add(AmbientLight(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA'));
              }
            }
            break;
          case '6':
            if (value.isNotEmpty) {
              for (var element in value) {
                _listAtmosphericPressure.add(AtmosphericPressure(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA'));
              }
            }
            break;
          case '8':
            if (value.isNotEmpty) {
              for (var element in value) {
                _listProximity.add(Proximity(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA'));
              }
            }
            break;
          case '11':
            if (value.isNotEmpty) {
              for (var element in value) {
                _listRotationVector.add(RotationVector(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA',
                    'NA',
                    'NA',
                    'NA',
                    'NA'));
              }
            }
            break;
          case '15':
            if (value.isNotEmpty) {
              for (var element in value) {
                _listGameRotationVector.add(GameRotationVector(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA',
                    'NA',
                    'NA',
                    'NA',
                    'NA'));
              }
            }
            break;
          case '20':
            if (value.isNotEmpty) {
              for (var element in value) {
                _listGeoMagneticRotationVector.add(GeoMagneticRotationVector(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA',
                    'NA',
                    'NA',
                    'NA',
                    'NA'));
              }
            }
            break;
          case '12':
            if (value.isNotEmpty) {
              for (var element in value) {
                _listRelativeHumidity.add(RelativeHumidity(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA'));
              }
            }
            break;
          case '13':
            if (value.isNotEmpty) {
              for (var element in value) {
                _listAmbientRoomTemperature.add(AmbientRoomTemperature(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA'));
              }
            }
            break;
          case '29':
            if (value.isNotEmpty) {
              for (var element in value) {
                _listStationaryDetect.add(StationaryDetect(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA'));
              }
            }
            break;
          case '30':
            if (value.isNotEmpty) {
              for (var element in value) {
                _listMotionDetect.add(MotionDetect(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA'));
              }
            }
            break;
          case '34':
            if (value.isNotEmpty) {
              for (var element in value) {
                _listLowLatencyOffBodyDetect.add(LowLatencyOffBodyDetect(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA'));
              }
            }
            break;
          default:
          //not supported yet
        }
      });
    } on PlatformException {}
    setState(() {
      _mounted = true;
    });
  }

  @override
  void initState() {
    // stateful widget initialization done here
    super.initState();
    getSensorsList();
    _mounted = true;
    Future.delayed(Duration(milliseconds: 500), () {
      _eventChannel = EventChannel('com.twarkapps.phone_monitor/sensor_stream');
      _subscription = _eventChannel
          .receiveBroadcastStream()
          .listen(_onData, onError: _onError);
    });
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
    _subscription?.cancel();
    _subscription = null;
  }

  bool isAMatch(SensorInfoHolder data, Map<String, String> receivedData) {
    // Finds whether it is an instance of target class so that we can use it to update UI.
    return (data.name == receivedData['name'] &&
        data.vendorName == receivedData['vendorName'] &&
        data.version == receivedData['version']);
  }

  void _onData(dynamic event) {
    // on sensor data reception, update data holders of different supported sensor types
    if (!_mounted) return;
    Map<String, String> receivedData = Map<String, String>.from(event);
    switch (receivedData['type']) {
      case '1':
        for (var item in _listAccelerometer) {
          if (isAMatch(item.sensor, receivedData)) {
            List<String> sensorFeed = receivedData['values'].split(';');
            if (!mounted) return;
            setState(() {
              item.x = sensorFeed[0];
              item.y = sensorFeed[1];
              item.z = sensorFeed[2];
            });
          }
        }
        break;
      case '35':
        for (var item in _listUncalibratedAccelerometer) {
          if (isAMatch(item.sensor, receivedData)) {
            List<String> sensorFeed = receivedData['values'].split(';');
            if (!mounted) return;
            setState(() {
              item.xUncalib = sensorFeed[0];
              item.yUncalib = sensorFeed[1];
              item.zUnclaib = sensorFeed[2];
              item.estimatedXBias = sensorFeed[3];
              item.estimatedYBias = sensorFeed[4];
              item.estimatedZBias = sensorFeed[5];
            });
          }
        }
        break;
      case '9':
        for (var item in _listGravity) {
          if (isAMatch(item.sensor, receivedData)) {
            List<String> sensorFeed = receivedData['values'].split(';');
            if (!mounted) return;
            setState(() {
              item.x = sensorFeed[0];
              item.y = sensorFeed[1];
              item.z = sensorFeed[2];
            });
          }
        }
        break;
      case '10':
        for (var item in _listLinearAcceleration) {
          if (isAMatch(item.sensor, receivedData)) {
            List<String> sensorFeed = receivedData['values'].split(';');
            if (!mounted) return;
            setState(() {
              item.x = sensorFeed[0];
              item.y = sensorFeed[1];
              item.z = sensorFeed[2];
            });
          }
        }
        break;
      case '2':
        for (var item in _listMagneticField) {
          if (isAMatch(item.sensor, receivedData)) {
            List<String> sensorFeed = receivedData['values'].split(';');
            if (!mounted) return;
            setState(() {
              item.x = sensorFeed[0];
              item.y = sensorFeed[1];
              item.z = sensorFeed[2];
            });
          }
        }
        break;
      case '3':
        for (var item in _listOrientationSensor) {
          if (isAMatch(item.sensor, receivedData)) {
            List<String> sensorFeed = receivedData['values'].split(';');
            if (!mounted) return;
            setState(() {
              item.azimuth = sensorFeed[0];
              item.pitch = sensorFeed[1];
              item.roll = sensorFeed[2];
            });
          }
        }
        break;
      case '4':
        for (var item in _listGyroscope) {
          if (isAMatch(item.sensor, receivedData)) {
            List<String> sensorFeed = receivedData['values'].split(';');
            if (!mounted) return;
            setState(() {
              item.angularSpeedAroundX = sensorFeed[0];
              item.angularSpeedAroundY = sensorFeed[1];
              item.angularSpeedAroundZ = sensorFeed[2];
            });
          }
        }
        break;
      case '16':
        for (var item in _listUncalibratedGyroscope) {
          if (isAMatch(item.sensor, receivedData)) {
            List<String> sensorFeed = receivedData['values'].split(';');
            if (!mounted) return;
            setState(() {
              item.angularSpeedAroundX = sensorFeed[0];
              item.angularSpeedAroundY = sensorFeed[1];
              item.angularSpeedAroundZ = sensorFeed[2];
              item.estimatedDriftAroundX = sensorFeed[3];
              item.estimatedDriftAroundY = sensorFeed[4];
              item.estimatedDriftAroundZ = sensorFeed[5];
            });
          }
        }
        break;
      case '31':
        for (var item in _listHeartBeat) {
          if (isAMatch(item.sensor, receivedData)) {
            List<String> sensorFeed = receivedData['values'].split(';');
            if (!mounted) return;
            setState(() {
              item.confidence = sensorFeed[0];
            });
          }
        }
        break;
      case '5':
        for (var item in _listAmbientLight) {
          if (isAMatch(item.sensor, receivedData)) {
            List<String> sensorFeed = receivedData['values'].split(';');
            if (!mounted) return;
            setState(() {
              item.level = sensorFeed[0];
            });
          }
        }
        break;
      case '6':
        for (var item in _listAtmosphericPressure) {
          if (isAMatch(item.sensor, receivedData)) {
            List<String> sensorFeed = receivedData['values'].split(';');
            if (!mounted) return;
            setState(() {
              item.pressure = sensorFeed[0];
            });
          }
        }
        break;
      case '8':
        for (var item in _listProximity) {
          if (isAMatch(item.sensor, receivedData)) {
            List<String> sensorFeed = receivedData['values'].split(';');
            if (!mounted) return;
            setState(() {
              item.distance = sensorFeed[0];
            });
          }
        }
        break;
      case '11':
        for (var item in _listRotationVector) {
          if (isAMatch(item.sensor, receivedData)) {
            List<String> sensorFeed = receivedData['values'].split(';');
            if (!mounted) return;
            setState(() {
              item.x = sensorFeed[0];
              item.y = sensorFeed[1];
              item.z = sensorFeed[2];
              if (sensorFeed.length == 4) {
                item.someVal = sensorFeed[3];
              } else if (sensorFeed.length == 5) {
                item.estimatedHeadingAccuracy = sensorFeed[4];
              }
            });
          }
        }
        break;
      case '15':
        for (var item in _listGameRotationVector) {
          if (isAMatch(item.sensor, receivedData)) {
            List<String> sensorFeed = receivedData['values'].split(';');
            if (!mounted) return;
            setState(() {
              item.x = sensorFeed[0];
              item.y = sensorFeed[1];
              item.z = sensorFeed[2];
              if (sensorFeed.length == 4) {
                item.someVal = sensorFeed[3];
              } else if (sensorFeed.length == 5) {
                item.estimatedHeadingAccuracy = sensorFeed[4];
              }
            });
          }
        }
        break;
      case '20':
        for (var item in _listGeoMagneticRotationVector) {
          if (isAMatch(item.sensor, receivedData)) {
            List<String> sensorFeed = receivedData['values'].split(';');
            if (!mounted) return;
            setState(() {
              item.x = sensorFeed[0];
              item.y = sensorFeed[1];
              item.z = sensorFeed[2];
              if (sensorFeed.length == 4) {
                item.someVal = sensorFeed[3];
              } else if (sensorFeed.length == 5) {
                item.estimatedHeadingAccuracy = sensorFeed[4];
              }
            });
          }
        }
        break;
      case '12':
        for (var item in _listRelativeHumidity) {
          if (isAMatch(item.sensor, receivedData)) {
            List<String> sensorFeed = receivedData['values'].split(';');
            if (!mounted) return;
            setState(() {
              item.humidity = sensorFeed[0];
            });
          }
        }
        break;
      case '13':
        for (var item in _listAmbientRoomTemperature) {
          if (isAMatch(item.sensor, receivedData)) {
            List<String> sensorFeed = receivedData['values'].split(';');
            if (!mounted) return;
            setState(() {
              item.temperature = sensorFeed[0];
            });
          }
        }
        break;
      case '29':
        for (var item in _listStationaryDetect) {
          if (isAMatch(item.sensor, receivedData)) {
            List<String> sensorFeed = receivedData['values'].split(';');
            if (!mounted) return;
            setState(() {
              item.isImmobile = sensorFeed[0];
            });
          }
        }
        break;
      case '30':
        for (var item in _listMotionDetect) {
          if (isAMatch(item.sensor, receivedData)) {
            List<String> sensorFeed = receivedData['values'].split(';');
            if (!mounted) return;
            setState(() {
              item.isInMotion = sensorFeed[0];
            });
          }
        }
        break;
      case '34':
        for (var item in _listLowLatencyOffBodyDetect) {
          if (isAMatch(item.sensor, receivedData)) {
            List<String> sensorFeed = receivedData['values'].split(';');
            if (!mounted) return;
            setState(() {
              item.offBodyState = sensorFeed[0];
            });
          }
        }
        break;
      default:
      //not supported yet
    }
  }

  void _onError(dynamic error) {}

  List<Widget> buildUI() {
    List<Widget> tmpUI = [];
    for (var elem in <List<dynamic>>[
      _listAccelerometer,
      _listUncalibratedAccelerometer,
      _listGravity,
      _listLinearAcceleration,
      _listMagneticField,
      _listOrientationSensor,
      _listGyroscope,
      _listUncalibratedGyroscope,
      _listHeartBeat,
      _listAmbientLight,
      _listAtmosphericPressure,
      _listProximity,
      _listRotationVector,
      _listGameRotationVector,
      _listGeoMagneticRotationVector,
      _listRelativeHumidity,
      _listAmbientRoomTemperature,
      _listStationaryDetect,
      _listMotionDetect,
      _listLowLatencyOffBodyDetect,
    ]) {
      for (var item in elem) {
        tmpUI.add(item.getCard());
      }
    }
    return tmpUI;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(padding: EdgeInsets.all(8.0), children: buildUI());
  }
}
