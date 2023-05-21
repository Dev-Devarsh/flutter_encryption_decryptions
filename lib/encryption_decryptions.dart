import 'encryption_decryptions_platform_interface.dart';

class EncryptionDecryptions {
  Future<String?> getEncryptedData({required String data, required String key}) {
    return EncryptionDecryptionsPlatform.instance.encryptData(data: data, key: key);
  }
  Future<String?> getDecryptedData({required String data, required String key}) {
    return EncryptionDecryptionsPlatform.instance.decryptData(data: data, key: key);
  }
}
