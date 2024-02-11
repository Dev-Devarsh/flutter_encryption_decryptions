@JS()
library crypto_js;

import 'dart:js_interop';

@JS("CryptoJS")
class CryptoJS {

  @anonymous
   external static String sha1(String data);
}
