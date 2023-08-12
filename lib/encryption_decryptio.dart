import 'dart:io';
import 'package:flutter/services.dart';

class EncryptDecrypt {
  /// Constructs a [EncryptDecrypt].
  static final EncryptDecrypt _instance = EncryptDecrypt._();
  EncryptDecrypt._();
  factory EncryptDecrypt() => _instance;

  /// Initializes a [MethodChannel]
  static const _encryptChannel = MethodChannel('encryption_decryptions');

  /// Encrypts data with given parameters
  /// Use same key for encrypt and decrypt
  static Future<String?> encryptData({required String data, required String key}) async {
    final args = {"key": key, "jsonData": data};
    if (Platform.isIOS) {
      try {
        String encryptedResponse = await _encryptChannel.invokeMethod('ios_encrypt', args);
        return encryptedResponse;
      } catch (e) {
        return null;
      }
    } else {
      try {
        String encryptedResponse = await _encryptChannel.invokeMethod('android_encrypt', args);
        return encryptedResponse;
      } catch (e) {
        return null;
      }
    }
  }

  /// Decrypts data with given parameters
  /// Use same key for encrypt and decrypt
  static Future<String?> decryptData({required String data, required String key}) async {
    final args = {"key": key, "encryptString": data};
    const decryptChannel = MethodChannel('encryption_decryptions');
    if (Platform.isIOS) {
      try {
        final decryptedResponse = await decryptChannel.invokeMethod('ios_decrypt', args);
        return decryptedResponse;
      } catch (e) {
        return null;
      }
    } else {
      try {
        var encryptedResponse = await decryptChannel.invokeMethod('android_decrypt', args);
        return encryptedResponse;
      } catch (e) {
        return null;
      }
    }
  }
}
