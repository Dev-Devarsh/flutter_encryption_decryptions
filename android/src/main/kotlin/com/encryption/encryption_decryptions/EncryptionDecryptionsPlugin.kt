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
import org.json.JSONArray
import org.json.JSONObject
import tgio.rncryptor.RNCryptorNative


/** EncryptionDecryptionsPlugin */
class EncryptionDecryptionsPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private var cryptor : RNCryptorNative = RNCryptorNative()


    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "encryption_decryptions")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        val key = call.argument<String>("key")
        when (call.method) {
            "kEncrypt_string" -> {
                val data = call.argument<String>("data")
                result.success(encryptString(key!!, data!!))
            }

            "kDecrypt_string" -> {
                val data = call.argument<String>("data")
                result.success(decryptString(key!!, data!!))
            }

            "kEncrypt_map" -> {
                val data = call.argument<Map<String, Any>>("data")
                result.success(encryptMap(key!!, data!!))
            }

            "kDecrypt_map" -> {
                val data = call.argument<String>("data")
                result.success(decryptMap(key!!, data!!))
            }

            "kEncrypt_list" -> {
                val data = call.argument<List<Any>>("data")
                result.success(encryptList(key!!, data!!))
            }

            "kDecrypt_list" -> {
                val data = call.argument<String>("data")
                result.success(decryptList(key!!, data!!))
            }

            "kEncrypt_int" -> {
                val data = call.argument<Int>("data")
                result.success(encryptInt(key!!, data!!))
            }

            "kDecrypt_int" -> {
                val data = call.argument<String>("data")
                result.success(decryptInt(key!!, data!!))
            }

            "kEncrypt_double" -> {
                val data = call.argument<Double>("data")
                result.success(encryptDouble(key!!, data!!))
            }

            "kDecrypt_double" -> {
                val data = call.argument<String>("data")
                result.success(decryptDouble(key!!, data!!))
            }

            else -> result.notImplemented()
        }
    }

    // Encryption and Decryption for String
    private fun encryptString(key: String, data: String): String {
        return String(cryptor.encrypt(data, key))
    }

    private fun decryptString(key: String, encryptedData: String): String {
        return cryptor.decrypt(encryptedData, key)
    }

    // Encryption and Decryption for Map
    private fun encryptMap(key: String, data: Map<String, Any>): String {
        return encryptString(key, JSONObject(data).toString()) // Encrypt as JSON string
    }

    private fun decryptMap(key: String, encryptedData: String): Map<String, Any> {
        return JSONObject(decryptString(key, encryptedData)).toMap()
    }

    // Encryption and Decryption for List
    private fun encryptList(key: String, data: List<Any>): String {
        return encryptString(key, JSONArray(data).toString()) // Encrypt as JSON string
    }

    private fun decryptList(key: String, encryptedData: String): List<Any> {
        return JSONArray(decryptString(key, encryptedData)).toList()
    }

    // Encryption and Decryption for Int
    private fun encryptInt(key: String, data: Int): String {
        return encryptString(key, data.toString())
    }

    private fun decryptInt(key: String, encryptedData: String): Int {
        return decryptString(key, encryptedData).toInt()
    }

    // Encryption and Decryption for Double
    private fun encryptDouble(key: String, data: Double): String {
        return encryptString(key, data.toString())
    }

    private fun decryptDouble(key: String, encryptedData: String): Double {
        return decryptString(key, encryptedData).toDouble()
    }

    // Helper function to convert JSONObject to Map
    private fun JSONObject.toMap(): Map<String, Any> = keys().asSequence().associateWith {
        when (val value = this[it]) {
            is JSONArray -> value.toList()
            is JSONObject -> value.toMap()
            else -> value
        }
    }

    // Helper function to convert JSONArray to List
    private fun JSONArray.toList(): List<Any> = (0 until length()).map { get(it) }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
