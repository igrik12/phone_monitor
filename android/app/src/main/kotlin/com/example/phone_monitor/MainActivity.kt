package com.twarkapps.phone_monitor

import android.app.ActivityManager
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import android.view.WindowManager
import android.util.DisplayMetrics
import android.view.Display
import androidx.annotation.NonNull
import io.flutter.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.RandomAccessFile


class MainActivity : FlutterActivity() {
    private val channel = "com.twarkapps.phone_monitor/device_info"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler { call, result ->
            when (call.method) {
                "getTotalPhysicalMemory" -> result.success(getTotalPhysicalMemory())
                "getAvailableMemory" -> result.success(getAvailableMemory())
                "getTotalMemory" -> result.success(getTotalMemory())
                "getBatteryData" -> result.success(getBatteryData())
                "getDisplayData" -> result.success(getDisplayData())
                else -> {
                    result.notImplemented()
                }
            }
        }
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
