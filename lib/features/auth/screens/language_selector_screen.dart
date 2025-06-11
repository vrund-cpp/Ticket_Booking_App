import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'package:ticket_booking_app/generated/app_localizations.dart';

class LanguageSelectorScreen extends StatefulWidget {
  const LanguageSelectorScreen({super.key});

  @override
  State<LanguageSelectorScreen> createState() => _LanguageSelectorScreenState();
}

class _LanguageSelectorScreenState extends State<LanguageSelectorScreen> {
  String selectedLang = 'en';

  final languages = {
    'en': 'English',
    'hi': 'हिंदी',
  };

  Future<void> _continue() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLanguageSelected', true);
    await prefs.setString('languageCode', selectedLang);

    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', height: 120),
              const SizedBox(height: 40),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!.selectLanguage,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF1E008A),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.language, color: Color(0xFF1E008A)),
                  border: UnderlineInputBorder(),
                ),
                value: selectedLang,
                items: languages.entries.map((entry) {
                  return DropdownMenuItem<String>(
                    value: entry.key,
                    child: Text(entry.value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => selectedLang = value!);
                },
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E008A),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _continue,
                  child: Text(AppLocalizations.of(context)!.continueLabel),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
