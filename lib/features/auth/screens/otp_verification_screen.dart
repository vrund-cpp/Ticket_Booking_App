// lib\features\auth\screens\otp_verification_screen.dart

import 'dart:async';
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
    final _focusNodes = List.generate(4, (_) => FocusNode());
  
  bool _loading = false;
  late final String userIdentifier;
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


String get otp => otpControllers.map((e) => e.text.trim()).join();

Future<void> submitOTP(String code) async {
  if (code.length != 4) return;

  setState(() => _loading = true);

  final success = await ApiService.verifyOtp(userIdentifier.trim(), code.trim());

  setState(() => _loading = false);

  if (success) {
    context.go('/dashboard', extra: userIdentifier);
  } else {
    final loc = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(loc.invalidOtp),
        content: Text(loc.enterCorrectOtp),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
  // String getCombinedOTP() {
  //   return otpControllers.map((controller) => controller.text.trim()).join();
  // }


  Widget _buildField(int i) {
    return SizedBox(
      width: 50,
      child: TextField(
        controller: otpControllers[i],
        focusNode: _focusNodes[i],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: const InputDecoration(
          counterText: '',
          filled: true,
          fillColor: Color(0xFFF2F2F2),
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
        ),
        style: const TextStyle(fontSize: 20),
        onChanged: (val) {
           if (val.isNotEmpty && i < 3) {
             FocusScope.of(context).nextFocus();
           }
         },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                loc.enterPin,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C007F),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                loc.enterPinSubtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              const Icon(Icons.lock, size: 40, color: Color(0xFF2C007F)),
              const SizedBox(height: 12),
              Text(
                loc.enterHere,
                style: const TextStyle(fontSize: 14, color: Colors.black),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, _buildField),
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
                    backgroundColor: const Color(0xFF512DA8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    foregroundColor: Colors.white,
                  ),
                  child: _loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          loc.submit,
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
}
