// test/helpers/test_wrapper.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:ticketease/features/profile/providers/profile_provider.dart'; // Adjust paths

Widget createTestWrapper(Widget child) {
  return EasyLocalization(
    supportedLocales: const [Locale('en'), Locale('hi')],
    path: 'assets/langs', // ✅ Make sure this folder exists in your test env
    fallbackLocale: const Locale('en'),
    child: MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileProvider())
      ],
      child: MaterialApp(
        locale: const Locale('en'),
        home: child,
      ),
    ),
  );
}
