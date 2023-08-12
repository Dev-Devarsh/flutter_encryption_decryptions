import 'dart:convert';

import 'package:encryption_decryptions/encryption_decryptio.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String enctyptDectyptkey = "hnbTojntU7u";

  final Map<String, dynamic> mockData = {
    "name": "John",
    "surname": "Doe",
    "age": 22,
    "hobies": ["Swimming", "football"]
  };

  _encryptData({required String key, required String data}) {
    EncryptDecrypt.encryptData(data: data, key: key);
  }

  _decryptData({required String key, required String data}) {
    EncryptDecrypt.decryptData(data: data, key: key);
  }

  String encryptedData = "", displayData = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Enctypt Decrypt',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Secure App'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              encryptedData,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            Text(
              displayData,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: () async {
                    /// Encode your data into with [jsonEncode] before encrpting it
                    encryptedData = await _encryptData(key: enctyptDectyptkey, data: jsonEncode(mockData));
                    setState(() {});
                  },
                  child: const Text('Encrtpt Data'),
                ),
                MaterialButton(
                  onPressed: () async {
                    displayData = await _decryptData(key: enctyptDectyptkey, data: encryptedData);
                    setState(() {});
                  },
                  child: const Text('Decrtpt Data'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
