package com.twarkapps.phone_monitor

import android.app.ActivityManager
import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorManager
import android.os.Build
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import android.view.Display
import android.view.WindowManager
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
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
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler {
                call,
                result ->
            when (call.method) {
                "getTotalPhysicalMemory" -> result.success(getTotalPhysicalMemory())
                "getAvailableMemory" -> result.success(getAvailableMemory())
                "getTotalMemory" -> result.success(getTotalMemory())
                "getDisplayData" -> result.success(getDisplayData())
                "getSensorsList" -> {
                    eventChannel =
                            EventChannel(
                                    flutterEngine.dartExecutor.binaryMessenger,
                                    eventChannelName
                            )
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
                    private lateinit var listener: CustomSensorListener
                    override fun onCancel(p0: Any?) {
                        sensorManager.unregisterListener(listener)
                    }

                    override fun onListen(p0: Any?, p1: EventChannel.EventSink?) {
                        if (p1 != null) {
                            listener = CustomSensorListener(p1)
                            sensorManager.getSensorList(Sensor.TYPE_ALL).forEach {
                                sensorManager.registerListener(
                                        listener,
                                        it,
                                        SensorManager.SENSOR_DELAY_NORMAL
                                )
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
                "reportingMode" to
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP)
                                sensor.reportingMode.toString()
                        else "NA",
                "maxDelay" to
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP)
                                (sensor.maxDelay.toFloat() / 1000000.0).toString()
                        else "NA",
                "isWakeup" to
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP)
                                sensor.isWakeUpSensor.toString()
                        else "NA",
                "isDynamic" to
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N)
                                sensor.isDynamicSensor.toString()
                        else "NA",
                "highestDirectReportRateValue" to
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O)
                                sensor.highestDirectReportRateLevel.toString()
                        else "NA",
                "fifoReservedEventCount" to
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT)
                                sensor.fifoReservedEventCount.toString()
                        else "NA",
                "fifoMaxEventCount" to
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT)
                                sensor.fifoMaxEventCount.toString()
                        else "NA"
        )
    }

    private fun getTotalPhysicalMemory(): Long {
        return try {
            RandomAccessFile("/proc/meminfo", "r").use {
                it.readLine().split(":")[1].removeSuffix("kB").trim().toLong()
            }
        } catch (e: Exception) {
            -1L
        }
    }

    @RequiresApi(Build.VERSION_CODES.M)
    private fun getDisplayData(): Map<String, Any> {

        var display: Display? =
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
                    this.display
                } else {
                    (getSystemService(Context.WINDOW_SERVICE) as WindowManager).defaultDisplay
                }
        val metrics = resources.displayMetrics
        display?.getRealMetrics(metrics)
        val name = display?.name ?: "Unknown"
        val density = metrics.density
        val densityDpi = metrics.densityDpi
        val heightPixels = metrics.heightPixels
        val scaledDensity = metrics.scaledDensity
        val widthPixels = metrics.widthPixels
        val xdpi = metrics.xdpi
        val ydpi = metrics.ydpi
        val isHdr =
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                    display?.isHdr ?: false
                } else {
                    false
                }
        val refreshRate = display?.mode?.refreshRate ?: 0.0f
        return mapOf(
                "name" to name,
                "density" to density,
                "densityDpi" to densityDpi,
                "heightPixels" to heightPixels,
                "scaledDensity" to scaledDensity,
                "widthPixels" to widthPixels,
                "xdpi" to xdpi,
                "ydpi" to ydpi,
                "refreshRate" to refreshRate,
                "isHdr" to isHdr
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

    private fun getSensorsList(): Map<String, List<Map<String, String>>> {
        val myMap = mutableMapOf<String, List<Map<String, String>>>()
        listOf(
                Sensor.TYPE_ACCELEROMETER,
                Sensor.TYPE_ACCELEROMETER_UNCALIBRATED,
                Sensor.TYPE_AMBIENT_TEMPERATURE,
                Sensor.TYPE_GAME_ROTATION_VECTOR,
                Sensor.TYPE_GEOMAGNETIC_ROTATION_VECTOR,
                Sensor.TYPE_GRAVITY,
                Sensor.TYPE_GYROSCOPE,
                Sensor.TYPE_GYROSCOPE_UNCALIBRATED,
                Sensor.TYPE_LIGHT,
                Sensor.TYPE_LINEAR_ACCELERATION,
                Sensor.TYPE_MAGNETIC_FIELD,
                Sensor.TYPE_MAGNETIC_FIELD_UNCALIBRATED,
                Sensor.TYPE_PRESSURE,
                Sensor.TYPE_PRESSURE,
                Sensor.TYPE_PROXIMITY,
                Sensor.TYPE_ROTATION_VECTOR,
                Sensor.TYPE_RELATIVE_HUMIDITY,
                Sensor.TYPE_STATIONARY_DETECT,
                Sensor.TYPE_MOTION_DETECT,
                Sensor.TYPE_LOW_LATENCY_OFFBODY_DETECT
        )
                .forEach { elem ->
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
    }
}
