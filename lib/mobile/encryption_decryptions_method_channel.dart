import 'dart:io';

import 'package:encryption_decryptions/web/encryption_decryptions_web.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../platform_interface/encryption_decryptions_platform_interface.dart';

/// An implementation of [EncryptionDecryptionsPlatform] that uses method channels.
class MethodChannelEncryptionDecryptions extends EncryptionDecryptionsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('encryption_decryptions');
  final EncryptionDecryptionsWeb _encryptionDecryptionsWeb = EncryptionDecryptionsWeb();

  @override
  Future<String?> encrypt({required String key, required String data}) async {
    String resp = "";
    if (kIsWeb) {
      return _encryptionDecryptionsWeb.encrypt(key: key, data: data);
    } else if (Platform.isIOS) {
      resp = await methodChannel.invokeMethod<String?>('ios_encrypt', {"key": key, "jsonData": data}) ?? "";
    } else {
      resp = await methodChannel.invokeMethod<String?>('android_encrypt', {"key": key, "jsonData": data}) ?? "";
    }
    return resp;
  }

  @override
  Future<String?> decrypt({required String key, required String data}) async {
    String resp = "";
      if (kIsWeb) {
      return _encryptionDecryptionsWeb.decrypt(key: key, data: data);
    } else if (Platform.isIOS) {
      resp = await methodChannel.invokeMethod<String?>('ios_decrypt', {"key": key, "encryptString": data}) ?? "";
    } else {
      resp = await methodChannel.invokeMethod<String?>('android_decrypt', {"key": key, "encryptString": data}) ?? "";
    }
    return resp;
  }
}
