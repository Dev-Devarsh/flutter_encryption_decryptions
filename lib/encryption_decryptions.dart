import 'encryption_decryptions_platform_interface.dart';

class EncryptionDecryptions {
 static Future<String?> getEncryptedData({required String data, required String key}) {
    return EncryptionDecryptionsPlatform.instance.encryptData(data: data, key: key);
  }
static  Future<String?> getDecryptedData({required String data, required String key}) {
    return EncryptionDecryptionsPlatform.instance.decryptData(data: data, key: key);
  }
}
