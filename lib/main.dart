import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'core/config/router.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isLanguageSelected = prefs.getBool('isLanguageSelected') ?? false;
    runApp(TicketBookingApp(isLanguageSelected: isLanguageSelected));
}