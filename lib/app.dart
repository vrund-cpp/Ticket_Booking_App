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