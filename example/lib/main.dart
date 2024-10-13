import 'package:encryption_decryptions/encryption_decryptions.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String enctyptDectyptkey = "hnbTojntU7u";
  final EncryptionDecryptions _encryptionDecryptions = EncryptionDecryptions();
  Map<dynamic, dynamic> jsonData = {
    "name": "John",
    "surname": null,
    "age": 22,
    "hobies": ["Swimming", "football"]
  };

  String stringData = "I am dev";

  String? encryptedJson = "";
  String? encryptedString = "";

  Future<String?> encryptSring({required String key, required String data}) async {
    return await _encryptionDecryptions.encryptSring(data: data, key: key);
  }

  decryptString({required String key, required String data}) async {
    return await _encryptionDecryptions.decryptString(data: data, key: key);
  }

  encryptJson({required String key, required Map<dynamic, dynamic> data}) async {
    return await _encryptionDecryptions.encryptMap(data: data, key: key);
  }

  Future<Map<dynamic, dynamic>?> decryptJson({required String key, required String data}) async {
    return await _encryptionDecryptions.decryptMap(data: data, key: key);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Enctypt Decrypt',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Secure App'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.grey[200]!,
                  alignment: Alignment.topCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Json",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        jsonData.toString(),
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 20),
                      const Divider(),
                      Text(
                        encryptedJson ?? "",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FilledButton(
                            onPressed: () async {
                              /// Encode your data into with [jsonEncode] before encrpting it
                              encryptedJson = await encryptJson(key: enctyptDectyptkey, data: jsonData);
                              setState(() {});
                            },
                            child: const Text('Encrypt Json Data'),
                          ),
                          FilledButton(
                            onPressed: () async {
                              if (encryptedJson == null) return;
                              jsonData = await decryptJson(key: enctyptDectyptkey, data: encryptedJson!) ??
                                  <String, dynamic>{};
                              setState(() {});
                            },
                            child: const Text('Decrypt Json Data'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.grey[200]!,
                  alignment: Alignment.topCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "String",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        stringData,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 10),
                      const Divider(),
                      Text(
                        encryptedString.toString(),
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FilledButton(
                            onPressed: () async {
                              /// Encypt plain text
                              encryptedString = await encryptSring(key: enctyptDectyptkey, data: stringData);
                              setState(() {});
                            },
                            child: const Text('Encrypt Plain Text'),
                          ),
                          FilledButton(
                            onPressed: () async {
                              if (encryptedString == null) return;

                              stringData =
                                  await decryptString(key: enctyptDectyptkey, data: encryptedString!);
                              setState(() {});
                            },
                            child: const Text('Decrypt Plain Text'),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
