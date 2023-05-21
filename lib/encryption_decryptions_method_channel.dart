import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'encryption_decryptions_platform_interface.dart';

/// An implementation of [EncryptionDecryptionsPlatform] that uses method channels.
class MethodChannelEncryptionDecryptions implements EncryptionDecryptionsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('encryption_decryptions');

  @override
  Future<String?> encryptData({required String data, required String key}) {
    return EncryptionDecryptionsPlatform.instance.encryptData(data: data, key: key);
  }
  @override
  Future<String?> decryptData({required String data, required String key}) {
    return EncryptionDecryptionsPlatform.instance.decryptData(data: data, key: key);
  }
}
