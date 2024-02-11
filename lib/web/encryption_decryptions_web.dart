// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter

import 'dart:developer';

import 'package:encryption_decryptions/platform_interface/encryption_decryptions_platform_interface.dart';
import 'package:encryption_decryptions/web/js/crypto_js.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
// import 'package:encryption_decryptions/web/crypto_js.dart';

/// A web implementation of the FlutterEncryptionDecryptionsPlatform of the FlutterEncryptionDecryptions plugin.
class EncryptionDecryptionsWeb extends EncryptionDecryptionsPlatform {
  /// Constructs a FlutterEncryptionDecryptionsWeb
  EncryptionDecryptionsWeb();
  static void registerWith(Registrar registrar) {
    EncryptionDecryptionsPlatform.instance = EncryptionDecryptionsWeb();
  }

  @override
  Future<String?> decrypt({required String key, required String data}) async {
    log("$key \n $data");
    return CryptoJS.sha1(data);
  }

  @override
  Future<String?> encrypt({required String key, required String data}) async {
    log("$key \n $data");

    return CryptoJS.sha1(data);
  }
}
