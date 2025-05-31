// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get continueLabel => 'CONTINUE';

  @override
  String get loginTitle => 'Login';

  @override
  String get signIn => 'Sign In';

  @override
  String get enterPhoneOrEmail =>
      'Please enter mobile number or email id for verification';

  @override
  String get phoneOrEmail => 'Mobile Number or Email id';

  @override
  String get requestPin => 'Request PIN';

  @override
  String get signUp => 'Sign Up';

  @override
  String get signupSubtitle =>
      'Please enter full name, email id and mobile number.';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get enterValidEmailOrPhone => 'Enter a valid email or phone';

  @override
  String get emailId => 'Email';

  @override
  String get emailRequired => '\'Email is required\'';

  @override
  String get invalidEmail => 'invalid Email';

  @override
  String get mobileNumber => 'mobile Number';

  @override
  String get mobileRequired => 'mobile Number is required';

  @override
  String get invalidMobile => 'Invalid Mobile';

  @override
  String get alreadyHaveAccount => 'Already have an account? Sign In';

  @override
  String get enterPin => 'ENTER PIN';

  @override
  String get enterPinSubtitle =>
      'Please enter verification PIN sent to\nyour mobile number or email id';

  @override
  String get enterHere => 'Enter PIN Here';

  @override
  String get submit => 'Submit';

  @override
  String get invalidOtp => 'Invalid OTP';

  @override
  String get enterCorrectOtp => 'Please enter the correct OTP sent to you.';
}
