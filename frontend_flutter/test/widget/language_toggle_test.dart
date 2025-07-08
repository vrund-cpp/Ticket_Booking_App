import 'package:flutter_test/flutter_test.dart';
import 'package:ticketease/features/language_selection/screens/language_selector_screen.dart';
import '../helpers/test_wrapper.dart';


void main() {
  testWidgets('Language selector screen shows toggle options', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWrapper(LanguageSelectorScreen()));
await tester.pumpAndSettle(); // wait for rendering

    expect(find.text('हिन्दी'), findsOneWidget);
    expect(find.text('English'), findsOneWidget);

  });
}
