// File: lib/app.dart

import 'package:flutter/material.dart';
import 'core/config/router.dart';
import 'core/theme/theme.dart';
import 'package:easy_localization/easy_localization.dart';

class MyApp extends StatelessWidget {
const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeCode = context.locale.languageCode;

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Ticket Booking App',
      routerConfig: AppRouter.getRouter(localeCode),
      locale: context.locale,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
    );
  }
}
