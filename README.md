# encryption_decryptions

# connectivity_plus

[![Flutter Community: connectivity_plus](https://fluttercommunity.dev/_github/header/connectivity_plus)](https://github.com/fluttercommunity/community)

[![pub package](https://img.shields.io/pub/v/connectivity_plus.svg)](https://pub.dev/packages/connectivity_plus)
[![pub points](https://img.shields.io/pub/points/connectivity_plus?color=2E8B57&label=pub%20points)](https://pub.dev/packages/connectivity_plus/score)
[![connectivity_plus](https://github.com/fluttercommunity/plus_plugins/actions/workflows/connectivity_plus.yaml/badge.svg)](https://github.com/fluttercommunity/plus_plugins/actions/workflows/connectivity_plus.yaml)

<p class="center">
<center><a href="https://flutter.dev/docs/development/packages-and-plugins/favorites" target="_blank" rel="noreferrer noopener"><img src="../../../website/static/img/flutter-favorite-badge.png" width="100" alt="build"></a></center>
</p>

This plugin allows Flutter apps to discover network connectivity and configure
themselves accordingly. It can distinguish between cellular vs WiFi connection.

> **Note**
>
> On Android, this does not guarantee connection to Internet. For instance, the app might have wifi access but it might be a VPN or a hotel WiFi > with no access.

## Platform Support

| Android | iOS | MacOS | Web | Linux | Windows |
| :-----: | :-: | :---: | :-: | :---: | :-----: |
|   ✅    | ✅  |  ✅   | ✅  |  ✅   |   ✅    |

## Usage

Sample usage to check current status:

```dart
import 'package:connectivity_plus/connectivity_plus.dart';

final connectivityResult = await (Connectivity().checkConnectivity());
if (connectivityResult == ConnectivityResult.mobile) {
  // I am connected to a mobile network.
} else if (connectivityResult == ConnectivityResult.wifi) {
  // I am connected to a wifi network.
} else if (connectivityResult == ConnectivityResult.ethernet) {
  // I am connected to a ethernet network.
} else if (connectivityResult == ConnectivityResult.vpn) {
  // I am connected to a vpn network.
  // Note for iOS and macOS:
  // There is no separate network interface type for [vpn].
  // It returns [other] on any device (also simulator)
} else if (connectivityResult == ConnectivityResult.bluetooth) {
  // I am connected to a bluetooth.
} else if (connectivityResult == ConnectivityResult.other) {
  // I am connected to a network which is not in the above mentioned networks.
} else if (connectivityResult == ConnectivityResult.none) {
  // I am not connected to any network.
}
```

> **Note**
>
> You should not be using the current network status for deciding whether you can reliably make a network connection. Always guard your app code against timeouts and errors that might come from the network layer.

You can also listen for network state changes by subscribing to the stream
exposed by connectivity plugin:

```dart
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
```

> **Note**
>
> Ensure that requests you are going to encrypt should not conatain any null value or resposne that you are going to decrypt should not have null values



