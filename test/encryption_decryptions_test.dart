import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:encryption_decryptions/encryption_decryptions.dart';
import 'package:encryption_decryptions/encryption_decryptions_platform_interface.dart';
import 'package:encryption_decryptions/encryption_decryptions_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockEncryptionDecryptionsPlatform with MockPlatformInterfaceMixin implements EncryptionDecryptionsPlatform {

  @override
  Future<String?> decryptData({required String data, required String key}) async {
    EncryptionDecryptions encryptionDecryptionsPlugin = EncryptionDecryptions();
    await encryptionDecryptionsPlugin.getDecryptedData(data: "AGNdfsjasfefausefhleskugfesilufg", key: "key");
    throw UnimplementedError();
  }

  @override
  Future<String?> encryptData({required String data, required String key}) async {
    EncryptionDecryptions encryptionDecryptionsPlugin = EncryptionDecryptions();
    await encryptionDecryptionsPlugin.getEncryptedData(data: jsonEncode({"name": "dev"}), key: "key");
    throw UnimplementedError();
  }
}

void main() {
  final EncryptionDecryptionsPlatform initialPlatform = EncryptionDecryptionsPlatform.instance;

  test('$MethodChannelEncryptionDecryptions is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelEncryptionDecryptions>());
  });

  test('getEncryptedString', () async {
    EncryptionDecryptions encryptionDecryptionsPlugin = EncryptionDecryptions();
    MockEncryptionDecryptionsPlatform fakePlatform = MockEncryptionDecryptionsPlatform();
    EncryptionDecryptionsPlatform.instance = fakePlatform;

    expect(await encryptionDecryptionsPlugin.getEncryptedData(data: jsonEncode({"name": "dev"}), key: "key"), '42');
  });
}
