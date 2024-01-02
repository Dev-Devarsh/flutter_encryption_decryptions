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

  Future<String?> encrypt({required String key,required String data}) {
    throw UnimplementedError('encrypt() has not been implemented.');
  }
  Future<String?> decrypt({required String key, required String data}) {
    throw UnimplementedError('decrypt() has not been implemented.');
  }
}
