import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'encryption_decryptions_method_channel.dart';

abstract class EncryptionDecryptionsPlatform extends PlatformInterface {
  /// Constructs a EncryptionDecryptionsPlatform.
  EncryptionDecryptionsPlatform() : super(token: _token);

  static final Object _token = Object();

  static EncryptionDecryptionsPlatform _instance = MethodChannelEncryptionDecryptions();

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

  Future<String?> encryptString({required String key, required String data}) {
    throw UnimplementedError('encrypt() has not been implemented.');
  }

  Future<String?> decryptString({required String key, required String data}) {
    throw UnimplementedError('decryptString() has not been implemented.');
  }

  Future<String?> encryptMap({required String key, required Map<dynamic, dynamic> data}) {
    throw UnimplementedError('decryptString() has not been implemented.');
  }

  Future<Map<dynamic, dynamic>?> decryptMap({required String key, required String data}) {
    throw UnimplementedError('decryptString() has not been implemented.');
  }

  Future<String?> encryptList({required String key, required List<dynamic> data}) {
    throw UnimplementedError('encryptList() has not been implemented.');
  }

  Future<List<dynamic>?> decryptList({required String key, required String data}) {
    throw UnimplementedError('decryptList() has not been implemented.');
  }

  Future<String?> encryptInt({required String key, required int data}) {
    throw UnimplementedError('encryptInt() has not been implemented.');
  }

  Future<int?> decryptInt({required String key, required String data}) {
    throw UnimplementedError('decryptInt() has not been implemented.');
  }

  Future<String?> encryptdouble({required String key, required double data}) {
    throw UnimplementedError('encryptdouble() has not been implemented.');
  }

  Future<double?> decryptdouble({required String key, required String data}) {
    throw UnimplementedError('decryptdouble() has not been implemented.');
  }
}
