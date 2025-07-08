import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticketease/app.dart';
import 'package:ticketease/features/profile/providers/profile_provider.dart';
import 'package:ticketease/features/profile/screens/profile_screen.dart';
import '../helpers/test_setup.dart';

void main() {
  setUpAll(() async {
    await setupTestEnv();
  });

  testWidgets('Profile screen shows user info', (WidgetTester tester) async {
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('hi')],
        path: 'assets/langs',
        fallbackLocale: const Locale('en'),
          child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ProfileProvider()),
          ],
          child: const MaterialApp(home: ProfileScreen()),
        ),
        ),
    );

await tester.pumpAndSettle();


    expect(find.text('Profile'), findsOneWidget);
    expect(find.text('Email id'), findsOneWidget);
    expect(find.text('Mobile Number'), findsOneWidget);
  });
}
