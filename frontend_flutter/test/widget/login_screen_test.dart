import 'package:flutter_test/flutter_test.dart';
import 'package:ticketease/features/auth/screens/login_screen.dart';
import '../helpers/test_wrapper.dart';


void main() {
  testWidgets('Login screen renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWrapper(LoginScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Login'), findsOneWidget); // Check localized text after loading
  });
}