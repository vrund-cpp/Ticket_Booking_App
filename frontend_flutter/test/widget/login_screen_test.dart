import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ticketease/features/auth/screens/login_screen.dart';
// ← adjust this import if your path differs

void main() {
  testWidgets('LoginScreen shows one TextFormField and one ElevatedButton',
      (WidgetTester tester) async {
    // Pump the screen inside a minimal app
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: LoginScreen()),
      ),
    );

    // Allow first frame
    await tester.pump();

    // Check for a single input field
    expect(find.byType(TextFormField), findsOneWidget);

    // Check for a single button
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
