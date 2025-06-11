import 'package:dio/dio.dart';
// lib\core\network\api_client.dart
class ApiClient {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl:'https://ticket-booking-app-backend-0zhj.onrender.com/api', // change if using real device
      connectTimeout: const Duration(seconds: 10),
    ),
  );

  Future<Response> get(String endpoint) async => await dio.get(endpoint);
}
