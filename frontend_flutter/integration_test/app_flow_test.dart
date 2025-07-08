import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ticketease/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('App startup and login flow test', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    expect(find.text('Login'), findsOneWidget);
  });
}
