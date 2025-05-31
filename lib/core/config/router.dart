import 'package:go_router/go_router.dart';
import '../../../features/auth/presentation/screens/language_selector_screen.dart';
import '../../../features/auth/presentation/screens/splash_screen.dart';
import '../../../features/auth/presentation/screens/login_screen.dart';
import '../../../features/auth/presentation/screens/signup_screen.dart';
import '../../../features/auth/presentation/screens/otp_verification_screen.dart';
import '../../../features/auth/presentation/screens/placeholder_screen.dart';

class AppRouter {
  static  GoRouter getRouter(String localeCode) {
    final bool isLanguageSelected = localeCode.isNotEmpty;
    return GoRouter(
      initialLocation: isLanguageSelected ? '/splash' : '/language',
      routes: [
        GoRoute(path: '/splash', builder: (context,state) => const SplashScreen()),
        GoRoute(path: '/language', builder: (context,state) => const LanguageSelectorScreen()),
        GoRoute(path: '/login', builder: (context,state) => const LoginScreen()),
        GoRoute(path: '/signup', builder: (context,state) => const SignupScreen()),
        GoRoute(path: '/otp', builder: (context,state) => const OTPVerificationScreen()),
        GoRoute(path: '/home', builder: (context,state) => const PlaceholderScreen(label: 'Home')),
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
