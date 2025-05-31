import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticket_booking_app/core/services/api_service.dart';
import 'package:ticket_booking_app/generated/app_localizations.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _mobileCtrl = TextEditingController();
  bool _loading = false;

  Future<void> submitSignup() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    debugPrint('➡️ Sending signup request...');

    try {
      final success = await ApiService.signup(
        _nameCtrl.text,
        _emailCtrl.text,
        _mobileCtrl.text,
      );

      if (success) {
        if (!mounted) return;
        context.go('/otp', extra: _emailCtrl.text);
      }
    } catch (e) {
      debugPrint('❌ Signup error: $e');
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Signup Failed'),
          content: Text(e.toString().replaceFirst('Exception: ', '')),
        ),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFE6F0FA), // Light blue background
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(loc.signUp,
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E008A))),
                  const SizedBox(height: 8),
                  Text(
                    loc.signupSubtitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: const Color(0xFF1E008A).withOpacity(0.1),
                    child: Image.asset(
                      'assets/images/mobile_icon.png',
                      width: 70,
                      height: 70,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Full Name
                  _buildField(_nameCtrl, 'Full Name'),
                  const SizedBox(height: 12),

                  // Email ID
                  _buildField(
                    _emailCtrl,
                    loc.emailId,
                    validator: (val) {
                      if (val == null || val.isEmpty) return loc.emailRequired;
                      final emailRegex = RegExp(r'^[\w.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,10}(\.[a-zA-Z]{2,10})?$');
                      return emailRegex.hasMatch(val) ? null : loc.invalidEmail;
                    },
                  ),
                  const SizedBox(height: 12),

                  // Mobile Number
                  _buildField(
                    _mobileCtrl,
                    loc.mobileNumber,
                    keyboard: TextInputType.phone,
                    validator: (val) {
                      if (val == null || val.isEmpty) return loc.mobileRequired;
                      final phoneRegex = RegExp(r'^\d{10}$');
                      return phoneRegex.hasMatch(val) ? null : loc.invalidMobile;
                    },
                  ),
                  const SizedBox(height: 24),

                  // Request PIN button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _loading ? null : submitSignup,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E008A),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: _loading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(loc.requestPin, style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Already have an account?
                  TextButton(
                    onPressed: () => context.go('/login'),
                    child: Text(
                      loc.alreadyHaveAccount,
                      style: const TextStyle(
                        color: Color(0xFF1E008A),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(
    TextEditingController ctrl,
    String hint, {
    TextInputType? keyboard,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: ctrl,
      keyboardType: keyboard,
      validator: validator ??
          (val) => val == null || val.isEmpty ? 'This field is required' : null,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
