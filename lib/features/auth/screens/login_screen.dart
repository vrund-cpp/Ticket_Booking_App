// lib\features\auth\screens\login_screen.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:ticket_booking_app/core/services/auth_service.dart';
import 'package:ticket_booking_app/core/services/api_service.dart';
import 'package:ticket_booking_app/generated/app_localizations.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailPhoneCtrl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isLoading = false;

  Future<void> requestOTP() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      final success = await ApiService.login(_emailPhoneCtrl.text);

      if (success) {
        context.go('/otp', extra: _emailPhoneCtrl.text.trim());
      } else {
        await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to send OTP. Please try again.'),
                      actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
            ],
          ),
        );
      }
    } catch (e) {
      debugPrint('❌ Login error: $e');
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Error'),
          content: Text(e.toString()),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
          ],
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFE7ECFD),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    loc.signIn.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF240E86),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    loc.enterPhoneOrEmail,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF5F7FE),
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/images/mobile_icon.png',
                      height: 70,
                      width: 70,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _emailPhoneCtrl,
                    decoration: InputDecoration(
                      hintText: loc.phoneOrEmail,
                      hintStyle: const TextStyle(color: Colors.black45),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return loc.enterValidEmailOrPhone;
                      }
                      final emailPattern = RegExp(
                          r'^[\w.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,10}$');
                      final phonePattern = RegExp(r'^\d{10}$');
                      if (!emailPattern.hasMatch(value) &&
                          !phonePattern.hasMatch(value)) {
                        return loc.enterValidEmailOrPhone;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : requestOTP,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)),
                        padding: const EdgeInsets.all(12),
                        backgroundColor: const Color(0xFF240E86),
                        foregroundColor: Colors.white,
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            )
                          : Text(loc.requestPin),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => context.push('/signup'),
                    child: RichText(
                      text: TextSpan(
                        text: loc.dontHaveAccount,
                        style: const TextStyle(color: Colors.black54),
                        children: [
                          TextSpan(
                            text: ' ${loc.signUp}',
                            style: const TextStyle(
                                color: Color(0xFF240E86),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
