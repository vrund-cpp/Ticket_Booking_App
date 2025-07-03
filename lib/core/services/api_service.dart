// File: lib/core/services/api_service.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:ticket_booking_app/features/booking/models/booking_history.dart';
import 'package:ticket_booking_app/features/auth/model/user.dart';
import 'package:ticket_booking_app/features/booking/providers/booking_cart_provider.dart';
import 'auth_service.dart';
import '../../features/movies/models/movie.dart';
import '../../features/outreach/models/outreach.dart';
import '../../features/attractions/model/attraction.dart';
import '../../features/news/model/news.dart';
import '../../features/notification/models/notification_item.dart';
import '../../features/entry-tickets/models/entry_ticket.dart';
import '../../features/parking-options/models/parking_option.dart';

class ApiService {
  //  static const String baseUrl = 'http://192.168.144.220:3000';
  static const String baseUrl =
      'https://ticket-booking-app-backend-0zhj.onrender.com'; // Replace with your IP

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

  //  static const _storage = FlutterSecureStorage();

  static const Map<String, String> _jsonHeaders = {
    'Content-Type': 'application/json',
  };

  /// Helper: attaches Bearer header if available
  static Future<Map<String, String>> _authHeaders() async {
    final token = await AuthService.getToken();
    return {
      ..._jsonHeaders,
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  static Future<bool> requestOtp(String identifier) async {
    final uri = Uri.parse('$baseUrl/api/auth/request-otp');
    final resp = await http.post(
      uri,
      headers: _jsonHeaders,
      body: jsonEncode({'identifier': identifier}),
    );
    return resp.statusCode == 200;
  }

  static Future<bool> signup(String name, String email, String mobile) async {
    try {
      final uri = Uri.parse('$baseUrl/api/auth/signup');
      final resp = await http.post(
        uri,
        headers: _jsonHeaders,
        body: jsonEncode({
          'name': name.trim(),
          'email': email.trim(),
          'mobile': mobile.trim(),
        }),
      );
      if (resp.statusCode == 200) return true;

      // If HTML (DOCTYPE) comes back, you hit wrong URL—fail fast
      final body = resp.body;
      if (body.startsWith('<!DOCTYPE')) {
        throw Exception(
          'Server responded with HTML—check your baseUrl or endpoint!',
        );
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
  static Future<bool> login(String input) async {
    try {
      final uri = Uri.parse('$baseUrl/api/auth/login');
      final resp = await http.post(
        uri,
        headers: _jsonHeaders,
        body: jsonEncode({'email': input.trim()}),
      );

      if (resp.statusCode == 200) {
        return true;
      } else {
        debugPrint('❌ Login API error: ${resp.statusCode} ${resp.body}');
        final map = jsonDecode(resp.body);
        throw Exception(map['message'] ?? 'Login failed');
      }
    } catch (e) {
      debugPrint('❌ API error: $e');
      rethrow;
    }
  }

  static Future<bool> verifyOtp(String identifier, String otp) async {
    final uri = Uri.parse('$baseUrl/api/auth/verify-otp');

    try {
      final resp = await http.post(
        uri,
        headers: _jsonHeaders,
        body: jsonEncode({'identifier': identifier.trim(), 'otp': otp.trim()}),
      );

      if (resp.statusCode != 200) {
        final b = resp.body;

        if (b.startsWith('<!DOCTYPE')) {
          throw Exception('Server returned HTML on OTP verify—check URL');
        }

        final map = jsonDecode(b) as Map<String, dynamic>;
        throw Exception(map['message'] ?? 'Invalid or expired OTP');
      }

      final map = jsonDecode(resp.body) as Map<String, dynamic>;
      final token = map['token'] as String;
      if (token.isEmpty) {
        throw Exception('❌ Token not received from server');
      }

      final payload = Jwt.parseJwt(token);
      final userId = payload['userId'].toString();

      await AuthService.saveToken(token);
      await AuthService.saveUserId(userId);
      return true;
    } catch (e) {
      // print('❌ OTP verification error: $e');
      rethrow;
    }
  }

  // static Future<String?> getToken() async => await _storage.read(key: 'jwt'); // ✅ Must match saveToken()
  // static Future<void> logout() async => await _storage.deleteAll(); // ✅ Optional improvement below

  static Future<List<Movie>> fetchLatestMovies() async {
    final uri = Uri.parse('$baseUrl/api/movies/latest');
    final headers = await _authHeaders();
    print('🛠 [fetchLatestMovies] GET $uri');
    print('🛠 Headers: $headers');

    final resp = await http.get(uri, headers: headers);
    print('🛠 StatusCode: ${resp.statusCode}');
    print('🛠 Body: ${resp.body}');

    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body) as List;
      return data.map((e) => Movie.fromJson(e)).toList();
    }
    throw Exception('Failed to fetch latest movies');
  }

  static Future<List<Movie>> fetchAllMovies() async {
    final resp = await http.get(
      Uri.parse('$baseUrl/api/movies'),
      headers: await _authHeaders(),
    );
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body) as List;
      return data.map((e) => Movie.fromJson(e)).toList();
    }
    throw Exception('Failed to fetch all movies');
  }

  static Future<List<Outreach>> fetchLatestOutreach() async {
    final resp = await http.get(
      Uri.parse('$baseUrl/api/outreach/latest'),
      headers: await _authHeaders(),
    );
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body) as List;
      return data.map((e) => Outreach.fromJson(e)).toList();
    }
    throw Exception('Failed to fetch latest outreach');
  }

  static Future<List<Outreach>> fetchAllOutreach() async {
    final uri = Uri.parse('$baseUrl/api/outreach');
    final headers = await _authHeaders();
    print('🛠 [fetchAllOutreach] GET $uri');
    print('🛠 Headers: $headers');

    final resp = await http.get(uri, headers: headers);
    print('🛠 StatusCode: ${resp.statusCode}');
    print('🛠 Body: ${resp.body}');
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body) as List;
      return data.map((e) => Outreach.fromJson(e)).toList();
    }
    throw Exception('Failed to fetch all outreach');
  }

  static Future<List<Attraction>> fetchLatestAttractions() async {
    final resp = await http.get(
      Uri.parse('$baseUrl/api/attractions/latest'),
      headers: await _authHeaders(),
    );
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body) as List;
      return data.map((e) => Attraction.fromJson(e)).toList();
    }
    throw Exception('Failed to fetch latest attractions');
  }

  static Future<List<Attraction>> fetchAllAttractions() async {
    final resp = await http.get(
      Uri.parse('$baseUrl/api/attractions'),
      headers: await _authHeaders(),
    );
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body) as List;
      return data.map((e) => Attraction.fromJson(e)).toList();
    }
    throw Exception('Failed to fetch all attractions');
  }

  static Future<List<News>> fetchLatestNews() async {
    final resp = await http.get(
      Uri.parse('$baseUrl/api/news/latest'),
      headers: await _authHeaders(),
    );
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body) as List;
      return data.map((e) => News.fromJson(e)).toList();
    }
    throw Exception('Failed to fetch latest news');
  }

  static Future<List<News>> fetchAllNews() async {
    final resp = await http.get(
      Uri.parse('$baseUrl/api/news'),
      headers: await _authHeaders(),
    );
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body) as List;
      return data.map((e) => News.fromJson(e)).toList();
    }
    throw Exception('Failed to fetch all news');
  }

  static Future<int> getUnreadCount() async {
    final uri = Uri.parse('$baseUrl/api/notifications/count');
    final headers = await _authHeaders();

    print('🛠 [getUnreadCount] GET $uri');
    print('🛠 Headers: $headers');

    final resp = await http.get(uri, headers: headers);

    print('🛠 StatusCode: ${resp.statusCode}');
    print('🛠 Body: ${resp.body}');

    if (resp.statusCode == 200) {
      final body = jsonDecode(resp.body) as Map<String, dynamic>;
      return body['count'] as int;
    }
    throw Exception('Failed to fetch notification count');
  }

  static Future<List<NotificationItem>> getUserNotifications() async {
    final uri = Uri.parse('$baseUrl/api/notifications');
    final headers = await _authHeaders();

    print('🛠 [getUserNotifications] GET $uri');
    print('🛠 Headers: $headers');

    final resp = await http.get(uri, headers: headers);

    print('🛠 StatusCode: ${resp.statusCode}');
    print('🛠 Body: ${resp.body}');

    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body) as List;
      return data.map((e) => NotificationItem.fromJson(e)).toList();
    }
    throw Exception('Failed to fetch notifications');
  }

  static Future<void> markAllNotificationsRead() async {
    final uri = Uri.parse('$baseUrl/api/notifications/mark-all-read');
    final headers = await _authHeaders();

    print('🛠 [markAllNotificationsRead] POST $uri');
    print('🛠 Headers: $headers');

    final resp = await http.post(uri, headers: headers);

    print('🛠 StatusCode: ${resp.statusCode}');
    print('🛠 Body: ${resp.body}');

    if (resp.statusCode != 200) {
      throw Exception('Failed to mark notifications read');
    }
  }

  static Future<void> markNotificationRead(int id) async {
    final uri = Uri.parse('$baseUrl/api/notifications/mark-read/$id');
    final headers = await _authHeaders();

    print('🛠 [markNotificationRead] PUT $uri');
    print('🛠 Headers: $headers');

    final resp = await http.put(uri, headers: headers);

    print('🛠 StatusCode: ${resp.statusCode}');
    print('🛠 Body: ${resp.body}');

    if (resp.statusCode != 200) {
      throw Exception('Failed to mark notification as read');
    }
  }

  static Future<List<EntryTicket>> fetchEntryTickets() async {
    final uri = Uri.parse('$baseUrl/api/entry-tickets');
    final headers = await _authHeaders();

    final res = await http.get(uri, headers: headers);

    if (res.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(res.body);
      return jsonList.map((e) => EntryTicket.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load entry tickets');
    }
  }

  static Future<List<ParkingOption>> fetchParkingOptions() async {
    final uri = Uri.parse('$baseUrl/api/parking-options');
    final headers = await _authHeaders();

    final res = await http.get(uri, headers: headers);

    if (res.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(res.body);
      return jsonList.map((e) => ParkingOption.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load parking options');
    }
  }

  static Future<List<Attraction>> fetchAttractions() async {
    final uri = Uri.parse('$baseUrl/api/attractions');
    final headers = await _authHeaders();

    final res = await http.get(uri, headers: headers);

    if (res.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(res.body);
      return jsonList.map((e) => Attraction.fromJson(e)).toList();
    } else {
      debugPrint("Error fetching attractions: ${res.body}");
      throw Exception('Failed to load attractions');
    }
  }

  static Future<List<Movie>> fetchMovies() async {
    final uri = Uri.parse('$baseUrl/api/movies');
    final headers = await _authHeaders();

    final res = await http.get(uri, headers: headers);

    if (res.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(res.body);
      return jsonList.map((e) => Movie.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  static Future<String?> createBooking(
    String userId,
    BookingCartProvider cart,
  ) async {
    try {
      final url = Uri.parse('$baseUrl/api/bookings');
      final body = {
        'userId': userId,
        'entryTickets': cart.selectedEntryTickets
            .map((e) => {'id': e.id, 'count': e.count, 'pricePerUnit': e.price})
            .toList(),
        'parking': cart.selectedParking
            .map((p) => {'id': p.id, 'count': p.count, 'pricePerUnit': p.price})
            .toList(),
        'attractions': cart.selectedAttractions.map((a) => a.id).toList(),
        'movies': cart.selectedMovies.map((m) => m.id).toList(),
        'attractionVisitorSlots': cart.selectedAttractionVisitorSlots
            .map(
              (s) => {
                'id': s.attractionId,
                'count': s.count,
                'pricePerUnit': s.price,
              },
            )
            .toList(),
        'movieVisitorSlots': cart.selectedMovieVisitorSlots
            .map(
              (s) => {
                'id': s.attractionId,
                'count': s.count,
                'pricePerUnit': s.price,
              },
            )
            .toList(),
        'total': cart.overallTotalAmount,
      };

      final response = await http.post(
        url,
        headers: await _authHeaders(),
        body: jsonEncode(body),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return data['bookingId'];
      } else {
        debugPrint(
          '❌ Booking failed. Status: ${response.statusCode}, Body: ${response.body}',
        );
        return null;
      }
    } catch (e) {
      debugPrint('❌ Exception in createBooking: $e');
      return null;
    }
  }

  static Future<bool> createPayment(
    String userId,
    String bookingId,
    double amount,
    String method,
  ) async {
    final url = Uri.parse('$baseUrl/api/payments');
    final body = {
      'userId': userId,
      'bookingId': bookingId,
      'amount': amount,
      'method': method,
    };

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    return response.statusCode == 201;
  }

  static Future<Map<String, dynamic>> getProfile() async {
    final headers = await _authHeaders();
    print('📡 Fetching profile from backend...');
    final resp = await http.get(
      Uri.parse('$baseUrl/api/profile'),
      headers: headers,
    );
    print('📬 Response status: ${resp.statusCode}');
    print('📦 Response body: ${resp.body}');
    final map = jsonDecode(resp.body);
    return {
      'user': User.fromJson(map['user']),
      'bookings': (map['bookings'] as List)
          .map((e) => BookingHistory.fromJson(e))
          .toList(),
    };
  }

  static Future<bool> updateProfile(
    String name,
    String email,
    String mobile,
  ) async {
    try {
      final headers = await _authHeaders();
      final response = await http.put(
        Uri.parse('$baseUrl/api/profile'),
        headers: headers,
        body: jsonEncode({'name': name, 'email': email, 'mobile': mobile}),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        debugPrint(
          '❌ Update failed: ${response.statusCode} - ${response.body}',
        );
        return false;
      }
    } catch (e) {
      debugPrint('❌ Exception during updateProfile: $e');
      return false;
    }
  }
}
