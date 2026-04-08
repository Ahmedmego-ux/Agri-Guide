// android/app/src/main/kotlin/com/example/agri_guide_app/MainActivity.kt
package com.example.agri_guide_app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "permissions"
    
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "checkCameraPermission") {
                    // Handle permission check if needed
                    result.success(true)
                } else {
                    result.notImplemented()
                }
            }
    }
}
