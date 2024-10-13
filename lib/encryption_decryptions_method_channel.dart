import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'encryption_decryptions_platform_interface.dart';

/// An implementation of [EncryptionDecryptionsPlatform] that uses method channels.
class MethodChannelEncryptionDecryptions extends EncryptionDecryptionsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('encryption_decryptions');

  /// [String]
  @override
  Future<String?> encryptString({required String key, required String data}) async {
    return await methodChannel.invokeMethod<String?>('kEncrypt_string', {"key": key, "data": data}) ?? "";
  }

  @override
  Future<String?> decryptString({required String key, required String data}) async {
    return await methodChannel.invokeMethod<String?>('kDecrypt_string', {"key": key, "data": data});
  }

  /// [Map]
  @override
  Future<String?> encryptMap({required String key, required Map<dynamic, dynamic> data}) async {
    return await methodChannel.invokeMethod<String?>('kEncrypt_map', {"key": key, "data": data});
  }

  @override
  Future<Map<dynamic, dynamic>?> decryptMap({required String key, required String data}) async {
    return await methodChannel
        .invokeMethod<Map<dynamic, dynamic>?>('kDecrypt_map', {"key": key, "data": data});
  }

  /// [List]
  @override
  Future<String?> encryptList({required String key, required List<dynamic>? data}) async {
    return await methodChannel.invokeMethod<String?>('kEncrypt_list', {"key": key, "data": data});
  }

  @override
  Future<List<dynamic>?> decryptList({required String key, required String data}) async {
    return await methodChannel.invokeMethod<List<dynamic>?>('kDecrypt_list', {"key": key, "data": data});
  }

  /// [int]
  @override
  Future<String?> encryptInt({required String key, required int data}) async {
    return await methodChannel.invokeMethod<String?>('kDecrypt_int', {"key": key, "data": data});
  }

  @override
  Future<int?> decryptInt({required String key, required String data}) async {
    return await methodChannel.invokeMethod<int?>('kDecrypt_int', {"key": key, "data": data});
  }

  /// [double]
  @override
  Future<String?> encryptdouble({required String key, required double data}) async {
    return await methodChannel.invokeMethod<String?>('kDecrypt_double', {"key": key, "data": data});
  }

  @override
  Future<double?> decryptdouble({required String key, required String data}) async {
    return await methodChannel.invokeMethod<double?>('kDecrypt_double', {"key": key, "data": data});
  }
}
