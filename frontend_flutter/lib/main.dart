// // File: lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

import 'features/booking/providers/booking_cart_provider.dart';
import 'features/profile/providers/profile_provider.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF4A00B4),
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );

  final prefs = await SharedPreferences.getInstance();
  final lang = prefs.getString('languageCode') ?? 'en';

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('hi')],
      path: 'assets/langs',
      fallbackLocale: const Locale('en'),
      startLocale: Locale(lang),
      saveLocale: true, // automatically saves selected language
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => BookingCartProvider()),
          ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ],
        child: MyApp(), // use updated app class below
      ),
    ),
  );
}
