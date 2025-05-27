// import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../features/auth/presentation/screens/language_selector_screen.dart';
import '../../../features/auth/presentation/screens/splash_screen.dart';
import '../../../features/auth/presentation/screens/login_screen.dart';
// import '../../../features/home/home_screen.dart';

GoRouter buildRouter(bool isLanguageSelected) => GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),
    GoRoute(path: '/language', builder: (_, __) => const LanguageSelectorScreen()),
    GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
    // GoRoute(path: '/signup', builder: (_, __) => const SignupScreen()),
    // GoRoute(path: '/otp', builder: (_, __) => const OTPVerificationScreen()),
  ],
);
