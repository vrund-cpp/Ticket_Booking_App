import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/l10n.dart';
import 'generated/app_localizations.dart';
import 'core/config/router.dart';
// import './features/auth/presentation/screens/language_selector_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final langCode = prefs.getString('languageCode') ?? '';

  runApp(MyApp(initialLocaleCode: langCode));
}

class MyApp extends StatelessWidget {
  final String initialLocaleCode;
  const MyApp({super.key, required this.initialLocaleCode});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      locale: initialLocaleCode.isNotEmpty ? Locale(initialLocaleCode) : null,
      // routerConfig: AppRouter.router,
      supportedLocales: L10n.all,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: AppRouter.getRouter(initialLocaleCode), // Update this to your actual main screen or router
    );
  }
}

// A wrapper widget to handle router navigation
class MainAppRouter extends StatelessWidget {
  const MainAppRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: L10n.all,
    );
  }
}