import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'core/config/router.dart';
import 'core/theme/theme.dart';

class TicketBookingApp extends StatelessWidget {
  final bool isLanguageSelected;

  const TicketBookingApp({super.key, required this.isLanguageSelected});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [Provider<int>.value(value: 1),], // <-- Empty for now, can be updated later
      child: MaterialApp.router(
        routerConfig: buildRouter(isLanguageSelected),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('hi'),
        ],
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
      ),
    );
  }
}
