// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get selectLanguage => 'भाषा चुनें';

  @override
  String get continueLabel => 'जारी रखें';

  @override
  String get loginTitle => 'लॉगिन';

  @override
  String get signIn => 'साइन इन करें';

  @override
  String get enterPhoneOrEmail =>
      'कृपया सत्यापन के लिए मोबाइल नंबर या ईमेल आईडी दर्ज करें';

  @override
  String get phoneOrEmail => 'मोबाइल नंबर या ईमेल आईडी';

  @override
  String get requestPin => 'पिन का अनुरोध करें';

  @override
  String get signUp => 'साइन अप करें';

  @override
  String get signupSubtitle =>
      'कृपया पूरा नाम, ईमेल आईडी और मोबाइल नंबर दर्ज करें।';

  @override
  String get dontHaveAccount => 'क्या आपके पास खाता नहीं है?';

  @override
  String get enterValidEmailOrPhone => 'मान्य ईमेल या फोन दर्ज करें';

  @override
  String get emailId => 'ईमेल';

  @override
  String get emailRequired => 'ईमेल आवश्यक है';

  @override
  String get invalidEmail => 'अमान्य ईमेल';

  @override
  String get mobileNumber => 'मोबाइल नंबर';

  @override
  String get mobileRequired => 'मोबाइल नंबर आवश्यक है';

  @override
  String get invalidMobile => 'अमान्य मोबाइल नंबर';

  @override
  String get alreadyHaveAccount => 'पहले से खाता है? साइन इन करें';

  @override
  String get enterPin => 'पिन दर्ज करें';

  @override
  String get enterPinSubtitle =>
      'कृपया सत्यापन पिन दर्ज करें जो आपके मोबाइल नंबर या ईमेल पर भेजा गया है';

  @override
  String get enterHere => 'यहां पिन दर्ज करें';

  @override
  String get submit => 'सबमिट करें';

  @override
  String get invalidOtp => 'अमान्य ओटीपी';

  @override
  String get enterCorrectOtp =>
      'कृपया सही ओटीपी दर्ज करें जो आपको भेजा गया है।';
}
