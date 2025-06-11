// File: frontend/lib/features/auth/providers/auth_provider.dart

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:ticket_booking_app/core/services/api_service.dart';
// import 'package:ticket_booking_app/models/user.dart';

// final authTokenProvider = StateProvider<String?>((_) => null);
// final userProvider = StateProvider<User?>((_) => null);

// final authNotifierProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
//   return AuthNotifier(ref);
// });

// class AuthNotifier extends StateNotifier<bool> {
//   final Ref ref;
//   AuthNotifier(this.ref) : super(false);

//   Future<void> login(String email, String password) async {
//     final resp = await ApiService.postData('auth/login', {'email': email, 'password': password});
//     final token = resp['token'] as String;
//     final userJson = resp['user'] as Map<String, dynamic>;
//     final user = User.fromJson(userJson);

//     ref.read(authTokenProvider.notifier).state = token;
//     ref.read(userProvider.notifier).state = user;

//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('authToken', token);

//     state = true;
//   }

//   Future<void> register(String name, String email, String password) async {
//     final resp = await ApiService.postData('auth/register', {'name': name, 'email': email, 'password': password});
//     final token = resp['token'] as String;
//     final userJson = resp['user'] as Map<String, dynamic>;
//     final user = User.fromJson(userJson);

//     ref.read(authTokenProvider.notifier).state = token;
//     ref.read(userProvider.notifier).state = user;

//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('authToken', token);

//     state = true;
//   }

//   Future<void> logout() async {
//     ref.read(authTokenProvider.notifier).state = null;
//     ref.read(userProvider.notifier).state = null;
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('authToken');
//     state = false;
//   }

//   Future<void> loadFromStorage() async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('authToken');
//     if (token != null) {
//       ref.read(authTokenProvider.notifier).state = token;
//       // Optionally fetch user profile here using token...
//       state = true;
//     }
//   }
// }



// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:ticket_booking_app/core/services/api_service.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// // Model for User
// class User {
//   final int id;
//   final String email;
//   final String name;
//   User({ required this.id, required this.email, required this.name });
// }

// // Holds JWT token
// final authTokenProvider = StateProvider<String?>((_) => null);

// // Holds logged-in user
// final userProvider = StateProvider<User?>((_) => null);

// // Async notifier for login
// final authNotifierProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
//   return AuthNotifier(ref);
// });

// class AuthNotifier extends StateNotifier<bool> {
//   final Ref ref;
//   AuthNotifier(this.ref): super(false);

//   // Call this to attempt login
//   Future<void> login(String email, String password) async {
//     final response = await http.post(
//       Uri.parse('http://localhost:3000/api/auth/login'),
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode({'email': email, 'password': password}),
//     );
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       final token = data['token'] as String;
//       final user = data['user'];
//       // Save to providers
//       ref.read(authTokenProvider.notifier).state = token;
//       ref.read(userProvider.notifier).state = User(
//         id: user['id'],
//         email: user['email'],
//         name: user['name'],
//       );
//       // Persist token in SharedPreferences
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString('authToken', token);
//       state = true;
//     } else {
//       state = false;
//       throw Exception('Login failed');
//     }
//   }

//   Future<void> loadTokenFromStorage() async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('authToken');
//     if (token != null) {
//       ref.read(authTokenProvider.notifier).state = token;
//       // Optionally fetch user profile using token
//       final response = await http.get(
//         Uri.parse('http://localhost:3000/api/auth/profile'),
//         headers: {'Authorization': 'Bearer $token'},
//       );
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         ref.read(userProvider.notifier).state = User(
//           id: data['id'], email: data['email'], name: data['name'],
//         );
//         state = true;
//       }
//     }
//   }

//   Future<void> logout() async {
//     ref.read(authTokenProvider.notifier).state = null;
//     ref.read(userProvider.notifier).state = null;
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('authToken');
//     state = false;
//   }
// }
