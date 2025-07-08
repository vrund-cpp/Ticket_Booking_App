import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:ticketease/features/dashboard/screens/dashboard_screen.dart';
import '../helpers/test_setup.dart';
void main() {
  setUpAll(() async {
    await setupTestEnv();
  });
  testWidgets('Drawer opens and shows profile', (WidgetTester tester) async {
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('hi')],
        path: 'assets/langs',
        fallbackLocale: const Locale('en'),
        
          child: const DashboardScreen(userId: 'uv123'),
      ),
    );
    await tester.pumpAndSettle();

    // Open drawer
    final ScaffoldState scaffoldState = tester.firstState(find.byType(Scaffold));
    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    expect(find.text('Profile'), findsOneWidget); // Adjust text if localized
  });
}
