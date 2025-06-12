// File: lib/core/services/auth_service.dart

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  // Secure storage instance for token + userId
  static const _storage = FlutterSecureStorage();

  /// Write JWT into secure storage
  static Future<void> saveToken(String token) =>
      _storage.write(key: 'jwt', value: token);

  /// Read JWT (or null if not yet stored)
  static Future<String?> getToken() => _storage.read(key: 'jwt');

  /// Write userId into secure storage
  static Future<void> saveUserId(String userId) =>
      _storage.write(key: 'userId', value: userId);

  /// Read userId
  static Future<String?> getUserId() => _storage.read(key: 'userId');

  /// Clear everything (for logout)
  static Future<void> clearAll() async{
    await _storage.delete(key: 'jwt');
    await _storage.delete(key: 'userId');
  }
}

