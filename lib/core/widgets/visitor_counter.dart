import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class VisitorCounter extends StatelessWidget {
  final String label;
  final int count;
  final double price;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const VisitorCounter({
    super.key,
    required this.label,
    required this.count,
    required this.price,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('${label.tr()}:', style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(width: 8),
        IconButton(
          onPressed: onDecrement,
          icon: const Icon(Icons.remove),
        ),
        Text('$count'),
        IconButton(
          onPressed: onIncrement,
          icon: const Icon(Icons.add),
        ),
        const SizedBox(width: 8),
        Text('× ₹${price.toInt()}'),
      ],
    );
  }
}
