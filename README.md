# encryption_decryptions

## Platform Support

| Android | iOS 
| :-----: | :-:
|   ✅    | ✅

## ⚠️⚠️⚠️⚠️⚠️

 **Mandatory Steps for Android**

Inside your android > app > src > main > AndroidManifest.xml file. Add below lines
 `tools:replace="android:label"` inside your `application` tag & add `xmlns:tools="http://schemas.android.com/tools"` to your `manifest` tag

If you forget to add this you will get build error for tools:replace="android:label"

## ⚠️⚠️⚠️⚠️⚠️

> **Note**
>
> Ensure that requests you are going to encrypt should not conatain any null value or resposne that you are going to decrypt should not have null values


### Heighlight

> Used rncryptor native dependency for fast execuation
> Took only **50ms** to encrypt or decrypt large data

> Every time you encrypt the same data you got different output so it's very hard to predict what is the information

## Usage

```dart
import 'dart:convert';

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
  final Map<String, dynamic> mockData = {
    "name": "John",
    "surname": "Doe",
    "age": 22,
    "hobies": ["Swimming", "football"]
  };
  final String mockPlain = "I am dev";

  String encryptedPlainText = "", displayPlaint = "";

  _encryptData({required String key, required String data}) async {
    return await _encryptionDecryptions.encrypt(data: data, key: key) ?? "";
  }

  _decryptData({required String key, required String data}) async {
    return await _encryptionDecryptions.decrypt(data: data, key: key) ?? "";
  }

  String encryptedJsonData = "", displayJsonData = "";

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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        encryptedJsonData,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 20),
                      const Divider(),
                      Text(
                        displayJsonData,
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
                              encryptedJsonData = await _encryptData(key: enctyptDectyptkey, data: jsonEncode(mockData));
                              setState(() {});
                            },
                            child: const Text('Encrypt Json Data'),
                          ),
                          FilledButton(
                            onPressed: () async {
                              displayJsonData = await _decryptData(key: enctyptDectyptkey, data: encryptedJsonData);
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        encryptedPlainText,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 20),
                      const Divider(),
                      Text(
                        displayPlaint,
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
                              encryptedPlainText = await _encryptData(key: enctyptDectyptkey, data: mockPlain);
                              setState(() {});
                            },
                            child: const Text('Encrypt Plain Text'),
                          ),
                          FilledButton(
                            onPressed: () async {
                              displayPlaint = await _decryptData(key: enctyptDectyptkey, data: encryptedPlainText);
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


```