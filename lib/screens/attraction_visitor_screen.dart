// lib/screens/attraction_visitors_screen.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../models/visitor_slot.dart';
import '../../providers/booking_cart_provider.dart';
import 'package:ticket_booking_app/widgets/booking_tab_bar.dart';
import 'package:ticket_booking_app/core/constants/colors.dart';

class AttractionVisitorScreen extends StatefulWidget  {
final String userId;
const AttractionVisitorScreen({super.key, required this.userId});

  @override
  State<AttractionVisitorScreen> createState() => _AttractionVisitorScreenState();
}

class _AttractionVisitorScreenState extends State<AttractionVisitorScreen>{

  @override
Widget build(BuildContext context) {
final cart = Provider.of<BookingCartProvider>(context);
final selected = cart.selectedAttractions;

return Scaffold(
  backgroundColor: const Color(0xFFF0F2FA),
      appBar: AppBar(
        backgroundColor: AppColors.purpleDark,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Booking'.tr(),
          style: const TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
    children: [
BookingTabBar(activeTab: BookingTab.attraction, userId: widget.userId),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('addVisitors'.tr(),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          )),
                  const SizedBox(height: 4),
                  Text('selectVisitorsForAttractions'.tr(),
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                      )),
                ],
              ),
            ),
            const SizedBox(height: 12),      
      Expanded(
        child: ListView.builder(
          itemCount: selected.length,
          itemBuilder: (ctx, i) {
            final a = selected[i];
            final pax = cart.totalPaxForAttraction(a.id);
            final amt = cart.totalAmountForAttraction(a.id);
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(a.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 8),
                    if (a.priceKid > 0)
                          _buildTypeTile(context, cart, a.id, UserType.kid, a.priceKid),
                        if (a.priceSchool > 0)
                          _buildTypeTile(context, cart, a.id, UserType.school, a.priceSchool),
                        if (a.priceAdult > 0)
                          _buildTypeTile(context, cart, a.id, UserType.adult, a.priceAdult),
                        const SizedBox(height: 8),Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Pax: $pax',
                                style: const TextStyle(fontWeight: FontWeight.w500)),
                            Text('Amount: ₹${amt.toStringAsFixed(0)}',
                                style: const TextStyle(fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
      Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => context.push('/movies/booking',extra: widget.userId),
                                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.purpleDark,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child:  Text(
                        'bookMovieTicket'.tr(),
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () => context.push('/checkout', extra: widget.userId),
                style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber[700],
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child:  Text(
                        'Checkout'.tr(),
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
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

Widget _buildTypeTile(BuildContext context, BookingCartProvider cart,
int attractionId, UserType type, double price) {
final key = '$attractionId-${type.name}';
final count = cart.selectedAttractionVisitorSlots
.firstWhere((s) => s.attractionId == attractionId && s.type == type,
orElse: () => VisitorSlot(
attractionId: attractionId,
type: type,
price: price,
count: 0,
),
)
.count;

return Padding(
  padding: const EdgeInsets.symmetric(vertical: 6.0),
  child: Row(
    children: [
      Text(
        '${type.name[0].toUpperCase()}${type.name.substring(1)}',
        style: const TextStyle(fontSize: 14),
      ),
      const SizedBox(width: 8),
      IconButton(
        icon: const Icon(Icons.remove_circle_outline),
        onPressed: count > 0
            ? () => cart.decrementAttractionVisitorSlot(attractionId, type)
            : null,
      ),
      Text('$count',
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
      IconButton(
        icon: const Icon(Icons.add_circle_outline),
        onPressed: () => cart.incrementAttractionVisitorSlot(attractionId, type, price),
      ),
      const SizedBox(width: 6),
                Text('× ₹${price.toInt()}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              )),
    ],
  ),
);
  }
}


// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import '../../../core/constants/colors.dart';
// import '../../../models/attraction.dart';
// import '../../../widgets/visitor_counter.dart';

// class AttractionVisitorsScreen extends StatefulWidget {
//   final String userId;
//   final List<Attraction> selectedAttractions;
//   const AttractionVisitorsScreen({super.key, required this.selectedAttractions, required this.userId});

//   @override
//   State<AttractionVisitorsScreen> createState() => _AttractionVisitorsScreenState();
// }

// class _AttractionVisitorsScreenState extends State<AttractionVisitorsScreen> {
//   final Map<int, Map<String, int>> visitorCounts = {};

//   @override
//   void initState() {
//     super.initState();
//     for (var attraction in widget.selectedAttractions) {
//       visitorCounts[attraction.id] = {
//         'adult': 0,
//         'kid': 0,
//         'school': 0,
//       };
//     }
//   }

//   double _calculateAmount(Attraction attraction) {
//     final counts = visitorCounts[attraction.id]!;
//     return (counts['adult']! * attraction.priceAdult) +
//            (counts['kid']! * attraction.priceKid) +
//            (counts['school']! * attraction.priceSchool);
//   }

//   int _calculatePax(Attraction attraction) {
//     final counts = visitorCounts[attraction.id]!;
//     return counts['adult']! + counts['kid']! + counts['school']!;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Visitors'),
//         backgroundColor: AppColors.purpleDark,
//       ),
//       body: ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: widget.selectedAttractions.length,
//         itemBuilder: (context, index) {
//           final attraction = widget.selectedAttractions[index];
//           final counts = visitorCounts[attraction.id]!;

//           return Card(
//             margin: const EdgeInsets.only(bottom: 16),
//             elevation: 3,
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//             child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(attraction.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 8),
//                   if (attraction.priceAdult > 0)
//                     VisitorCounter(
//                       label: 'Adult',
//                       count: counts['adult']!,
//                       price: attraction.priceAdult,
//                       onIncrement: () => setState(() => counts['adult'] = counts['adult']! + 1),
//                       onDecrement: () => setState(() => counts['adult'] = (counts['adult']! - 1).clamp(0, 999)),
//                     ),
//                   if (attraction.priceKid > 0)
//                     VisitorCounter(
//                       label: 'Kids',
//                       count: counts['kid']!,
//                       price: attraction.priceKid,
//                       onIncrement: () => setState(() => counts['kid'] = counts['kid']! + 1),
//                       onDecrement: () => setState(() => counts['kid'] = (counts['kid']! - 1).clamp(0, 999)),
//                     ),
//                   if (attraction.priceSchool > 0)
//                     VisitorCounter(
//                       label: 'School',
//                       count: counts['school']!,
//                       price: attraction.priceSchool,
//                       onIncrement: () => setState(() => counts['school'] = counts['school']! + 1),
//                       onDecrement: () => setState(() => counts['school'] = (counts['school']! - 1).clamp(0, 999)),
//                     ),
//                   const SizedBox(height: 8),
//                   Text('Pax: ${_calculatePax(attraction)}'),
//                   Text('Amount: ₹${_calculateAmount(attraction).toStringAsFixed(0)}'),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Row(
//           children: [
//             Expanded(
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(backgroundColor: AppColors.accentOrange),
//                 onPressed: () {
//                   context.push('/movies/booking');
//                 },
//                 child: const Text('Book Movie Ticket'),
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(backgroundColor: AppColors.purpleDark),
//                 onPressed:  () async {
//                   await context.push('/booking/summary/:userId',extra: widget.userId);
//                   if(!mounted)return;
//                 },
//                 child: const Text('Checkout'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
