import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _inputController = TextEditingController();

  void _requestPin() {
    if (_formKey.currentState!.validate()) {
      final input = _inputController.text.trim();
      // TODO: Replace with backend/API call
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('PIN requested for: $input'),
          backgroundColor: Colors.deepPurple,
        ),
      );

      // Navigate to OTP or next screen if implemented
    }
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F8),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 12,
                  offset: Offset(0, 6),
                )
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'sign_in'.tr(), // From localization file
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D0C57),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'sign_in_description'.tr(),
                    style: const TextStyle(fontSize: 15, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),
                  const CircleAvatar(
                    backgroundColor: Color(0xFFF2F3F8),
                    radius: 30,
                    child: Icon(Icons.smartphone, size: 36, color: Color(0xFF2D0C57)),
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    controller: _inputController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'mobile_or_email'.tr(),
                      border: const UnderlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'field_required'.tr();
                      }
                      // Add more validation if needed
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: _requestPin,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF5E17EB), Color(0xFF7636EC)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'request_pin'.tr(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      context.go('/register');
                    },
                    child: Text.rich(
                      TextSpan(
                        text: "${'no_account'.tr()} ",
                        style: const TextStyle(fontSize: 14),
                        children: [
                          TextSpan(
                            text: 'sign_up'.tr(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF5E17EB),
                            ),
                          ),
                        ],
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
}
