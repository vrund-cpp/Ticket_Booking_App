import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../models/booking_history.dart';

class BookingHistoryCard extends StatelessWidget {
  final BookingHistory booking;

  const BookingHistoryCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(booking.statusText);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                 Text('bookingNo:'.tr()),
                 const SizedBox(width: 4),
                Text(
                  '#${booking.id.substring(0, 8)}',
                  style: const TextStyle(color: Colors.blue),
                ),
              ],
            ),
            const SizedBox(height: 12),
                     /// Grid-like 2x2 layout
            Row(
              children: [
                Expanded(child: _itemBox('Entry Tickets', booking.entryAmount)),
                const SizedBox(width: 8),
                Expanded(child: _itemBox('Parking', booking.parkingAmount)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: _itemBox('Attractions', booking.attractionAmount)),
                const SizedBox(width: 8),
                Expanded(child: _itemBox('Movies', booking.movieAmount)),
              ],
            ),

            const SizedBox(height: 12),
/// Total
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Total ₹ ${booking.total.toStringAsFixed(0)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 8),
            /// Date + Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(booking.formattedDate),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: statusColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    booking.statusText.toUpperCase(),
                    style: TextStyle(color: statusColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget _itemBox(String title, double amount) {
    return Container(
        padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 6),
          Text('₹ ${amount.toStringAsFixed(0)}',
              style: const TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w600)),
        ],
              ),
    );
  }
  
Color _statusColor(String status) {
    switch (status) {
      case 'paid':
        return Colors.green;
      case 'failed':
        return Colors.red;
      case 'cancelled':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
