import Flutter
import UIKit
import RNCryptor

public class EncryptionDecryptionsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "encryption_decryptions", binaryMessenger: registrar.messenger())
    let instance = EncryptionDecryptionsPlugin()
          channel.setMethodCallHandler({
        (call:FlutterMethodCall,result: @escaping FlutterResult) -> Void in
          if(call.method == "ios_encrypt"){
              guard let args = call.arguments as? [String:String] else {return};
              let key = args["key"]!;
              let jsonData = args["jsonData"]!;
              let rawData = Data(jsonData.utf8)
              do {
                  let ciphertext = RNCryptor.encrypt(data: rawData, withPassword: key);             
                  result("\(ciphertext.base64EncodedString().utf8)");
              } catch {
                  result(nil)
                  debugPrint(error.localizedDescription)
              }

          }
          if(call.method == "ios_decrypt"){
              guard let args = call.arguments as? [String:String] else {return};
              let key = args["key"]!;
              let encryptString = args["encryptString"]!;
              let rawData = Data(encryptString.utf8);
              
              do {                
                  let responseString = Data(base64Encoded: encryptString)
                  let decryptData = try RNCryptor.decrypt(data: responseString!, withPassword: key);
                  do {
                      let dict = try JSONSerialization.jsonObject(with: decryptData, options: [.fragmentsAllowed])
                      result(dict);
                  } catch {
                    debugPrint(error.localizedDescription)
                    result(nil)
                  }
                  
              }
              catch {
                  debugPrint(error.localizedDescription)
                  result(nil)
              }
          };
      });  
    registrar.addMethodCallDelegate(instance, channel: channel)
  }
}
