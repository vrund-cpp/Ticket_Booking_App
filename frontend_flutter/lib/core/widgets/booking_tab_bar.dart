import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../features/booking/providers/booking_cart_provider.dart';
import '../constants/colors.dart';

enum BookingTab { entry, parking, attraction, movie }

class BookingTabBar extends StatelessWidget {
  final BookingTab activeTab;
  final String userId;

  const BookingTabBar({
    super.key,
    required this.activeTab,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<BookingCartProvider>();

    double currentTotal = 0.0;
    switch (activeTab) {
      case BookingTab.entry:
        currentTotal = cart.entryTotalAmount;
        break;
      case BookingTab.parking:
        currentTotal = cart.parkingTotalAmount;
        break;
      case BookingTab.attraction:
        currentTotal = cart.visitorAttractionTotalAmount;
        break;
      case BookingTab.movie:
        currentTotal = cart.movieVisitorTotalAmount;
        break;
    }

    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 12, bottom: 8),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.purpleDark, AppColors.purpleLight],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 92,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                _buildTab(
                  context,
                  icon: Icons.confirmation_number_outlined,
                  label: 'ENTRY TICKET'.tr(),
                  isActive: activeTab == BookingTab.entry,
                  price: cart.entryTotalAmount,
                  circleColor: AppColors.accentOrange,
                  onTap: () =>
                      context.push('/entry-tickets/booking', extra: userId),
                ),
                const SizedBox(width: 12),
                _buildTab(
                  context,
                  icon: Icons.local_parking,
                  label: 'PARKING'.tr(),
                  isActive: activeTab == BookingTab.parking,
                  price: cart.parkingTotalAmount,
                  circleColor: AppColors.cyanAccent,
                  onTap: () =>
                      context.push('/parking-options/booking', extra: userId),
                ),
                const SizedBox(width: 12),
                _buildTab(
                  context,
                  icon: Icons.rocket_launch,
                  label: 'ATTRACTIONS'.tr(),
                  isActive: activeTab == BookingTab.attraction,
                  price: cart.visitorAttractionTotalAmount,
                  circleColor: Colors.purple,
                  onTap: () =>
                      context.push('/attractions/booking', extra: userId),
                ),
                const SizedBox(width: 12),
                _buildTab(
                  context,
                  icon: Icons.movie_creation_outlined,
                  label: 'MOVIES'.tr(),
                  isActive: activeTab == BookingTab.movie,
                  price: cart.movieVisitorTotalAmount,
                  circleColor: AppColors.accentOrange,
                  onTap: () => context.push('/movies/booking', extra: userId),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          const Icon(Icons.keyboard_arrow_up, color: Colors.white54, size: 18),
        ],
      ),
    );
  }

  Widget _buildTab(
    BuildContext context, {
    required IconData icon,
    required String label,
    required bool isActive,
    required double price,
    required Color circleColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 85,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
        decoration: isActive
            ? BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              )
            : null,
        child: Column(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: circleColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(height: 4),
            Text(
              label.tr(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            if (isActive)
              Text(
                '₹${price.toInt()}',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
