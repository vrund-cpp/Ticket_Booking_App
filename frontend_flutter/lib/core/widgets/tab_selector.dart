// lib/widgets/tab_selector.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';

class TabSelector extends StatelessWidget {
  final String activeTab;
  final double amount;

  const TabSelector({super.key, required this.activeTab, required this.amount});

  @override
  Widget build(BuildContext context) {
    final tabs = [
      'ENTRY TICKET'.tr(),
      'PARKING'.tr(),
      'ATTRACTIONS'.tr(),
      'MOVIES'.tr(),
    ];

    return Container(
      color: AppColors.purpleDark,
      child: Row(
        children: tabs.map((tab) {
          final isActive = tab == activeTab;
          return Expanded(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: isActive
                        ? Colors.white.withOpacity(0.2)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: [
                      Icon(
                        _getIcon(tab),
                        color: isActive ? Colors.white : Colors.white54,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        tab,
                        style: TextStyle(
                          fontSize: 12,
                          color: isActive ? Colors.white : Colors.white54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (isActive)
                        const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                          size: 18,
                        ),
                      if (isActive)
                        Text(
                          '₹ ${amount.toInt()}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  IconData _getIcon(String tab) {
    switch (tab) {
      case 'ENTRY TICKET':
        return Icons.confirmation_number_outlined;
      case 'PARKING':
        return Icons.local_parking;
      case 'ATTRACTIONS':
        return Icons.rocket_launch;
      case 'MOVIES':
        return Icons.movie_creation_outlined;
      default:
        return Icons.circle;
    }
  }
}
