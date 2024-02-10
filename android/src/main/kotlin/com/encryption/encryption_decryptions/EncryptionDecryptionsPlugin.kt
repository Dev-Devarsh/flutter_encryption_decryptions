package com.encryption.encryption_decryptions

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import android.provider.Settings
import android.content.Context
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import tgio.rncryptor.RNCryptorNative


/** EncryptionDecryptionsPlugin */
class EncryptionDecryptionsPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "encryption_decryptions")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
            if (call.method == "android_encrypt") {
                val args = call.arguments() as Map<String, String>?
                val key: String? = args!!["key"]
                val data: String? = args!!["jsonData"]
                val rncryptor = RNCryptorNative()
                try {
                    val encryptData = String(rncryptor.encrypt(data!!, key!!))
                    result.success(encryptData)
                }catch (e: Error){
                    result.success("Error")
                }
            } else if (call.method == "android_decrypt") {
                val args = call.arguments() as Map<String, String>?
                val key: String? = args!!["key"]
                val data: String? = args!!["encryptString"]
                val rncryptor = RNCryptorNative()
                try {
                    val decryptData = rncryptor.decrypt(data!!, key!!)
                    result.success(decryptData.toString())
                }catch (e: Error){
                    result.success("Error")
                }
            }
      else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
