// lib/widgets/quick_booking_item.dart

import 'package:flutter/material.dart';

/// A reusable circular icon + label for Quick Booking items.
class QuickBookingItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color circleColor;
  final VoidCallback onTap;

  const QuickBookingItem({
    super.key,
    required this.icon,
    required this.label,
    required this.circleColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          // Circular background with icon
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: circleColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 32),
          ),
          const SizedBox(height: 4),
          // Label below
          SizedBox(
            width: 72,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
