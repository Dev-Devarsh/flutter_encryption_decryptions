import 'dart:async';
import 'dart:js_interop';

import 'package:encryption_decryptions/encryption_decryptions_platform_interface.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:web/web.dart' as web;

// External definitions for your global JavaScript functions
@JS('encryptString')
external JSString _encryptString(JSString key, JSString data);

@JS('decryptString')
external JSString _decryptString(JSString key, JSString encryptedData);

// ... (all other @JS external definitions remain the same) ...
@JS('encryptMap')
external JSString _encryptMap(JSString key, JSAny data);

@JS('decryptMap')
external JSAny _decryptMap(JSString key, JSString encryptedData);

@JS('encryptList')
external JSString _encryptList(JSString key, JSAny data);

@JS('decryptList')
external JSAny _decryptList(JSString key, JSString encryptedData);

@JS('encryptInt')
external JSString _encryptInt(JSString key, JSNumber data);

@JS('decryptInt')
external JSNumber _decryptInt(JSString key, JSString encryptedData);

@JS('encryptDouble')
external JSString _encryptDouble(JSString key, JSNumber data);

@JS('decryptDouble')
external JSNumber _decryptDouble(JSString key, JSString encryptedData);

class EncryptionDecryptionsPluginCApi extends EncryptionDecryptionsPlatform {
  static final Completer<void> _scriptsCompleter = Completer();

  EncryptionDecryptionsPluginCApi() {
    _injectScripts();
  }

  static void registerWith(Registrar registrar) {
    EncryptionDecryptionsPlatform.instance = EncryptionDecryptionsPluginCApi();
  }

  static Future<void> _injectScripts() async {
    if (_scriptsCompleter.isCompleted) return _scriptsCompleter.future;

    final cryptoJsScript = web.document.createElement('script') as web.HTMLScriptElement
      ..src = 'assets/packages/encryption_decryptions/web/crypto-js.min.js'
      ..async = true;

    final appCryptoScript = web.document.createElement('script') as web.HTMLScriptElement
      ..src = 'assets/packages/encryption_decryptions/web/app-crypto.js'
      ..async = true;

    // This is the corrected error handler, now a proper function declaration.
    void handleError(web.Event event) {
      if (!_scriptsCompleter.isCompleted) {
        _scriptsCompleter.completeError(Exception('Failed to load crypto scripts'));
      }
    }

    web.document.head!.append(cryptoJsScript);

    cryptoJsScript.onLoad.listen((_) {
      web.document.head!.append(appCryptoScript);
    });

    appCryptoScript.onLoad.listen((_) {
      if (!_scriptsCompleter.isCompleted) _scriptsCompleter.complete();
    });

    cryptoJsScript.onError.listen(handleError);
    appCryptoScript.onError.listen(handleError);

    return _scriptsCompleter.future;
  }

  // All the override methods below remain exactly the same.
  // ... (omitted for brevity) ...

  @override
  Future<String?> encryptString({required String key, required String data}) async {
    await _scriptsCompleter.future;
    return _encryptString(key.toJS, data.toJS).toDart;
  }

  @override
  Future<String?> decryptString({required String key, required String data}) async {
    await _scriptsCompleter.future;
    return _decryptString(key.toJS, data.toJS).toDart;
  }

  @override
  Future<String?> encryptMap({required String key, required Map<dynamic, dynamic> data}) async {
    await _scriptsCompleter.future;
    // The jsify extension correctly handles the conversion.
    return _encryptMap(key.toJS, data.jsify()!).toDart;
  }

  @override
  Future<Map?> decryptMap({required String key, required String data}) async {
    await _scriptsCompleter.future;
    final decrypted = _decryptMap(key.toJS, data.toJS);
    // The dartify extension correctly handles the conversion back.
    return decrypted.dartify() as Map?;
  }

  @override
  Future<String?> encryptList({required String key, required List<dynamic> data}) async {
    await _scriptsCompleter.future;
    return _encryptList(key.toJS, data.jsify()!).toDart;
  }

  @override
  Future<List?> decryptList({required String key, required String data}) async {
    await _scriptsCompleter.future;
    final decrypted = _decryptList(key.toJS, data.toJS);
    return decrypted.dartify() as List?;
  }

  @override
  Future<String?> encryptInt({required String key, required int data}) async {
    await _scriptsCompleter.future;
    return _encryptInt(key.toJS, data.toJS).toDart;
  }

  @override
  Future<int?> decryptInt({required String key, required String data}) async {
    await _scriptsCompleter.future;
    return _decryptInt(key.toJS, data.toJS).toDartInt;
  }

  @override
  Future<String?> encryptdouble({required String key, required double data}) async {
    await _scriptsCompleter.future;
    return _encryptDouble(key.toJS, data.toJS).toDart;
  }

  @override
  Future<double?> decryptdouble({required String key, required String data}) async {
    await _scriptsCompleter.future;
    return _decryptDouble(key.toJS, data.toJS).toDartDouble;
  }
}
