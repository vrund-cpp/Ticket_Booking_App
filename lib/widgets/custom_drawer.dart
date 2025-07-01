import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants/colors.dart';
import '../providers/profile_provider.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends StatelessWidget {
final String userId;
const CustomDrawer({super.key, required this.userId});

@override
Widget build(BuildContext context) {
  final profileProvider = context.watch<ProfileProvider>();
  final screenHeight = MediaQuery.of(context).size.height;

return Drawer(
  child: Column(
    children: [
      Container(
        height: screenHeight * 0.3, // ⬅️ 30% of screen height
        padding: const EdgeInsets.only(top: 48, bottom: 20, left: 20),
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.purpleDark, AppColors.purpleLight],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: !profileProvider.isLoaded
            ? const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  )  
            : GestureDetector(
      onTap: () {
        context.push('/profile');
      },
      child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center, 
                children: [
                  Text(profileProvider.user!.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      )),
                  const SizedBox(height: 6),
                  Text(profileProvider.user!.email,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                      ),
                ],
              ),
            ),
      ),
      ListTile(
        leading: const Icon(Icons.dashboard_outlined),
        title:  Text('Dashboard'.tr()),
        onTap: () => context.go('/dashboard',extra: userId),
      ),
      ListTile(
        leading: const Icon(Icons.login_outlined),
        title:  Text('signIn'.tr()),
        onTap: () => context.go('/login'),
      ),
      ListTile(
        leading: const Icon(Icons.settings_outlined),
        title:  Text('Settings'.tr()),
        onTap:  () async{await context.push('/settings',extra: userId);},
      ),
    ],
  ),
);
}
}