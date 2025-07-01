import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ticket_booking_app/core/constants/colors.dart';
import '../providers/profile_provider.dart';
import '../widgets/profile_card.dart';
import '../widgets/booking_history_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = true;


 @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await context.read<ProfileProvider>().fetchProfileData();
      if (mounted) {
        setState(() => isLoading = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<ProfileProvider>(context);

    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.purpleDark,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Profile'.tr(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => provider.toggleEdit(),
            color: Colors.white,
          ),
        ],
      ),
      body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ProfileCard(
                  isEdit: provider.isEdit,
                  user: provider.user,
                  nameCtrl: provider.nameCtrl,
                  emailCtrl: provider.emailCtrl,
                  mobileCtrl: provider.mobileCtrl,
                  onSave: provider.saveProfileChanges,
                ),
                const SizedBox(height: 24),
                 Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'bookingHistory'.tr(),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView.builder(
                    itemCount: provider.bookings.length,
                    itemBuilder: (_, i) =>
                        BookingHistoryCard(booking: provider.bookings[i]),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
