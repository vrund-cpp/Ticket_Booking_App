import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';

class LanguageSelectorScreen extends StatefulWidget {
  const LanguageSelectorScreen({super.key});

  @override
  State<LanguageSelectorScreen> createState() => _LanguageSelectorScreenState();
}

class _LanguageSelectorScreenState extends State<LanguageSelectorScreen> {
  Locale _selectedLocale = const Locale('en');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🟠 Logo Image (Add your logo in assets/images/logo.png)
            Image.asset(
              'assets/images/logo.png',
              height: 120,
            ),

            const SizedBox(height: 40),

            // 🔵 Language Label
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'select_language'.tr(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // 🌍 Language Dropdown
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.deepPurple),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<Locale>(
                  value: _selectedLocale,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.deepPurple),
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(
                      value: Locale('en'),
                      child: Row(
                        children: [
                          Icon(Icons.language, color: Colors.deepPurple),
                          SizedBox(width: 8),
                          Text('English'),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: Locale('hi'),
                      child: Row(
                        children: [
                          Icon(Icons.language, color: Colors.deepPurple),
                          SizedBox(width: 8),
                          Text('हिन्दी'),
                        ],
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedLocale = value;
                      });
                    }
                  },
                ),
              ),
            ),

            const SizedBox(height: 30),

            // 🔘 Continue Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.setLocale(_selectedLocale);
                  context.go('/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text(
                  'CONTINUE',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
