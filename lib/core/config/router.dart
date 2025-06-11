// File: lib/core/config/router.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticket_booking_app/features/auth/screens/language_selector_screen.dart';
import 'package:ticket_booking_app/features/auth/screens/splash_screen.dart';
import 'package:ticket_booking_app/features/auth/screens/login_screen.dart';
import 'package:ticket_booking_app/features/auth/screens/signup_screen.dart';
import 'package:ticket_booking_app/features/auth/screens/otp_verification_screen.dart';
import 'package:ticket_booking_app/features/dashboard/screens/dashboard_screen.dart';
import 'package:ticket_booking_app/features/dashboard/screens/movies_list_screen.dart';
import 'package:ticket_booking_app/features/dashboard/screens/attractions_list_screen.dart';
import 'package:ticket_booking_app/features/dashboard/screens/outreach_list_screen.dart';
import 'package:ticket_booking_app/features/dashboard/screens/news_list_screen.dart';
import 'package:ticket_booking_app/features/dashboard/screens/notification_screen.dart';
import 'package:ticket_booking_app/core/services/auth_service.dart';

class AppRouter {
  /// Accepts the saved locale code ('' if none) and returns a GoRouter
  static GoRouter getRouter(String localeCode) {
    final initial = localeCode.isNotEmpty ? '/splash' : '/language';

    return GoRouter(
      initialLocation: initial,
      routes: [
        GoRoute(
          path: '/splash',
          builder: (_, __) => const SplashScreen(),
        ),
        GoRoute(
          path: '/language',
          builder: (_, __) => const LanguageSelectorScreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (_, __) => const LoginScreen(),
        ),
        GoRoute(
          path: '/signup',
          builder: (_, __) => const SignupScreen(),
        ),
        GoRoute(
          path: '/otp',
          builder: (_, __) => const OTPVerificationScreen(),
        ),
        GoRoute(
          path: '/movies',
          builder: (_, __) => const MoviesListScreen(),
        ),
        GoRoute(
          path: '/attractions',
          builder: (_, __) => const AttractionsListScreen(),
        ),
        GoRoute(
          path: '/outreach',
          builder: (_, __) => const OutreachListScreen(),
        ),
        GoRoute(
          path: '/news',
          builder: (_, __) => const NewsListScreen(),
        ),
        GoRoute(
          path: '/dashboard',
          builder: (context, _) => FutureBuilder<String?>(
            future: AuthService.getUserId(),
            builder: (ctx, snap) {
              if (snap.connectionState != ConnectionState.done) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
              final userId = snap.data;
              return userId == null
                  ? const LoginScreen()
                  : DashboardScreen(userId: userId);
            },
          ),
        ),
        GoRoute(
          path: '/notifications',
          builder: (context, _) => FutureBuilder<String?>(
            future: AuthService.getUserId(),
            builder: (ctx, snap) {
              if (snap.connectionState != ConnectionState.done) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
              final userId = snap.data;
              return userId == null
                  ? const LoginScreen()
                  : NotificationScreen(userId: userId);
            },
          ),
        ),
      ],
    );
  }
}



// class AppRouter {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case '/language':
//         return MaterialPageRoute(builder: (_) => const LanguageSelectorScreen());
//       case '/home':
//         return MaterialPageRoute(builder: (_) => const PlaceholderScreen(label: 'Home'));
//       case '/login':
//         return MaterialPageRoute(builder: (_) => const LoginScreen());
//       case '/signup':
//         return MaterialPageRoute(builder: (_) => const SignupScreen());
//       case '/otp':
//         return MaterialPageRoute(builder: (_) => const OTPVerificationScreen());
//       case '/splash':
//         return MaterialPageRoute(builder: (_) => const SplashScreen());
//       default:
//         return MaterialPageRoute(
//             builder: (_) => const Scaffold(
//                   body: Center(child: Text('No route defined')),
//                 ));
//     }
//   }
// }
