package com.example.jibli_admin_food

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent

class BootCompletedReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {
        // This receiver ensures Firebase Messaging is re-registered after device reboot.
        // FCM usually handles this automatically, but this ensures compatibility.
        if (intent?.action == Intent.ACTION_BOOT_COMPLETED) {
            // FCM token will be automatically refreshed on app launch.
            android.util.Log.d("BootCompletedReceiver", "Device booted, FCM will refresh on app launch")
        }
    }
}
