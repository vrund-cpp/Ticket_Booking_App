import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ticket_booking_app/core/constants/colors.dart';

import '../../models/entry_ticket.dart';
import '../../core/services/api_service.dart';
import '../../providers/booking_cart_provider.dart';
import '../../widgets/booking_tab_bar.dart';// your custom color file

class EntryTicketScreen extends StatefulWidget {
  final String userId;
  const EntryTicketScreen({super.key, required this.userId});

  @override
  State<EntryTicketScreen> createState() => _EntryTicketScreenState();
}

class _EntryTicketScreenState extends State<EntryTicketScreen> {
  late Future<List<EntryTicket>> _ticketsFuture;

  @override
  void initState() {
    super.initState();
    _ticketsFuture = ApiService.fetchEntryTickets();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<BookingCartProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFEDEFFC), // background light purple
            appBar: AppBar(
        backgroundColor: AppColors.purpleDark,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'entryTicketsBooking'.tr(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
            ),
      body: SafeArea(
        child: Column(
          children: [
            BookingTabBar(activeTab: BookingTab.entry, userId: widget.userId),

            // Title + Subtitle
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Add Audience',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 20)),
                  const SizedBox(height: 4),
                  Text('Select Audience for Entry Ticket',
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Ticket Cards
            Expanded(
              child: FutureBuilder<List<EntryTicket>>(
                future: _ticketsFuture,
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('errorLoadingTickets'.tr()));
                  } else {
                    final tickets = snapshot.data!;
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      itemCount: tickets.length,
                      itemBuilder: (ctx, i) {
                        final ticket = tickets[i];
                        final count = cart.selectedEntryTickets
                            .firstWhere(
                              (x) => x.id == ticket.id,
                              orElse: () => EntryTicket(
                                  id: '', name: '', price: 0, description: ''),
                            )
                            .count;

                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.person_outline,
                                  size: 48,
                                  color: Colors.grey[700],
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(ticket.name,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 4),
                                      Text(
                                        ticket.description ?? '',
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.black54),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '₹ ${ticket.price.toStringAsFixed(0)} / Pax',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.purple),
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: count > 0
                                          ? () => cart.removeTicket(ticket)
                                          : null,
                                      icon: const Icon(
                                        Icons.remove_circle_outline,
                                        color: Colors.purple,
                                      ),
                                    ),
                                    Text(
                                      '$count',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    IconButton(
                                      onPressed: () =>
                                          cart.addTicket(ticket),
                                      icon: const Icon(
                                        Icons.add_circle_outline,
                                        color: Colors.purple,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),

            // Bottom Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => context.push(
                          '/parking-options/booking',
                          extra: widget.userId),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4B1FA3), // purple
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text('Book Parking',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () =>
                          context.push('/checkout', extra: widget.userId),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFC107), // amber
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text('Checkout',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: Colors.black)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}



// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';
// import '../../models/entry_ticket.dart';
// import '../../core/services/api_service.dart';
// import '../../providers/booking_cart_provider.dart';
// import 'package:ticket_booking_app/widgets/booking_tab_bar.dart';

// class EntryTicketScreen extends StatefulWidget {
//   final String userId;
//   const EntryTicketScreen({super.key, required this.userId});

//   @override
//   State<EntryTicketScreen> createState() => _EntryTicketScreenState();
// }

// class _EntryTicketScreenState extends State<EntryTicketScreen> {
//   late Future<List<EntryTicket>> _ticketsFuture;

//   @override
//   void initState() {
//     super.initState();
//     _ticketsFuture = ApiService.fetchEntryTickets();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cart = Provider.of<BookingCartProvider>(context);
//     return Scaffold(
//       appBar: AppBar(title:  Text('entryTickets'.tr())),
//       body: SafeArea(
//         child: Column(
//         children: [
//           BookingTabBar(activeTab: BookingTab.entry, userId: widget.userId),
//           // Container(
//           //   padding: const EdgeInsets.all(12),
//           //   color: Colors.yellow[100],
//           //   width: double.infinity,
//           //   child: Text(
//           //     'Total: ₹${cart.entryTotalAmount.toStringAsFixed(2)}',
//           //     style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           //   ),
//           // ),
//           Expanded(
//             child: FutureBuilder<List<EntryTicket>>(
//               future: _ticketsFuture,
//               builder: (ctx, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   return  Center(child: Text('errorLoadingTickets'.tr()));
//                 } else {
//                   final tickets = snapshot.data!;
//                   return ListView.builder(
//                     itemCount: tickets.length,
//                     itemBuilder: (ctx, i) {
//                       final t = tickets[i];
//                       final count = cart.selectedEntryTickets
//                           .firstWhere(
//                             (x) => x.id == t.id,
//                             orElse: () =>
//                                 EntryTicket(id: '', name: '', price: 0),
//                           )
//                           .count;

//                       return Card(
//                         margin: const EdgeInsets.symmetric(
//                           horizontal: 12,
//                           vertical: 6,
//                         ),
//                         child: ListTile(
//                           leading: const Icon(Icons.confirmation_number),
//                           title: Text(t.name),
//                           subtitle: Text('₹${t.price.toStringAsFixed(2)}'),
//                           trailing: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               IconButton(
//                                 icon: const Icon(Icons.remove_circle_outline),
//                                 onPressed: count > 0
//                                     ? () => cart.removeTicket(t)
//                                     : null,
//                               ),
//                               Text('$count'),
//                               IconButton(
//                                 icon: const Icon(Icons.add_circle_outline),
//                                 onPressed: () => cart.addTicket(t),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 }
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () => context.push('/parking-options/booking',extra: widget.userId),
//                     child:  Text('bookParking'.tr()),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () => context.push('/checkout',extra: widget.userId),
//                     child:  Text('Checkout'.tr()),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//         ),
//       ),
//     );
//   }
// }
