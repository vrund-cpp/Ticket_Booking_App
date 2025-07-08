// File: lib/core/config/router.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticketease/features/language_selection/screens/language_selector_screen.dart';
import 'package:ticketease/features/auth/screens/splash_screen.dart';
import 'package:ticketease/features/auth/screens/login_screen.dart';
import 'package:ticketease/features/auth/screens/signup_screen.dart';
import 'package:ticketease/features/auth/screens/otp_verification_screen.dart';
import 'package:ticketease/features/dashboard/screens/dashboard_screen.dart';
import 'package:ticketease/features/movies/screens/movie_detail_screen.dart';
import 'package:ticketease/features/movies/screens/movies_list_screen.dart';
import 'package:ticketease/features/attractions/screens/attractions_list_screen.dart';
import 'package:ticketease/features/outreach/screens/outreach_list_screen.dart';
import 'package:ticketease/features/news/screens/news_list_screen.dart';
import 'package:ticketease/features/notification/screens/notification_screen.dart';
import 'package:ticketease/core/services/auth_service.dart';
import 'package:ticketease/features/movies/models/movie.dart';
import 'package:ticketease/features/payments/screens/payment_failed_screen.dart';
import 'package:ticketease/features/payments/screens/payment_processing_screen.dart';
import 'package:ticketease/features/payments/screens/payment_screen.dart';
import 'package:ticketease/features/payments/screens/payment_success_screen.dart';
import 'package:ticketease/features/profile/screens/profile_screen.dart';
import 'package:ticketease/features/language_selection/screens/settings_screen.dart';
import 'package:ticketease/features/attractions/screens/attractions_screen.dart';
import 'package:ticketease/features/entry-tickets/screens/entry_ticket_screen.dart';
import 'package:ticketease/features/movies/screens/movies_screen.dart';
import 'package:ticketease/features/parking-options/screens/parking_screen.dart';
import 'package:ticketease/features/visitor_slot/screens/attraction_visitor_screen.dart';
import 'package:ticketease/features/visitor_slot/screens/movie_visitors_screen.dart';
import 'package:ticketease/features/booking/screens/checkout_screen.dart';

class AppRouter {
  /// Accepts the saved locale code ('' if none) and returns a GoRouter
  static GoRouter getRouter(String localeCode) {
    final initial = localeCode.isNotEmpty ? '/splash' : '/language';

    return GoRouter(
      initialLocation: initial,
      routes: [
        GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),
        GoRoute(
          path: '/language',
          builder: (_, __) => const LanguageSelectorScreen(),
        ),
        GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
        GoRoute(path: '/signup', builder: (_, __) => const SignupScreen()),
        GoRoute(
          path: '/otp',
          builder: (_, __) => const OTPVerificationScreen(),
        ),
        // Inside routes list:
        GoRoute(
          path: '/movies',
          builder: (context, state) {
            final userId = state.extra as String;
            return MoviesListScreen(userId: userId);
          },
        ),
        GoRoute(
          path: '/attractions',
          builder: (context, state) {
            final userId = state.extra as String;
            return AttractionsListScreen(userId: userId);
          },
        ),
        GoRoute(
          path: '/outreach',
          builder: (context, state) {
            final userId = state.extra as String;
            return OutreachListScreen(userId: userId);
          },
        ),
        GoRoute(
          path: '/news',
          builder: (context, state) {
            final userId = state.extra as String;
            return NewsListScreen(userId: userId);
          },
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
        GoRoute(
          path: '/entry-tickets/booking',
          builder: (context, state) {
            final userId = state.extra as String;
            return EntryTicketScreen(userId: userId);
          },
        ),
        GoRoute(
          path: '/parking-options/booking',
          builder: (context, state) {
            final userId = state.extra as String;
            return ParkingScreen(userId: userId);
          },
        ),
        GoRoute(
          path: '/attractions/booking',
          builder: (context, state) {
            final userId = state.extra as String;
            return AttractionsScreen(userId: userId);
          },
        ),
        GoRoute(
          path: '/movies/booking',
          builder: (context, state) {
            final userId = state.extra as String;
            return MoviesScreen(userId: userId);
          },
        ),
        GoRoute(
          path: '/attractions/visitors',
          builder: (context, state) {
            final userId = state.extra as String;
            return AttractionVisitorScreen(userId: userId);
          },
        ),
        GoRoute(
          path: '/movies/visitors',
          builder: (context, state) {
            final userId = state.extra as String;
            return MovieVisitorsScreen(userId: userId);
          },
        ),
        GoRoute(
          path: '/checkout',
          builder: (context, state) {
            final userId = state.extra as String;
            return CheckoutScreen(userId: userId);
          },
        ),
        GoRoute(
          path: '/payment',
          builder: (context, state) {
            final extras = state.extra as Map;
            return PaymentScreen(
              userId: extras['userId'],
              amount: extras['amount'],
              bookingId: extras['bookingId'],
            );
          },
        ),
        GoRoute(
          path: '/processing',
          builder: (_, state) =>
              PaymentProcessingScreen(data: state.extra as Map),
        ),
        GoRoute(
          path: '/payment-success',
          builder: (_, state) => PaymentSuccessScreen(data: state.extra as Map),
        ),
        GoRoute(
          path: '/payment-failed',
          builder: (_, state) => const PaymentFailedScreen(),
        ),
        GoRoute(
          path: '/profile',
          name: 'profile',
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) {
            final userId = state.extra as String;
            return SettingsScreen(userId: userId);
          },
        ),
        // Inside routes list:
        GoRoute(
          path: '/movie-details',
          builder: (context, state) {
            final extras = state.extra as Map<String, dynamic>;
            final movie = extras['movie'] as Movie;
            final userId = extras['userId'] as String;
            return MovieDetailScreen(movie: movie, userId: userId);
          },
        ),
      ],
    );
  }
}
