import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ticketease/features/language_selection/screens/language_selector_screen.dart';
// ← adjust this import if your path differs

void main() {
  testWidgets('LanguageSelectorScreen shows a dropdown and a continue button',
      (WidgetTester tester) async {
    // Pump the screen inside a minimal app
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: LanguageSelectorScreen()),
      ),
    );

    // Allow first frame
    await tester.pump();

    // Verify there's exactly one DropdownButtonFormField<String>
    expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);

    // Verify there's exactly one ElevatedButton (“Continue”)
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
