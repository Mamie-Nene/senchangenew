import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:encrypt/encrypt.dart';

class SecureStorageService {
  static const _storage = FlutterSecureStorage();

  // AES Encryption Key (Must be 16/24/32 chars long)
  static final _key = Key.fromUtf8("16characterslong!");
  static final _encrypter = Encrypter(AES(_key));

  /// Save Encrypted Token
  static Future<void> saveToken(String key, String token) async {
    final iv = IV.fromSecureRandom(16);
    final encryptedToken = _encrypter.encrypt(token, iv: iv);
    await _storage.write(key: "${key}_data", value: encryptedToken.base64);
    await _storage.write(key: "${key}_iv", value: iv.base64);

  }

  /// Retrieve and Decrypt Token
  static Future<String?> getToken(String key) async {
    final encryptedToken = await _storage.read(key: "${key}_data");
    final ivBase64 = await _storage.read(key: "${key}_iv");
    if (encryptedToken == null || ivBase64 == null) return null;
    final iv = IV.fromBase64(ivBase64);
    return _encrypter.decrypt64(encryptedToken, iv: iv);
  }

  // Delete Token
  static Future<void> deleteToken(String key) async {
    await _storage.delete(key: "${key}_data");
    await _storage.delete(key: "${key}_iv");
  }

  // Clear All Tokens (On Logout)
  static Future<void> clearAllTokens() async {
    await _storage.deleteAll();
  }
}