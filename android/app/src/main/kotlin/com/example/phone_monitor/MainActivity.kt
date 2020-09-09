package com.twarkapps.phone_monitor

import android.app.ActivityManager
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.os.BatteryManager
import android.os.Bundle
import android.os.Build
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import android.util.DisplayMetrics
import android.view.Display
import android.view.WindowManager
import androidx.annotation.NonNull


import io.flutter.view.FlutterMain
import io.flutter.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import java.io.RandomAccessFile


class MainActivity : FlutterActivity() {
    private val channel = "com.twarkapps.phone_monitor/device_info"
    private val eventChannelName: String = "com.twarkapps.phone_monitor/sensor_stream"
    private lateinit var sensorManager: SensorManager
    private var temperature = 10.0F
    private lateinit var eventChannel: EventChannel


    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        sensorManager = getSystemService(Context.SENSOR_SERVICE) as SensorManager
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler { call, result ->
            when (call.method) {
                "getTotalPhysicalMemory" -> result.success(getTotalPhysicalMemory())
                "getAvailableMemory" -> result.success(getAvailableMemory())
                "getTotalMemory" -> result.success(getTotalMemory())
                "getBatteryData" -> result.success(getBatteryData())
                "getDisplayData" -> result.success(getDisplayData())
                "getSensorsList" -> {
                    eventChannel = EventChannel(flutterEngine.dartExecutor.binaryMessenger, eventChannelName)
                    initSensorEventListener()
                    result.success(getSensorsList())
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun initSensorEventListener() {
        eventChannel.setStreamHandler(
                object : EventChannel.StreamHandler {
                    private lateinit var  listener: CustomSensorListener
                    override fun onCancel(p0: Any?) {
                        sensorManager.unregisterListener(listener)
                    }

                    override fun onListen(p0: Any?, p1: EventChannel.EventSink?) {
                        if (p1 != null) {
                            listener = CustomSensorListener(p1)
                            sensorManager.getSensorList(Sensor.TYPE_ALL).forEach {
                                sensorManager.registerListener(listener, it, SensorManager.SENSOR_DELAY_NORMAL)
                            }
                        }
                    }
                }
        )
    }

    private fun extractSensorInfo(sensor: Sensor): Map<String, String> {
        return mapOf(
                "name" to sensor.name,
                "type" to sensor.type.toString(),
                "vendorName" to sensor.vendor.toString(),
                "version" to sensor.version.toString(),
                "resolution" to sensor.resolution.toString(),
                "power" to sensor.power.toString(),
                "maxRange" to sensor.maximumRange.toString(),
                "minDelay" to (sensor.minDelay.toFloat() / 1000000.0).toString(),
                "reportingMode" to if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) sensor.reportingMode.toString() else "NA",
                "maxDelay" to if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) (sensor.maxDelay.toFloat() / 1000000.0).toString() else "NA",
                "isWakeup" to if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) sensor.isWakeUpSensor.toString() else "NA",
                "isDynamic" to if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) sensor.isDynamicSensor.toString() else "NA",
                "highestDirectReportRateValue" to if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) sensor.highestDirectReportRateLevel.toString() else "NA",
                "fifoReservedEventCount" to if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) sensor.fifoReservedEventCount.toString() else "NA",
                "fifoMaxEventCount" to if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) sensor.fifoMaxEventCount.toString() else "NA"
        )
    }

    private fun getSensorsList(): Map<String, List<Map<String, String>>> {
        val myMap = mutableMapOf<String, List<Map<String, String>>>()
        listOf( Sensor.TYPE_ACCELEROMETER, Sensor.TYPE_ACCELEROMETER_UNCALIBRATED, Sensor.TYPE_AMBIENT_TEMPERATURE, Sensor.TYPE_GAME_ROTATION_VECTOR, Sensor.TYPE_GEOMAGNETIC_ROTATION_VECTOR, Sensor.TYPE_GRAVITY, Sensor.TYPE_GYROSCOPE, Sensor.TYPE_GYROSCOPE_UNCALIBRATED, Sensor.TYPE_LIGHT, Sensor.TYPE_LINEAR_ACCELERATION, Sensor.TYPE_MAGNETIC_FIELD, Sensor.TYPE_MAGNETIC_FIELD_UNCALIBRATED, Sensor.TYPE_PRESSURE, Sensor.TYPE_PRESSURE, Sensor.TYPE_PROXIMITY, Sensor.TYPE_ROTATION_VECTOR, Sensor.TYPE_RELATIVE_HUMIDITY, Sensor.TYPE_STATIONARY_DETECT, Sensor.TYPE_MOTION_DETECT, Sensor.TYPE_LOW_LATENCY_OFFBODY_DETECT).forEach { elem ->
            val tmp = mutableListOf<Map<String, String>>()
            when (elem) {
                Sensor.TYPE_ACCELEROMETER_UNCALIBRATED -> {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                        if (sensorManager.getSensorList(elem) != null) {
                            sensorManager.getSensorList(elem).forEach {
                                tmp.add(extractSensorInfo(it))
                            }
                        }
                    }
                }
                Sensor.TYPE_GAME_ROTATION_VECTOR -> {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR2) {
                        if (sensorManager.getSensorList(elem) != null) {
                            sensorManager.getSensorList(elem).forEach {
                                tmp.add(extractSensorInfo(it))
                            }
                        }
                    }
                }
                Sensor.TYPE_GYROSCOPE_UNCALIBRATED -> {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR2) {
                        if (sensorManager.getSensorList(elem) != null) {
                            sensorManager.getSensorList(elem).forEach {
                                tmp.add(extractSensorInfo(it))
                            }
                        }
                    }
                }
                Sensor.TYPE_GEOMAGNETIC_ROTATION_VECTOR -> {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
                        if (sensorManager.getSensorList(elem) != null) {
                            sensorManager.getSensorList(elem).forEach {
                                tmp.add(extractSensorInfo(it))
                            }
                        }
                    }
                }
                Sensor.TYPE_MAGNETIC_FIELD_UNCALIBRATED -> {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR2) {
                        if (sensorManager.getSensorList(elem) != null) {
                            sensorManager.getSensorList(elem).forEach {
                                tmp.add(extractSensorInfo(it))
                            }
                        }
                    }
                }
                Sensor.TYPE_LOW_LATENCY_OFFBODY_DETECT -> {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                        if (sensorManager.getSensorList(elem) != null) {
                            sensorManager.getSensorList(elem).forEach {
                                tmp.add(extractSensorInfo(it))
                            }
                        }
                    }
                }
                Sensor.TYPE_STATIONARY_DETECT -> {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                        if (sensorManager.getSensorList(elem) != null) {
                            sensorManager.getSensorList(elem).forEach {
                                tmp.add(extractSensorInfo(it))
                            }
                        }
                    }
                }
                Sensor.TYPE_MOTION_DETECT -> {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                        if (sensorManager.getSensorList(elem) != null) {
                            sensorManager.getSensorList(elem).forEach {
                                tmp.add(extractSensorInfo(it))
                            }
                        }
                    }
                }
                else -> {
                    if (sensorManager.getSensorList(elem) != null) {
                        sensorManager.getSensorList(elem).forEach {
                            tmp.add(extractSensorInfo(it))
                        }
                    }
                }
            }
            myMap[elem.toString()] = tmp
        }
        return myMap
        //initSensorEventListener()
    }


    private fun getTotalPhysicalMemory(): Long {
        return try {
            RandomAccessFile("/proc/meminfo", "r").use { it.readLine().split(":")[1].removeSuffix("kB").trim().toLong() }
        } catch (e: Exception) {
            -1L
        }
    }


    private fun getDisplayData(): Map<String, Any> {
        val display: Display = (getSystemService(Context.WINDOW_SERVICE) as WindowManager).getDefaultDisplay()
        val metrics = getResources().getDisplayMetrics()
        display.getRealMetrics(metrics)
        val density = metrics.density
        val densityDpi = metrics.densityDpi
        val heightPixels = metrics.heightPixels
        val scaledDensity = metrics.scaledDensity
        val widthPixels = metrics.widthPixels
        val xdpi = metrics.xdpi
        val ydpi = metrics.ydpi
        return mapOf(
                "density" to density,
                "densityDpi" to densityDpi,
                "heightPixels" to heightPixels,
                "scaledDensity" to scaledDensity,
                "widthPixels" to widthPixels,
                "xdpi" to xdpi,
                "ydpi" to ydpi
        )
    }

    private fun getAvailableMemory(): Long {
        val memoryInfo = ActivityManager.MemoryInfo()
        val activityManager = getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
        var mem = activityManager.getMemoryInfo(memoryInfo)
        return memoryInfo.availMem
    }

    private fun getTotalMemory(): Long {
        val memoryInfo = ActivityManager.MemoryInfo()
        val activityManager = getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
        var mem = activityManager.getMemoryInfo(memoryInfo)
        return memoryInfo.totalMem
    }

    private fun getBatteryData(): Map<String, Any> {

        val filter = IntentFilter(Intent.ACTION_BATTERY_CHANGED)
        val intent: Intent = this.registerReceiver(null, filter)
        val status: Int = intent.getIntExtra(BatteryManager.EXTRA_STATUS, -1)
        val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager

        val batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        val voltage = intent.getIntExtra(BatteryManager.EXTRA_VOLTAGE, -1)
        val health = intent.getIntExtra(BatteryManager.EXTRA_HEALTH, 0)
        val plugged = intent.getIntExtra(BatteryManager.EXTRA_PLUGGED, -1)
        val healthy = BatteryManager.BATTERY_HEALTH_GOOD
        val dead = BatteryManager.BATTERY_HEALTH_DEAD
        val pluggedUsb = BatteryManager.BATTERY_PLUGGED_USB
        val pluggedAc = BatteryManager.BATTERY_PLUGGED_AC
        val pluggedWireless = BatteryManager.BATTERY_PLUGGED_WIRELESS
        val chargeTimeRemaining = batteryManager.computeChargeTimeRemaining()
        val currentAverage = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CURRENT_AVERAGE)
        val currentNow = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CURRENT_NOW)
        val charging = status == BatteryManager.BATTERY_STATUS_CHARGING
        val batteryFull = status == BatteryManager.BATTERY_STATUS_FULL
        val temperature = intent.getIntExtra(BatteryManager.EXTRA_TEMPERATURE, 0)
        return mapOf(
                "batteryLevel" to batteryLevel,
                "batteryFull" to batteryFull,
                "voltage" to voltage,
                "charging" to charging,
                "plugged" to plugged,
                "health" to health,
                "healthy" to healthy,
                "dead" to dead,
                "pluggedUsb" to pluggedUsb,
                "pluggedAc" to pluggedAc,
                "pluggedWireless" to pluggedWireless,
                "temperature" to temperature / 10,
                "currentNow" to currentNow,
                "chargeTimeRemaining" to chargeTimeRemaining,
                "currentAverage" to currentAverage
        )
    }
}
