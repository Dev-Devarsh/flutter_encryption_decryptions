import 'dart:io';

import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'encryption_decryptions_method_channel.dart';

abstract class EncryptionDecryptionsPlatform extends PlatformInterface {
  /// Constructs a EncryptionDecryptionsPlatform.
  EncryptionDecryptionsPlatform() : super(token: _token);

  static final Object _token = Object();

  static EncryptionDecryptionsPlatform _instance = EncryptDecrypt();

  /// The default instance of [EncryptionDecryptionsPlatform] to use.
  ///
  /// Defaults to [MethodChannelEncryptionDecryptions].
  static EncryptionDecryptionsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [EncryptionDecryptionsPlatform] when
  /// they register themselves.
  static set instance(EncryptionDecryptionsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> encryptData({required String data, required String key}) async {
    final args = {"key": key, "jsonData": data};
    const encryptChannel = MethodChannel('encryption_decryptions');
    if (Platform.isIOS) {
      try {
        String encryptedResponse = await encryptChannel.invokeMethod('ios_encrypt', args);
        return encryptedResponse;
      } catch (e) {
        return null;
      }
    } else {
      try {
        String encryptedResponse = await encryptChannel.invokeMethod('android_encrypt', args);
        return encryptedResponse;
      } catch (e) {
        return null;
      }
    }
  }

  Future<String?> decryptData({required String data, required String key}) async {
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
