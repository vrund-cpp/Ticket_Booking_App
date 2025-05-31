import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticket_booking_app/core/services/api_service.dart';
import 'package:ticket_booking_app/generated/app_localizations.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({super.key});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
    final List<TextEditingController> otpControllers =
      List.generate(4, (_) => TextEditingController());
  
  bool _loading = false;
  late String userIdentifier;
  int _secondsRemaining = 60;

  @override
    void initState() {
      super.initState();
      _startTimer();
    }

  void _startTimer() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (_secondsRemaining == 0) return false;
      setState(() => _secondsRemaining--);
      return true;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userIdentifier = GoRouter.of(context).routerDelegate.currentConfiguration.extra as String;
  }

String get otp => otpControllers.map((e) => e.text).join();

Future<void> submitOTP(String code) async {

  if (code.length != 4) return;

  setState(() => _loading = true);
  final verified = await ApiService.verifyOtp(userIdentifier, code);
  setState(() => _loading = false);

  if (verified) {
    context.go('/home');
  } else {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.invalidOtp),
        content: Text(AppLocalizations.of(context)!.enterCorrectOtp),
      ),
    );
  }
}

  // String getCombinedOTP() {
  //   return otpControllers.map((controller) => controller.text.trim()).join();
  // }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                locale.enterPin,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C007F),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                locale.enterPinSubtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              const Icon(Icons.lock, size: 40, color: Color(0xFF2C007F)),
              const SizedBox(height: 12),
              Text(
                locale.enterHere,
                style: const TextStyle(fontSize: 14, color: Colors.black),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, _buildOTPField),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _loading
                      ? null
                      : () {
                          final code = otp;
                          if (code.length == 4) submitOTP(code);
                        },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: const Color(0xFF512DA8),
                    foregroundColor: Colors.white,
                  ),
                  child: _loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          locale.submit,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "00:${_secondsRemaining.toString().padLeft(2, '0')}",
                style: const TextStyle(color: Colors.black54, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

Widget _buildOTPField(int index) {
    return SizedBox(
      width: 50,
      child: TextField(
        controller: otpControllers[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20),
        maxLength: 1,
        decoration: const InputDecoration(
          counterText: '',
          filled: true,
          fillColor: Color(0xFFF2F2F2),
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)),),
        ),
        onChanged: (val) {
          if (val.isNotEmpty && index < 3) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}