// // lib/core/services/auth_service.dart

// import 'dart:convert';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:http/http.dart' as http;
// import '../../utils/jwt_utils.dart';

// class AuthService {
//   static const String _baseUrl = 'http://192.168.66.220:3000/api';
//   static final FlutterSecureStorage storage = FlutterSecureStorage();

//   /// Login and store JWT + userId
//   static Future<bool> login(String identifier) async {
//     final res = await http.post(
//       Uri.parse('$_baseUrl/auth/login'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'identifier': identifier}),
//     );
//     if (res.statusCode != 200) return false;
//     final body = jsonDecode(res.body) as Map<String, dynamic>;
//     final token = body['token'] as String;
//     await storage.write(key: 'jwt', value: token);
//     final payload = JwtUtils.parseJwt(token);
//     await storage.write(key: 'userId', value: payload['userId'].toString());
//     return true;
//   }

//   /// Retrieve stored JWT
//   static Future<String?> getJwt() => storage.read(key: 'jwt');

//   /// Retrieve stored userId
//   static Future<String?> getUserId() => storage.read(key: 'userId');

//   /// Clear credentials
//   static Future<void> logout() async {
//     await storage.delete(key: 'jwt');
//     await storage.delete(key: 'userId');
//   }
// }
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
  static Future<void> clearAll() => _storage.deleteAll();
}

