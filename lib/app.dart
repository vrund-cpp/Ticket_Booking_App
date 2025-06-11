// import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'core/config/router.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class TicketBookingApp extends StatelessWidget {
//   final bool seen;
//   final String selectedLanguage;

//   const TicketBookingApp({super.key, required this.seen, required this.selectedLanguage});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Ticket Booking App',
//       debugShowCheckedModeBanner: false,
//       locale: Locale(selectedLanguage),
//       supportedLocales: const [
//         Locale('en'),
//         Locale('hi'),
//       ],
//       localizationsDelegates: const [
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//         GlobalCupertinoLocalizations.delegate,
//       ],
//       theme: ThemeData(primarySwatch: Colors.deepPurple),
//       initialRoute: seen ? '/splash' : '/language',
//       onGenerateRoute: AppRouter.generateRoute,
//     );
//   }
// }

// File: lib/app.dart

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'core/config/router.dart';
import 'core/theme/theme.dart';

class TicketBookingApp extends StatelessWidget {
  final String localeCode;
  const TicketBookingApp({super.key, required this.localeCode});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [Provider<int>.value(value: 1)],
      child: MaterialApp.router(
        routerConfig: AppRouter.getRouter(localeCode),
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
