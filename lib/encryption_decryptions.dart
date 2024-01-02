
import 'encryption_decryptions_platform_interface.dart';

class EncryptionDecryptions {
  Future<String?> encrypt({required String key, required String data}) {
    return EncryptionDecryptionsPlatform.instance.encrypt(key: key,data: data);
  }
  Future<String?> decrypt({required String key, required String data}){
    return EncryptionDecryptionsPlatform.instance.decrypt(key: key,data: data);
  }
}
