// lib/widgets/booking_summary_card.dart

import 'package:flutter/material.dart';

class BookingSummaryCard extends StatelessWidget {
  final String title;
  final List<String> summaryList;

  const BookingSummaryCard({
    super.key,
    required this.title,
    required this.summaryList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          const SizedBox(height: 8),
          ...summaryList.map((s) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Text(s),
              )),
        ],
      ),
    );
  }
}
