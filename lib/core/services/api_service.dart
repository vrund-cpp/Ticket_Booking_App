import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.76.220:3000/api'; // Replace with your IP
  static const storage = FlutterSecureStorage();

  static Future<bool> requestOtp(String identifier) async {
    final res = await http.post(Uri.parse('$baseUrl/request-otp'), headers: {'Content-Type': 'application/json'}, 
    body: jsonEncode({'identifier': identifier}));
    
    return res.statusCode == 200;
  }

static Future<bool> signup(String name, String email, String mobile) async {
  try {
    final res = await http.post(
      Uri.parse('$baseUrl/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'mobile': mobile,
      }),
    );

    debugPrint('📡 Signup API response: ${res.statusCode} ${res.body}');

    if (res.statusCode == 200) return true;

    final decoded = jsonDecode(res.body);
    throw Exception(decoded['message'] ?? 'Signup failed');

  } catch (e) {
    debugPrint('❌ API error: $e');
    rethrow; // let Flutter UI handle this
  }
}

  static Future<bool> verifyOtp(String identifier, String otp) async {
    final res = await http.post(Uri.parse('$baseUrl/verify-otp'),
     headers: {'Content-Type': 'application/json'},
     body: jsonEncode({'identifier': identifier, 'otp': otp}),
    );
    
    if (res.statusCode == 200) {
      // 🔐 Store token in secure storage
      final token = res.headers['authorization'] ?? '';
      await storage.write(key: 'jwt_token', value: token);
      await storage.write(key: 'user_identifier', value: identifier);
      return true;
    }
    return false;
  }

  static Future<String?> getToken() async => await storage.read(key: 'jwt_token');
  static Future<void> logout() async => await storage.deleteAll();
}

