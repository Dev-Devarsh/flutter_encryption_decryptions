import Flutter
import UIKit
import RNCryptor

public class EncryptionDecryptionsIOSPlugin: NSObject, FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "encryption_decryptions", binaryMessenger: registrar.messenger())
        let instance = EncryptionDecryptionsIOSPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "kEncrypt_string" {
            guard let args = call.arguments as? [String: String] else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Arguments not provided", details: nil))
                return
            }
            
            let key = args["key"]!
            let jsonData = args["data"]!
            
            do {
                let ciphertext = RNCryptor.encrypt(data: Data(jsonData.utf8), withPassword: key)
                result(ciphertext.base64EncodedString())  // Pass the base64-encoded string
            } catch {
                result(FlutterError(code: "ENCRYPTION_FAILED", message: "Encryption failed", details: error.localizedDescription))
            }
            
        } else if call.method == "kDecrypt_string" {
            guard let args = call.arguments as? [String: String] else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Arguments not provided", details: nil))
                return
            }
            
            let key = args["key"]!
            let encryptString = args["data"]!
            
            do {
                guard let responseData = Data(base64Encoded: encryptString) else {
                    result(FlutterError(code: "DECODE_FAILED", message: "Base64 decoding failed", details: nil))
                    return
                }
                
                let decryptData = try RNCryptor.decrypt(data: responseData, withPassword: key)
                let decryptedString = String(data: decryptData, encoding: .utf8)
                result(decryptedString)
                
            } catch {
                result(FlutterError(code: "DECRYPTION_FAILED", message: "Decryption failed", details: error.localizedDescription))
            }
            
        } else if call.method == "kEncrypt_map" {
            guard let args = call.arguments as? [String: Any],
                  let key = args["key"] as? String,
                  let jsonData = args["data"] as? [String: Any] else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid arguments provided", details: nil))
                return
            }
            
            do {
                let data = try JSONSerialization.data(withJSONObject: jsonData, options: [])
                let ciphertext = RNCryptor.encrypt(data: data, withPassword: key)
                result(ciphertext.base64EncodedString())
            } catch {
                result(FlutterError(code: "ENCRYPTION_FAILED", message: "Encryption failed", details: error.localizedDescription))
            }
            
        } else if call.method == "kDecrypt_map" {
            guard let args = call.arguments as? [String: Any],
                  let key = args["key"] as? String,
                  let encryptString = args["data"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid arguments provided", details: nil))
                return
            }
            
            do {
                guard let encryptedData = Data(base64Encoded: encryptString) else {
                    result(FlutterError(code: "DECODE_FAILED", message: "Base64 decoding failed", details: nil))
                    return
                }
                
                let decryptedData = try RNCryptor.decrypt(data: encryptedData, withPassword: key)
                let jsonObject = try JSONSerialization.jsonObject(with: decryptedData, options: [])
                
                if let map = jsonObject as? [String: Any] {
                    result(map)
                } else {
                    result(FlutterError(code: "INVALID_DATA", message: "Decrypted data is not a valid map", details: nil))
                }
            } catch {
                result(FlutterError(code: "DECRYPTION_FAILED", message: "Decryption failed", details: error.localizedDescription))
            }
            
        } else if call.method == "kEncrypt_list" {
            // Encrypt a list (array)
            guard let args = call.arguments as? [String: Any],
                  let key = args["key"] as? String,
                  let jsonList = args["data"] as? [Any] else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid arguments provided", details: nil))
                return
            }
            
            do {
                let data = try JSONSerialization.data(withJSONObject: jsonList, options: [])
                let ciphertext = RNCryptor.encrypt(data: data, withPassword: key)
                result(ciphertext.base64EncodedString())
            } catch {
                result(FlutterError(code: "ENCRYPTION_FAILED", message: "Encryption failed", details: error.localizedDescription))
            }
            
        } else if call.method == "kDecrypt_list" {
            // Decrypt a list (array)
            guard let args = call.arguments as? [String: Any],
                  let key = args["key"] as? String,
                  let encryptString = args["data"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid arguments provided", details: nil))
                return
            }
            
            do {
                guard let encryptedData = Data(base64Encoded: encryptString) else {
                    result(FlutterError(code: "DECODE_FAILED", message: "Base64 decoding failed", details: nil))
                    return
                }
                
                let decryptedData = try RNCryptor.decrypt(data: encryptedData, withPassword: key)
                let jsonArray = try JSONSerialization.jsonObject(with: decryptedData, options: [])
                
                if let list = jsonArray as? [Any] {
                    result(list)
                } else {
                    result(FlutterError(code: "INVALID_DATA", message: "Decrypted data is not a valid list", details: nil))
                }
            } catch {
                result(FlutterError(code: "DECRYPTION_FAILED", message: "Decryption failed", details: error.localizedDescription))
            }
            
        }else if call.method == "kEncrypt_int" {
            // Encrypt an integer value
            guard let args = call.arguments as? [String: Any],
                  let key = args["key"] as? String,
                  let intValue = args["intData"] as? Int else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid arguments provided", details: nil))
                return
            }
            
            do {
                let data = withUnsafeBytes(of: intValue) { Data($0) }
                let ciphertext = RNCryptor.encrypt(data: data, withPassword: key)
                result(ciphertext.base64EncodedString())
            } catch {
                result(FlutterError(code: "ENCRYPTION_FAILED", message: "Encryption failed", details: error.localizedDescription))
            }
            
        } else if call.method == "kDecrypt_int" {
            // Decrypt an integer value
            guard let args = call.arguments as? [String: Any],
                  let key = args["key"] as? String,
                  let encryptString = args["encryptString"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid arguments provided", details: nil))
                return
            }
            
            do {
                guard let encryptedData = Data(base64Encoded: encryptString) else {
                    result(FlutterError(code: "DECODE_FAILED", message: "Base64 decoding failed", details: nil))
                    return
                }
                
                let decryptedData = try RNCryptor.decrypt(data: encryptedData, withPassword: key)
                let intValue = decryptedData.withUnsafeBytes { $0.load(as: Int.self) }
                result(intValue)
            } catch {
                result(FlutterError(code: "DECRYPTION_FAILED", message: "Decryption failed", details: error.localizedDescription))
            }
        }
        else if call.method == "kEncrypt_double" {
            // Encrypt a double value
            guard let args = call.arguments as? [String: Any],
                  let key = args["key"] as? String,
                  let doubleValue = args["doubleData"] as? Double else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid arguments provided", details: nil))
                return
            }
            
            do {
                let data = withUnsafeBytes(of: doubleValue) { Data($0) }
                let ciphertext = RNCryptor.encrypt(data: data, withPassword: key)
                result(ciphertext.base64EncodedString())
            } catch {
                result(FlutterError(code: "ENCRYPTION_FAILED", message: "Encryption failed", details: error.localizedDescription))
            }
            
        } else if call.method == "kDecrypt_double" {
            // Decrypt a double value
            guard let args = call.arguments as? [String: Any],
                  let key = args["key"] as? String,
                  let encryptString = args["encryptString"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid arguments provided", details: nil))
                return
            }
            
            do {
                guard let encryptedData = Data(base64Encoded: encryptString) else {
                    result(FlutterError(code: "DECODE_FAILED", message: "Base64 decoding failed", details: nil))
                    return
                }
                
                let decryptedData = try RNCryptor.decrypt(data: encryptedData, withPassword: key)
                let doubleValue = decryptedData.withUnsafeBytes { $0.load(as: Double.self) }
                result(doubleValue)
            } catch {
                result(FlutterError(code: "DECRYPTION_FAILED", message: "Decryption failed", details: error.localizedDescription))
            }}
        else {
            result(FlutterMethodNotImplemented)
        }
    }
}
