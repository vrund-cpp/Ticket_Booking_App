import 'package:flutter_test/flutter_test.dart';

class AuthProvider {
  String? _token;
  bool get isLoggedIn => _token != null;

  void login(String token) => _token = token;
  void logout() => _token = null;
}

void main() {
  test('Login and logout update state correctly', () {
    final auth = AuthProvider();

    expect(auth.isLoggedIn, false);
    auth.login('abc123');
    expect(auth.isLoggedIn, true);
    auth.logout();
    expect(auth.isLoggedIn, false);
  });
}
