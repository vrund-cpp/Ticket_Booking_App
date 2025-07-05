import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../features/auth/model/user.dart';

class ProfileCard extends StatelessWidget {
  final bool isEdit;
  final User? user;
  final TextEditingController nameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController mobileCtrl;
  final VoidCallback onSave;

  const ProfileCard({
    super.key,
    required this.isEdit,
    required this.user,
    required this.nameCtrl,
    required this.emailCtrl,
    required this.mobileCtrl,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: isEdit
            ? Form(
                key: formKey,
                child: Column(
                  children: [
                    _buildField(
                      controller: nameCtrl,
                      label: 'Full Name'.tr(),
                      enabled: isEdit,
                      keyboardType: TextInputType.name,
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return 'Name is required'.tr();
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildField(
                      controller: emailCtrl,
                      label: 'Email id'.tr(),
                      enabled: isEdit,
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return 'Email is required'.tr();
                        }
                        final emailRegex = RegExp(
                          r'^[\w.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,10}(\.[a-zA-Z]{2,10})?$',
                        );
                        return emailRegex.hasMatch(val)
                            ? null
                            : 'Invalid email';
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildField(
                      controller: mobileCtrl,
                      label: 'Mobile Number'.tr(),
                      enabled: isEdit,
                      keyboardType: TextInputType.phone,
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return 'Mobile number is required'.tr();
                        }
                        final phoneRegex = RegExp(r'^\d{10}$');
                        return phoneRegex.hasMatch(val)
                            ? null
                            : 'Invalid mobile number'.tr();
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            onSave();
                          }
                        },
                        icon: const Icon(Icons.save),
                        label: Text('Save'.tr()),
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.name ?? '',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(child: _infoTile('Email id', user?.email ?? '')),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _infoTile('Mobile Number', user?.mobile ?? ''),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  Widget _infoTile(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.tr(),
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF6A1B9A), // purple-blue like screenshot
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required bool enabled,
    required TextInputType keyboardType,
    required String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
