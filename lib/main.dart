// File: lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_booking_app/core/config/router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ticket_booking_app/generated/app_localizations.dart';

/// Provider for storing the user’s preferred language code.
final languageCodeProvider = StateProvider<String>((_) => 'en');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Status bar styling per blueprint
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color(0xFF4A00B4),
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
  ));

  // Load saved language code
  // final prefs = await SharedPreferences.getInstance();
  // final lang = prefs.getString('languageCode') ?? '';
  final prefs = await SharedPreferences.getInstance();
  // default to 'en' so locale is never empty
  final lang = prefs.getString('languageCode') ?? 'en';

  runApp(
    ProviderScope(
      overrides: [
        languageCodeProvider.overrideWith((_) => lang),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final langCode = ref.watch(languageCodeProvider);
    final router = AppRouter.getRouter(langCode);


    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Ticket Booking App',
      // locale: Locale(langCode),
      // if somehow langCode is ever empty, omit locale entirely
      locale: langCode.isNotEmpty ? Locale(langCode) : null,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        primaryColor: const Color(0xFF4A00B4),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF4A00B4),
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      routerConfig: router,
    );
  }
}


// // File: frontend/lib/main.dart

//  import 'package:flutter/material.dart';
//  import 'package:flutter/services.dart';
//  import 'package:go_router/go_router.dart';
//  import 'package:flutter_riverpod/flutter_riverpod.dart';
//  import 'package:ticket_booking_app/core/constants/colors.dart';
//  import 'core/services/auth_service.dart';
// // import 'package:ticket_booking_app/features/attractions/screens/see_all_attractions_screen.dart';
// //  import 'package:ticket_booking_app/features/auth/providers/auth_provider.dart';
//  import '/features/auth/screens/login_screen.dart';
//  import 'features/auth/screens/signup_screen.dart';
//  import 'features/dashboard/screens/dashboard_screen.dart';
// //  import 'package:ticket_booking_app/features/see_all/screens/see_all_movies_screen.dart';
// //  import 'package:ticket_booking_app/features/see_all/screens/see_all_outreach_screen.dart';
// //  import 'package:ticket_booking_app/features/see_all/screens/see_all_attractions_screen.dart';
// //  import 'package:ticket_booking_app/features/see_all/screens/see_all_news_screen.dart';
// //  import 'package:ticket_booking_app/features/dashboard/screens/notification_screen.dart';
//  import 'package:shared_preferences/shared_preferences.dart';
// import 'features/dashboard/screens/notification_screen.dart';
// import 'features/dashboard/screens/movies_list_screen.dart';
// import 'features/dashboard/screens/outreach_list_screen.dart';
// import 'features/dashboard/screens/attractions_list_screen.dart';
// import 'features/dashboard/screens/news_list_screen.dart';
 
//  void main() async {
//    WidgetsFlutterBinding.ensureInitialized();
//    // Load stored token (if any)
//    final prefs = await SharedPreferences.getInstance();
//    final token = prefs.getString('authToken')?? '';
//    final authTokenProvider = StateProvider<String>((ref) => '');
//    final langCode = prefs.getString('languageCode') ?? '';

//    runApp(
    
//      ProviderScope(  
//        overrides: [
//          authTokenProvider.overrideWith((ref) => token),
//        ],
//        child: MyApp(initialLocaleCode: langCode),
//      ),
//    );
//  }

//  class MyApp extends StatelessWidget {
//    final String initialLocaleCode;
//    const MyApp({super.key, required this.initialLocaleCode} );

//    @override
//    Widget build(BuildContext context) {
//     return MaterialApp(
//        debugShowCheckedModeBanner: false,
//       title: 'Ticket Booking App',
//       theme: ThemeData(
//         primaryColor: const Color(0xFF591EB3),
//         scaffoldBackgroundColor: Colors.white,
//         fontFamily: 'Roboto',
//         appBarTheme: const AppBarTheme(
//            backgroundColor: AppColors.backgroundPurple,
//           elevation: 0,
//            titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
//            iconTheme: IconThemeData(color: Colors.white),
//          ),
//        ),
//        initialRoute: userId != null ? '/' : '/login',
//        routes: {
//          '/': (_) => const SignupScreen(),
//          '/login': (_) => const LoginScreen(),
//          '/dashboard': (_) => const DashboardScreen(),
//          '/movies/all': (_) => const MoviesListScreen(),
//          '/outreach/all': (_) => const OutreachListScreen(),
//          '/attractions/all': (_) => const AttractionsListScreen(),
//          '/news/all': (_) => const NewsListScreen(),
//          '/notifications': (_) => const NotificationsScreen(userId: 'USER_123'),
//        },
//      );
//    }
//  }


// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'l10n/l10n.dart';
// import 'generated/app_localizations.dart';
// import 'core/config/router.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// //  import './features/notification/presentation/screens/notification_screen.dart';


// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final prefs = await SharedPreferences.getInstance();
//   final langCode = prefs.getString('languageCode') ?? '';

//   runApp(ProviderScope(child: MyApp(initialLocaleCode: langCode),),);
// }

// class MyApp extends StatelessWidget {
//   final String initialLocaleCode;
//   const MyApp({super.key, required this.initialLocaleCode});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       debugShowCheckedModeBanner: false,
//       locale: initialLocaleCode.isNotEmpty ? Locale(initialLocaleCode) : null,
//       // routerConfig: AppRouter.router,
//       supportedLocales: L10n.all,
//       localizationsDelegates: const [
//         AppLocalizations.delegate,
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//         GlobalCupertinoLocalizations.delegate,
//       ],
//       routerConfig: AppRouter.getRouter(initialLocaleCode), // Update this to your actual main screen or router
//     );
//   }
// }

// // A wrapper widget to handle router navigation
// class MainAppRouter extends StatelessWidget {
//   const MainAppRouter({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       // routerConfig: AppRouter.router,
//       debugShowCheckedModeBanner: false,
//       localizationsDelegates: const [
//         AppLocalizations.delegate,
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//         GlobalCupertinoLocalizations.delegate,
//       ],
//       supportedLocales: L10n.all,
//     );
//   }
// }