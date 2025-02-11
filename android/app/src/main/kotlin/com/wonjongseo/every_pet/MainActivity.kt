package com.wonjongseo.every_pet

// import io.flutter.embedding.android.FlutterActivity

// class MainActivity: FlutterActivity() {
// }


import android.content.Intent
import android.net.Uri
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.Result

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.wonjongseo.every_pets/channel"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        MethodChannel(flutterEngine!!.dartExecutor, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "callPhone") {
                val phoneNumber = call.argument<String>("number")
                phoneNumber?.let {
                    makePhoneCall(it)
                    result.success(true)
                } ?: run {
                    result.error("INVALID_ARGUMENT", "dont number", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun makePhoneCall(phoneNumber: String) {
        val intent = Intent(Intent.ACTION_DIAL)
        intent.data = Uri.parse("tel:$phoneNumber")
        startActivity(intent)
    }
}
