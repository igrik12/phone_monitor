package com.example.phone_monitor

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import androidx.annotation.NonNull
import io.flutter.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.BufferedReader
import java.io.FileInputStream
import java.io.InputStreamReader
import java.io.RandomAccessFile


class MainActivity : FlutterActivity() {
    private val CHANNEL = "native_comms"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getBatteryLevel" -> result.success(getBatteryLevel())
                "getTotalPhysicalMemory" -> result.success(getTotalPhysicalMemory())
                "getVirtualMemorySize" -> result.success(getVirtualMemorySize())
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

    private fun getVirtualMemorySize(): Long {
        return try {
            val runtime = Runtime.getRuntime()
            val process = runtime.exec("ps -o vsz -p ${android.os.Process.myPid()}")
            process.waitFor()
            val reader = BufferedReader(InputStreamReader(process.getInputStream()))
            val lines = reader.readLines()
            lines[1].toLong()

        } catch (e: Exception) {
            -1L
        }
    }

    private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
        }

        return batteryLevel
    }
}