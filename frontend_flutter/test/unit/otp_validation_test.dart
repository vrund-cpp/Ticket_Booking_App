import 'package:flutter_test/flutter_test.dart';

bool isValidOtp(String otp) {
  return otp.length == 4 && int.tryParse(otp) != null;
}

void main() {
  test('OTP should be valid when it has 4 digits', () {
    expect(isValidOtp('1234'), true);
    expect(isValidOtp('abcd'), false);
    expect(isValidOtp('12'), false);
  });
}
