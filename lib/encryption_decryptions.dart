import 'encryption_decryptions_platform_interface.dart';

class EncryptionDecryptions {
  Future<String?> encryptSring({required String key, required String data}) {
    return EncryptionDecryptionsPlatform.instance.encryptString(key: key, data: data);
  }

  Future<String?> decryptString({required String key, required String data}) {
    return EncryptionDecryptionsPlatform.instance.decryptString(key: key, data: data);
  }

  Future<String?> encryptMap({required String key, required Map<dynamic, dynamic> data}) {
    return EncryptionDecryptionsPlatform.instance.encryptMap(key: key, data: data);
  }

  Future<Map<dynamic, dynamic>?> decryptMap({required String key, required String data}) {
    return EncryptionDecryptionsPlatform.instance.decryptMap(key: key, data: data);
  }

  Future<String?> encryptList({required String key, required List<dynamic> data}) {
    return EncryptionDecryptionsPlatform.instance.encryptList(key: key, data: data);
  }

  Future<List<dynamic>?> decryptList({required String key, required String data}) {
    return EncryptionDecryptionsPlatform.instance.decryptList(key: key, data: data);
  }

  Future<String?> encryptInt({required String key, required int data}) {
    return EncryptionDecryptionsPlatform.instance.encryptInt(key: key, data: data);
  }

  Future<int?> decryptInt({required String key, required String data}) {
    return EncryptionDecryptionsPlatform.instance.decryptInt(key: key, data: data);
  }

  Future<String?> encryptdouble({required String key, required double data}) {
    return EncryptionDecryptionsPlatform.instance.encryptdouble(key: key, data: data);
  }

  Future<double?> decryptdouble({required String key, required String data}) {
    return EncryptionDecryptionsPlatform.instance.decryptdouble(key: key, data: data);
  }
}
