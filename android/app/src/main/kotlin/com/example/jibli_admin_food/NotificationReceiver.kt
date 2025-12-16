package com.example.jibli_admin_food

import android.app.NotificationManager
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import androidx.core.app.NotificationCompat

class NotificationReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {
        // This receiver can handle custom notification actions if needed
        android.util.Log.d("NotificationReceiver", "Broadcast received: ${intent?.action}")
    }
}
