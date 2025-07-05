// lib/widgets/stepper_selector.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class StepperSelector extends StatelessWidget {
  final String title;
  final String description;
  final int price;
  final int count;
  final Function(int) onChanged;
  final IconData icon;

  const StepperSelector({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.count,
    required this.onChanged,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey.shade100,
              child: Icon(icon, color: Colors.grey.shade800),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '₹ {price} / Pax'.tr(args: [price.toString()]),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    if (count > 0) onChanged(count - 1);
                  },
                ),
                Text('$count', style: const TextStyle(fontSize: 16)),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () {
                    onChanged(count + 1);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
