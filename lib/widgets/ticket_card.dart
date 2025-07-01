// import 'package:flutter/material.dart';
// import '../core/constants/colors.dart';

// class TicketCard extends StatelessWidget {
//   final String title;
//   final double price;
//   final int quantity;
//   final VoidCallback onAdd;
//   final VoidCallback onRemove;

//   const TicketCard({
//     super.key,
//     required this.title,
//     required this.price,
//     required this.quantity,
//     required this.onAdd,
//     required this.onRemove,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 16),
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: ListTile(
//         leading: CircleAvatar(
//           backgroundColor: AppColors.purpleLight,
//           child: Text(title[0]),
//         ),
//         title: Text(title),
//         subtitle: Text('₹ ${price.toStringAsFixed(2)}'),
//         trailing: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             IconButton(
//               onPressed: onRemove,
//               icon: const Icon(Icons.remove_circle_outline),
//             ),
//             Text('$quantity', style: const TextStyle(fontSize: 16)),
//             IconButton(
//               onPressed: onAdd,
//               icon: const Icon(Icons.add_circle_outline),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../models/entry_ticket.dart';
import '../core/constants/colors.dart';

class TicketCard extends StatelessWidget {
  final EntryTicket ticket;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const TicketCard({
    super.key,
    required this.ticket,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.purpleLight,
              radius: 24,
              child: Icon(Icons.confirmation_number, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ticket.name,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      ticket.description!,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text('₹${ticket.price.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: onRemove,
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Text('$quantity'),
                IconButton(
                  onPressed: onAdd,
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
