// lib/widgets/outreach_card.dart

import 'package:flutter/material.dart';
import '../models/outreach.dart';

/// A card representing a single Outreach item in the vertical list.
class OutreachCard extends StatelessWidget {
  final Outreach item;

  const OutreachCard({super.key, required this.item});
              
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Thumbnail image on the left
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Container(
              width: 60,
              height: 60,
              margin: const EdgeInsets.all(10),
              color: Colors.grey[300],
              child: Image.network(
                item.imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Text area on the right
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Description
                  Text(
                    item.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF4A4A4A),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Spacer(),
                  // Date row with calendar icon
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 14,
                        color: Color(0xFF591EB3),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${_formatDate(item.Startdate)} to ${_formatDate(item.Enddate)}',
                        style: const TextStyle(
                          color: Color(0xFF757575),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper to format a DateTime as “DD MMM YYYY” (e.g. “16 Apr 2019”)
  String _formatDate(DateTime dt) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    final day = dt.day.toString().padLeft(2, '0');
    final month = months[dt.month - 1];
    final year = dt.year.toString();
    return '$day $month $year';
  }
}
