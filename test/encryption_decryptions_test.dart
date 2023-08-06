import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:encryption_decryptions/encryption_decryptions_platform_interface.dart';
import 'package:encryption_decryptions/encryption_decryptions_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockEncryptionDecryptionsPlatform with MockPlatformInterfaceMixin implements EncryptionDecryptionsPlatform {

  @override
  Future<String?> decryptData({required String data, required String key}) async {
    await EncryptionDecryptionsPlatform.instance.decryptData(data: "AGNdfsjasfefausefhleskugfesilufg", key: "key");
    throw UnimplementedError();
  }

  @override
  Future<String?> encryptData({required String data, required String key}) async {
    await EncryptionDecryptionsPlatform.instance.encryptData(data: jsonEncode({"name": "dev"}), key: "key");
    throw UnimplementedError();
  }
}

void main() {
  final EncryptionDecryptionsPlatform initialPlatform = EncryptionDecryptionsPlatform.instance;

  test('$EncryptDecrypt is the default instance', () {
    expect(initialPlatform, isInstanceOf<EncryptDecrypt>());
  });

  test('getEncryptedString', () async {
    MockEncryptionDecryptionsPlatform fakePlatform = MockEncryptionDecryptionsPlatform();
    EncryptionDecryptionsPlatform.instance = fakePlatform;

    expect(await EncryptionDecryptionsPlatform.instance.encryptData(data: jsonEncode({"name": "dev"}), key: "key"), '42');
  });
}
