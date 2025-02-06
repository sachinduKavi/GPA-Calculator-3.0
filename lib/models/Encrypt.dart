import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptionHelper {
  static final encrypt.Key key =
      encrypt.Key.fromUtf8("12345678901234567890123456789012"); // 32 bytes key
  static final encrypt.IV iv =
      encrypt.IV.fromUtf8("1234567890123456"); // Initialization Vector

  static String encryptData(String plainText) {
    final encrypter =
        encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64; // Return as base64 string
  }

  static String decryptData(String encryptedText) {
    final encrypter =
        encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
    final decrypted = encrypter.decrypt64(encryptedText, iv: iv);
    return decrypted; // Return the original plain text
  }
}
