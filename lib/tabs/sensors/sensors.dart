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
  bool _isFirstUIBuildDone = false;
  List<Accelerometer> _listAccelerometer = [];
  List<UncalibratedAccelerometer> _listUncalibratedAccelerometer = [];
  List<Gravity> _listGravity = [];
  List<LinearAcceleration> _listLinearAcceleration = [];
  List<MagneticField> _listMagneticField = [];
  List<OrientationSensor> _listOrientationSensor = [];
  List<Gyroscope> _listGyroscope = [];
  List<UncalibratedGyroscope> _listUncalibratedGyroscope = [];
  List<HeartBeat> _listHeartBeat = [];
  List<AmbientLight> _listAmbientLight = [];
  List<AtmosphericPressure> _listAtmosphericPressure = [];
  List<Proximity> _listProximity = [];
  List<RotationVector> _listRotationVector = [];
  List<GameRotationVector> _listGameRotationVector = [];
  List<GeoMagneticRotationVector> _listGeoMagneticRotationVector = [];
  List<RelativeHumidity> _listRelativeHumidity = [];
  List<AmbientRoomTemperature> _listAmbientRoomTemperature = [];
  List<LowLatencyOffBodyDetect> _listLowLatencyOffBodyDetect = [];
  List<MotionDetect> _listMotionDetect = [];
  List<StationaryDetect> _listStationaryDetect = [];

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
            if (value.length > 0) {
              value.forEach((dynamic element) {
                _listAccelerometer.add(Accelerometer(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA',
                    'NA',
                    'NA'));
              });
            }
            break;
          case '35':
            if (value.length > 0) {
              value.forEach((dynamic element) {
                _listUncalibratedAccelerometer.add(UncalibratedAccelerometer(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA',
                    'NA',
                    'NA',
                    'NA',
                    'NA',
                    'NA'));
              });
            }
            break;
          case '9':
            if (value.length > 0) {
              value.forEach((dynamic element) {
                _listGravity.add(Gravity(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA',
                    'NA',
                    'NA'));
              });
            }
            break;
          case '10':
            if (value.length > 0) {
              value.forEach((dynamic element) {
                _listLinearAcceleration.add(LinearAcceleration(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA',
                    'NA',
                    'NA'));
              });
            }
            break;
          case '2':
            if (value.length > 0) {
              value.forEach((dynamic element) {
                _listMagneticField.add(MagneticField(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA',
                    'NA',
                    'NA'));
              });
            }
            break;
          case '3':
            if (value.length > 0) {
              value.forEach((dynamic element) {
                _listOrientationSensor.add(OrientationSensor(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA',
                    'NA',
                    'NA'));
              });
            }
            break;
          case '4':
            if (value.length > 0) {
              value.forEach((dynamic element) {
                _listGyroscope.add(Gyroscope(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA',
                    'NA',
                    'NA'));
              });
            }
            break;
          case '16':
            if (value.length > 0) {
              value.forEach((dynamic element) {
                _listUncalibratedGyroscope.add(UncalibratedGyroscope(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA',
                    'NA',
                    'NA',
                    'NA',
                    'NA',
                    'NA'));
              });
            }
            break;
          case '31':
            if (value.length > 0) {
              value.forEach((dynamic element) {
                _listHeartBeat.add(HeartBeat(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA'));
              });
            }
            break;
          case '5':
            if (value.length > 0) {
              value.forEach((dynamic element) {
                _listAmbientLight.add(AmbientLight(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA'));
              });
            }
            break;
          case '6':
            if (value.length > 0) {
              value.forEach((dynamic element) {
                _listAtmosphericPressure.add(AtmosphericPressure(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA'));
              });
            }
            break;
          case '8':
            if (value.length > 0) {
              value.forEach((dynamic element) {
                _listProximity.add(Proximity(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA'));
              });
            }
            break;
          case '11':
            if (value.length > 0) {
              value.forEach((dynamic element) {
                _listRotationVector.add(RotationVector(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA',
                    'NA',
                    'NA',
                    'NA',
                    'NA'));
              });
            }
            break;
          case '15':
            if (value.length > 0) {
              value.forEach((dynamic element) {
                _listGameRotationVector.add(GameRotationVector(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA',
                    'NA',
                    'NA',
                    'NA',
                    'NA'));
              });
            }
            break;
          case '20':
            if (value.length > 0) {
              value.forEach((dynamic element) {
                _listGeoMagneticRotationVector.add(GeoMagneticRotationVector(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA',
                    'NA',
                    'NA',
                    'NA',
                    'NA'));
              });
            }
            break;
          case '12':
            if (value.length > 0) {
              value.forEach((dynamic element) {
                _listRelativeHumidity.add(RelativeHumidity(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA'));
              });
            }
            break;
          case '13':
            if (value.length > 0) {
              value.forEach((dynamic element) {
                _listAmbientRoomTemperature.add(AmbientRoomTemperature(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA'));
              });
            }
            break;
          case '29':
            if (value.length > 0) {
              value.forEach((dynamic element) {
                _listStationaryDetect.add(StationaryDetect(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA'));
              });
            }
            break;
          case '30':
            if (value.length > 0) {
              value.forEach((dynamic element) {
                _listMotionDetect.add(MotionDetect(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA'));
              });
            }
            break;
          case '34':
            if (value.length > 0) {
              value.forEach((dynamic element) {
                _listLowLatencyOffBodyDetect.add(LowLatencyOffBodyDetect(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA'));
              });
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
    Future.delayed(Duration(milliseconds: 100), () {
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
        _listAccelerometer.forEach((item) {
          if (isAMatch(item.sensor, receivedData)) {
            List<String> sensorFeed = receivedData['values'].split(';');
            if (!mounted) return;
            setState(() {
              item.x = sensorFeed[0];
              item.y = sensorFeed[1];
              item.z = sensorFeed[2];
            });
          }
        });
        break;
      case '35':
        _listUncalibratedAccelerometer.forEach((item) {
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
        });
        break;
      case '9':
        _listGravity.forEach((item) {
          if (isAMatch(item.sensor, receivedData)) {
            List<String> sensorFeed = receivedData['values'].split(';');
            if (!mounted) return;
            setState(() {
              item.x = sensorFeed[0];
              item.y = sensorFeed[1];
              item.z = sensorFeed[2];
            });
          }
        });
        break;
      case '10':
        _listLinearAcceleration.forEach((item) {
          if (isAMatch(item.sensor, receivedData)) {
            List<String> sensorFeed = receivedData['values'].split(';');
            if (!mounted) return;
            setState(() {
              item.x = sensorFeed[0];
              item.y = sensorFeed[1];
              item.z = sensorFeed[2];
            });
          }
        });
        break;
      case '2':
        _listMagneticField.forEach((item) {
          if (isAMatch(item.sensor, receivedData)) {
            List<String> sensorFeed = receivedData['values'].split(';');
            if (!mounted) return;
            setState(() {
              item.x = sensorFeed[0];
              item.y = sensorFeed[1];
              item.z = sensorFeed[2];
            });
          }
        });
        break;
      case '3':
        _listOrientationSensor.forEach((item) {
          if (isAMatch(item.sensor, receivedData)) {
            List<String> sensorFeed = receivedData['values'].split(';');
            if (!mounted) return;
            setState(() {
              item.azimuth = sensorFeed[0];
              item.pitch = sensorFeed[1];
              item.roll = sensorFeed[2];
            });
          }
        });
        break;
      case '4':
        _listGyroscope.forEach((item) {
          if (isAMatch(item.sensor, receivedData)) {
            List<String> sensorFeed = receivedData['values'].split(';');
            if (!mounted) return;
            setState(() {
              item.angularSpeedAroundX = sensorFeed[0];
              item.angularSpeedAroundY = sensorFeed[1];
              item.angularSpeedAroundZ = sensorFeed[2];
            });
          }
        });
        break;
      case '16':
        _listUncalibratedGyroscope.forEach((item) {
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
        });
        break;
      case '31':
        _listHeartBeat.forEach((item) {
          if (isAMatch(item.sensor, receivedData)) {
            List<String> sensorFeed = receivedData['values'].split(';');
            if (!mounted) return;
            setState(() {
              item.confidence = sensorFeed[0];
            });
          }
        });
        break;
      case '5':
        _listAmbientLight.forEach((item) {
          if (isAMatch(item.sensor, receivedData)) {
            List<String> sensorFeed = receivedData['values'].split(';');
            if (!mounted) return;
            setState(() {
              item.level = sensorFeed[0];
            });
          }
        });
        break;
      case '6':
        _listAtmosphericPressure.forEach((item) {
          if (isAMatch(item.sensor, receivedData)) {
            List<String> sensorFeed = receivedData['values'].split(';');
            if (!mounted) return;
            setState(() {
              item.pressure = sensorFeed[0];
            });
          }
        });
        break;
      case '8':
        _listProximity.forEach((item) {
          if (isAMatch(item.sensor, receivedData)) {
            List<String> sensorFeed = receivedData['values'].split(';');
            if (!mounted) return;
            setState(() {
              item.distance = sensorFeed[0];
            });
          }
        });
        break;
      case '11':
        _listRotationVector.forEach((item) {
          if (isAMatch(item.sensor, receivedData)) {
            List<String> sensorFeed = receivedData['values'].split(';');
            if (!mounted) return;
            setState(() {
              item.x = sensorFeed[0];
              item.y = sensorFeed[1];
              item.z = sensorFeed[2];
              if (sensorFeed.length == 4)
                item.someVal = sensorFeed[3];
              else if (sensorFeed.length == 5)
                item.estimatedHeadingAccuracy = sensorFeed[4];
            });
          }
        });
        break;
      case '15':
        _listGameRotationVector.forEach((item) {
          if (isAMatch(item.sensor, receivedData)) {
            List<String> sensorFeed = receivedData['values'].split(';');
            if (!mounted) return;
            setState(() {
              item.x = sensorFeed[0];
              item.y = sensorFeed[1];
              item.z = sensorFeed[2];
              if (sensorFeed.length == 4)
                item.someVal = sensorFeed[3];
              else if (sensorFeed.length == 5)
                item.estimatedHeadingAccuracy = sensorFeed[4];
            });
          }
        });
        break;
      case '20':
        _listGeoMagneticRotationVector.forEach((item) {
          if (isAMatch(item.sensor, receivedData)) {
            List<String> sensorFeed = receivedData['values'].split(';');
            if (!mounted) return;
            setState(() {
              item.x = sensorFeed[0];
              item.y = sensorFeed[1];
              item.z = sensorFeed[2];
              if (sensorFeed.length == 4)
                item.someVal = sensorFeed[3];
              else if (sensorFeed.length == 5)
                item.estimatedHeadingAccuracy = sensorFeed[4];
            });
          }
        });
        break;
      case '12':
        _listRelativeHumidity.forEach((item) {
          if (isAMatch(item.sensor, receivedData)) {
            List<String> sensorFeed = receivedData['values'].split(';');
            if (!mounted) return;
            setState(() {
              item.humidity = sensorFeed[0];
            });
          }
        });
        break;
      case '13':
        _listAmbientRoomTemperature.forEach((item) {
          if (isAMatch(item.sensor, receivedData)) {
            List<String> sensorFeed = receivedData['values'].split(';');
            if (!mounted) return;
            setState(() {
              item.temperature = sensorFeed[0];
            });
          }
        });
        break;
      case '29':
        _listStationaryDetect.forEach((item) {
          if (isAMatch(item.sensor, receivedData)) {
            List<String> sensorFeed = receivedData['values'].split(';');
            if (!mounted) return;
            setState(() {
              item.isImmobile = sensorFeed[0];
            });
          }
        });
        break;
      case '30':
        _listMotionDetect.forEach((item) {
          if (isAMatch(item.sensor, receivedData)) {
            List<String> sensorFeed = receivedData['values'].split(';');
            if (!mounted) return;
            setState(() {
              item.isInMotion = sensorFeed[0];
            });
          }
        });
        break;
      case '34':
        _listLowLatencyOffBodyDetect.forEach((item) {
          if (isAMatch(item.sensor, receivedData)) {
            List<String> sensorFeed = receivedData['values'].split(';');
            if (!mounted) return;
            setState(() {
              item.offBodyState = sensorFeed[0];
            });
          }
        });
        break;
      default:
      //not supported yet
    }
  }

  void _onError(dynamic error) {}

  List<Widget> buildUI() {
    List<Widget> tmpUI = [];
    <List<dynamic>>[
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
    ].forEach((List<dynamic> elem) {
      elem.forEach((dynamic item) {
        tmpUI.add(item.getCard());
      });
    });
    return tmpUI;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(padding: EdgeInsets.all(6.0), children: buildUI());
  }
}
