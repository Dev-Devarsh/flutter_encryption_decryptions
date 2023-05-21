import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:encryption_decryptions/encryption_decryptions_method_channel.dart';

void main() {
  MethodChannelEncryptionDecryptions platform = MethodChannelEncryptionDecryptions();
  const MethodChannel channel = MethodChannel('encryption_decryptions');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });
}
