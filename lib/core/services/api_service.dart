// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:ticket_booking_app/core/services/auth_service.dart';
// import '../../models/movie.dart';
// import '../../models/outreach.dart';
// import '../../models/attraction.dart';
// import '../../models/news.dart';
// import '../../models/notification_item.dart';
// import 'package:jwt_decode/jwt_decode.dart';


// class ApiService {
//   static const String baseUrl = 'http://192.168.66.220:3000/api';
//   // static const String baseUrl = 'https://ticket-booking-app-backend-0zhj.onrender.com/api'; // Replace with your IP
//   static const storage = FlutterSecureStorage();

//   static Future<bool> requestOtp(String identifier) async {
    
//     final uri = Uri.parse('$baseUrl/auth/request-otp');

//     final res = await http.post(
//       uri,
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'identifier': identifier}),
//     );
//     if (res.statusCode == 200) {
//       return true;
//     }
//     return false;
//   }

//   static Future<bool> signup(String name, String email, String mobile) async {
//     try {
//       final uri = Uri.parse('$baseUrl/auth/signup');
//       final res = await http.post(
//         uri,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'name': name, 'email': email, 'mobile': mobile}),
//       );

//       debugPrint('📡 Signup API response: ${res.statusCode} ${res.body}');

//       final body = jsonDecode(res.body) as Map<String, dynamic>;

//       if (res.statusCode == 200) return true;

//       final msg = body['message'] as String? ?? 'Unknown error';
//       throw Exception(msg);
//     } catch (e) {
//       debugPrint('❌ API error: $e');
//       rethrow; // let Flutter UI handle this
//     }
//   }

//   static Future<bool> verifyOtp(String identifier, String otp) async {
    
//     final uri = Uri.parse('$baseUrl/auth/verify-otp');
    
//     final res = await http.post(
//       uri,
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'identifier': identifier, 'otp': otp}),
//     );

//     if (res.statusCode != 200)return false; 
//       // 🔐 Store token in secure storage
//       final body = jsonDecode(res.body) as Map<String, dynamic>;
//       final token = body['token'] as String;
//       final payload = Jwt.parseJwt(token);
//       final userId = payload['userId'].toString();

//       await AuthService.storage.write(key:'jwt', value:token);
//       await AuthService.storage.write(key:'userId', value:userId);
//       return true;
//   }
//   /// Fetch latest 5 movies
//   static Future<List<Movie>> fetchLatestMovies() async {
//     final response = await http.get(Uri.parse('$baseUrl/movies/latest'));
//     if (response.statusCode == 200) {
//       final List jsonData = json.decode(response.body);
//       return jsonData.map((item) => Movie.fromJson(item)).toList();
//     } else {
//       throw Exception('Failed to fetch latest movies');
//     }
//   }

// /// fetch All movies
//   static Future<List<Movie>> fetchAllMovies() async {
//     final resp = await http.get(Uri.parse('$baseUrl/movies'));
//     if (resp.statusCode==200) {
//       final data = jsonDecode(resp.body) as List;
//       return data.map((e)=>Movie.fromJson(e)).toList();
//     }
//     throw Exception('Failed');
//   }

//   /// Fetch latest 5 outreach programs
//   static Future<List<Outreach>> fetchLatestOutreach() async {
//     final response = await http.get(Uri.parse('$baseUrl/outreach/latest'));
//     if (response.statusCode == 200) {
//       final List jsonData = json.decode(response.body);
//       return jsonData.map((item) => Outreach.fromJson(item)).toList();
//     } else {
//       throw Exception('Failed to fetch latest outreach programs');
//     }
//   }

//   /// Fetch All outreach programs
//   static Future<List<Outreach>> fetchAllOutreach() async {
//     final resp = await http.get(Uri.parse('$baseUrl/outreach'));
//     if (resp.statusCode==200) {
//       final data = jsonDecode(resp.body) as List;
//       return data.map((e)=>Outreach.fromJson(e)).toList();
//     }
//     throw Exception('Failed');
//   }

//   /// Fetch latest 5 attractions
//   static Future<List<Attraction>> fetchLatestAttractions() async {
//     final response = await http.get(
//       Uri.parse('$baseUrl/attractions/latest'),
//     );
//     if (response.statusCode == 200) {
//       final List jsonData = json.decode(response.body);
//       return jsonData.map((item) => Attraction.fromJson(item)).toList();
//     } else {
//       throw Exception('Failed to fetch latest attractions');
//     }
//   }

//   /// Fetch All Attractions
//     static Future<List<Attraction>> fetchAllAttractions() async {
//     final resp = await http.get(Uri.parse('$baseUrl/api/attractions'));
//     if (resp.statusCode==200) {
//       final data = jsonDecode(resp.body) as List;
//       return data.map((e)=>Attraction.fromJson(e)).toList();
//     }
//     throw Exception('Failed');
//   }

//   /// Fetch latest 5 news items
//   static Future<List<News>> fetchLatestNews() async {
//     final response = await http.get(Uri.parse('$baseUrl/api/news/latest'));
//     if (response.statusCode == 200) {
//       final List jsonData = json.decode(response.body);
//       return jsonData.map((item) => News.fromJson(item)).toList();
//     } else {
//       throw Exception('Failed to fetch latest news');
//     }
//   }

//   /// Fetch all news
//   static Future<List<News>> fetchAllNews() async {
//     final resp = await http.get(Uri.parse('$baseUrl/news'));
//     if (resp.statusCode==200) {
//       final data = jsonDecode(resp.body) as List;
//       return data.map((e)=>News.fromJson(e)).toList();
//     }
//     throw Exception('Failed');
//   }

//   static Future<int> getUnreadCount() async {
//     final token = await AuthService.getJwt();
//     final resp = await http.get(
//       Uri.parse('$baseUrl/notifications/count'),
//       headers: { 'Authorization':'Bearer $token' },
//     );
//     if (resp.statusCode==200) {
//       return jsonDecode(resp.body)['count'] as int;
//     }
//     throw Exception('Failed');
//   }

//   static Future<List<NotificationItem>> getUserNotifications() async {
//     final token = await AuthService.getJwt();
//     final resp = await http.get(
//       Uri.parse('$baseUrl/notifications'),
//       headers: { 'Authorization':'Bearer $token' },
//     );
//     if (resp.statusCode==200) {
//       final data = jsonDecode(resp.body) as List;
//       return data.map((e)=>NotificationItem.fromJson(e)).toList();
//     }
//     throw Exception('Failed');
//   }

//   static Future<void> markAllNotificationsRead() async {
//     final token = await AuthService.getJwt();
//     final resp = await http.post(
//       Uri.parse('$baseUrl/notifications/mark-read'),
//       headers: { 'Authorization':'Bearer $token' },
//     );
//     if (resp.statusCode!=200) throw Exception('Failed');
//   }
// }

// File: lib/core/services/api_service.dart

import 'dart:convert';
// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'auth_service.dart';
import '../../models/movie.dart';
import '../../models/outreach.dart';
import '../../models/attraction.dart';
import '../../models/news.dart';
import '../../models/notification_item.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  //  static const String baseUrl = 'http://192.168.76.220:3000/api';
static const String baseUrl = 'https://ticket-booking-app-backend-0zhj.onrender.com/api'; // Replace with your IP

  // static String get _host {
    // if (Platform.isAndroid) {
    //   // Android emulator → accesses host PC’s localhost
    //   return '10.0.2.2:3000';
    // } else if (Platform.isIOS) {
    //   // iOS Simulator → can use localhost
    //   return 'localhost:3000';
    // } else {
      // Physical device → your PC’s LAN IP
      // return '192.168.76.220:3000';
    // }
  // }

  // static String get baseUrl => 'http://192.168.75.220:3000/api';
   
   static const storage = FlutterSecureStorage();

  static const _jsonHeaders = {
    'Content-Type': 'application/json'
  };

  static Future<bool> requestOtp(String identifier) async {
    final uri = Uri.parse('$baseUrl/auth/request-otp');
    final resp = await http.post(uri,
      headers: _jsonHeaders,
      body: jsonEncode({'identifier': identifier}),
    );
    return resp.statusCode == 200;
  }

  static Future<bool> signup(String name, String email, String mobile) async {
    
    try{
    final uri = Uri.parse('$baseUrl/auth/signup');
    final resp = await http.post(uri,
      headers: _jsonHeaders,
      body: jsonEncode({'name': name.trim(), 'email': email.trim(), 'mobile': mobile.trim()}),
    );
    if (resp.statusCode == 200) return true;

    // If HTML (DOCTYPE) comes back, you hit wrong URL—fail fast
    final body = resp.body;
    if (body.startsWith('<!DOCTYPE')) {
      throw Exception('Server responded with HTML—check your baseUrl or endpoint!');
    }
    final map = jsonDecode(body) as Map<String, dynamic>;
    throw Exception(map['message'] ?? 'Signup failed');

    } catch (e) {
    debugPrint('❌ API error: $e');
    rethrow; // let Flutter UI handle this
    }
    

  }

/// Sends an OTP to an existing user (by email or mobile).
  /// Returns true if the server responded 200.
  static Future<bool> login(String identifier) async {
    final uri = Uri.parse('$baseUrl/auth/login');
    final resp = await http.post(uri,
      headers: _jsonHeaders,
      body: jsonEncode({'email': identifier.trim()}),
    );
    if (resp.statusCode == 200) {
      return true;
    } else {
      debugPrint('❌ Login API error: ${resp.statusCode} ${resp.body}');
    final map = jsonDecode(resp.body) as Map<String, dynamic>;
    throw Exception(map['message'] ?? 'Login failed');
    }
  }

  static Future<bool> verifyOtp(String identifier, String otp) async {
    final uri = Uri.parse('$baseUrl/auth/verify-otp');
    final resp = await http.post(uri,
      headers: _jsonHeaders,
      body: jsonEncode({'identifier': identifier.trim(), 'otp': otp.trim()}),
    );
    if (resp.statusCode != 200){ 
      final b = resp.body;
      if (b.startsWith('<!DOCTYPE')) {
        throw Exception('Server returned HTML on OTP verify—check URL');
      }
      final map = jsonDecode(b) as Map<String, dynamic>;
      throw Exception(map['message'] ?? 'Invalid or expired OTP');
    }

    final map = jsonDecode(resp.body) as Map<String, dynamic>;
    final token = map['token'] as String;
    final payload = Jwt.parseJwt(token);
    final userId = payload['userId'].toString();
    await AuthService.saveToken(token);
    await AuthService.saveUserId(userId);
    return true;
  }

  static Future<String?> getToken() async => await storage.read(key: 'jwt_token');
  static Future<void> logout() async => await storage.deleteAll();

  /// Helper: attaches Bearer header if available
  static Future<Map<String,String>> _authHeaders() async {
    final token = await AuthService.getToken();
    return {
      ..._jsonHeaders,
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  static Future<List<Movie>> fetchLatestMovies() async {
    final resp = await http.get(Uri.parse('$baseUrl/movies/latest'),
      headers: await _authHeaders(),
    );
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body) as List;
      return data.map((e) => Movie.fromJson(e)).toList();
    }
    throw Exception('Failed to fetch latest movies');
  }

  static Future<List<Movie>> fetchAllMovies() async {
    final resp = await http.get(Uri.parse('$baseUrl/movies'),
      headers: await _authHeaders(),
    );
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body) as List;
      return data.map((e) => Movie.fromJson(e)).toList();
    }
    throw Exception('Failed to fetch all movies');
  }

  static Future<List<Outreach>> fetchLatestOutreach() async {
    final resp = await http.get(Uri.parse('$baseUrl/outreach/latest'),
      headers: await _authHeaders(),
    );
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body) as List;
      return data.map((e) => Outreach.fromJson(e)).toList();
    }
    throw Exception('Failed to fetch latest outreach');
  }

  static Future<List<Outreach>> fetchAllOutreach() async {
    final resp = await http.get(Uri.parse('$baseUrl/outreach'),
      headers: await _authHeaders(),
    );
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body) as List;
      return data.map((e) => Outreach.fromJson(e)).toList();
    }
    throw Exception('Failed to fetch all outreach');
  }

  static Future<List<Attraction>> fetchLatestAttractions() async {
    final resp = await http.get(Uri.parse('$baseUrl/attractions/latest'),
      headers: await _authHeaders(),
    );
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body) as List;
      return data.map((e) => Attraction.fromJson(e)).toList();
    }
    throw Exception('Failed to fetch latest attractions');
  }

  static Future<List<Attraction>> fetchAllAttractions() async {
    final resp = await http.get(Uri.parse('$baseUrl/attractions'),
      headers: await _authHeaders(),
    );
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body) as List;
      return data.map((e) => Attraction.fromJson(e)).toList();
    }
    throw Exception('Failed to fetch all attractions');
  }

  static Future<List<News>> fetchLatestNews() async {
    final resp = await http.get(Uri.parse('$baseUrl/news/latest'),
      headers: await _authHeaders(),
    );
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body) as List;
      return data.map((e) => News.fromJson(e)).toList();
    }
    throw Exception('Failed to fetch latest news');
  }

  static Future<List<News>> fetchAllNews() async {
    final resp = await http.get(Uri.parse('$baseUrl/news'),
      headers: await _authHeaders(),
    );
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body) as List;
      return data.map((e) => News.fromJson(e)).toList();
    }
    throw Exception('Failed to fetch all news');
  }

  static Future<int> getUnreadCount(String userId) async {
    final resp = await http.get(Uri.parse('$baseUrl/notifications/count'),
      headers: await _authHeaders(),
    );
    if (resp.statusCode == 200) {
      final body = jsonDecode(resp.body) as Map<String, dynamic>;
      return body['count'] as int;
    }
    throw Exception('Failed to fetch notification count');
  }

  static Future<List<NotificationItem>> getUserNotifications() async {
    final resp = await http.get(Uri.parse('$baseUrl/notifications'),
      headers: await _authHeaders(),
    );
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body) as List;
      return data.map((e) => NotificationItem.fromJson(e)).toList();
    }
    throw Exception('Failed to fetch notifications');
  }

  static Future<void> markAllNotificationsRead() async {
    final resp = await http.post(Uri.parse('$baseUrl/notifications/mark-all-read'),
      headers: await _authHeaders(),
    );
    if (resp.statusCode != 200) {
      throw Exception('Failed to mark notifications read');
    }
  }

static Future<void> markNotificationRead(int id) async {
  final resp = await http.put(
    Uri.parse('$baseUrl/notifications/mark-read/$id'),
    headers: await _authHeaders(),
  );
  if (resp.statusCode != 200) {
    throw Exception('Failed to mark notification as read');
  }
}


}

