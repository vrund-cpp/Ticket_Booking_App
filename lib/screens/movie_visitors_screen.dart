// lib/screens/movie_visitors_screen.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ticket_booking_app/core/constants/colors.dart';
import '../../models/visitor_slot.dart';
import '../../providers/booking_cart_provider.dart';
import 'package:ticket_booking_app/widgets/booking_tab_bar.dart';

class MovieVisitorsScreen extends StatefulWidget  {
final String userId;
const MovieVisitorsScreen({super.key, required this.userId});
  @override
  State<MovieVisitorsScreen> createState() => _MovieVisitorsScreenState();
}

class _MovieVisitorsScreenState extends State<MovieVisitorsScreen>{

  @override
  Widget build(BuildContext context) {
final cart = Provider.of<BookingCartProvider>(context);
final selectedMovies = cart.selectedMovies;
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
BookingTabBar(activeTab: BookingTab.movie, userId: widget.userId),
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
          itemCount: selectedMovies.length,
          itemBuilder: (ctx, i) {
            final m = selectedMovies[i];
final pax = cart.totalPaxForMovie(m.id);
                  final amt = cart.totalAmountForMovie(m.id);
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
                    Text(m.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 8),
                        if (m.priceAdult > 0)
                          _buildTypeTile(context, cart, m.id, UserType.adult, m.priceAdult),
                        if (m.priceKid > 0)
                          _buildTypeTile(context, cart, m.id, UserType.kid, m.priceKid),
                        if (m.priceSchool > 0)
                          _buildTypeTile(context, cart, m.id, UserType.school, m.priceSchool),
                        const SizedBox(height: 8),
                        Row(
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
        child: SizedBox(
          width: double.infinity,
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
            ),
          ],
        ),
      ),
    );
  }

Widget _buildTypeTile(BuildContext context, BookingCartProvider cart,
int movieId, UserType type, double price) {
final key = '$movieId-${type.name}';
final count = cart.selectedMovieVisitorSlots
.firstWhere((s) => s.attractionId == movieId && s.type == type,
orElse: () => VisitorSlot(
attractionId: movieId,
type: type,
price: price,
count: 0,
),)
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
            ? () => cart.decrementMovieVisitorSlot(movieId, type)
            : null,
      ),
      Text('$count',
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
      IconButton(
        icon: const Icon(Icons.add_circle_outline),
        onPressed: () => cart.incrementMovieVisitorSlot(movieId, type, price),
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
// import '../../../models/movie.dart';
// import '../../../widgets/visitor_counter.dart';

// class MovieVisitorsScreen extends StatefulWidget {
//   final String userId;
//   final List<Movie> selectedMovies;
//   const MovieVisitorsScreen({super.key, required this.selectedMovies, required this.userId});

//   @override
//   State<MovieVisitorsScreen> createState() => _MovieVisitorsScreenState();
// }

// class _MovieVisitorsScreenState extends State<MovieVisitorsScreen> {
//   final Map<int, Map<String, int>> visitorCounts = {};

//   @override
//   void initState() {
//     super.initState();
//     for (var Movie in widget.selectedMovies) {
//       visitorCounts[Movie.id] = {
//         'adult': 0,
//         'kid': 0,
//         'school': 0,
//       };
//     }
//   }

//   double _calculateAmount(Movie movie) {
//     final counts = visitorCounts[movie.id]!;
//     return (counts['adult']! * movie.priceAdult) +
//            (counts['kid']! * movie.priceKid) +
//            (counts['school']! * movie.priceSchool);
//   }

//   int _calculatePax(Movie movie) {
//     final counts = visitorCounts[movie.id]!;
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
//         itemCount: widget.selectedMovies.length,
//         itemBuilder: (context, index) {
//           final movie = widget.selectedMovies[index];
//           final counts = visitorCounts[movie.id]!;

//           return Card(
//             margin: const EdgeInsets.only(bottom: 16),
//             elevation: 3,
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//             child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(movie.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 8),
//                   if (movie.priceAdult > 0)
//                     VisitorCounter(
//                       label: 'Adult',
//                       count: counts['adult']!,
//                       price: movie.priceAdult,
//                       onIncrement: () => setState(() => counts['adult'] = counts['adult']! + 1),
//                       onDecrement: () => setState(() => counts['adult'] = (counts['adult']! - 1).clamp(0, 999)),
//                     ),
//                   if (movie.priceKid > 0)
//                     VisitorCounter(
//                       label: 'Kids',
//                       count: counts['kid']!,
//                       price: movie.priceKid,
//                       onIncrement: () => setState(() => counts['kid'] = counts['kid']! + 1),
//                       onDecrement: () => setState(() => counts['kid'] = (counts['kid']! - 1).clamp(0, 999)),
//                     ),
//                   if (movie.priceSchool > 0)
//                     VisitorCounter(
//                       label: 'School',
//                       count: counts['school']!,
//                       price: movie.priceSchool,
//                       onIncrement: () => setState(() => counts['school'] = counts['school']! + 1),
//                       onDecrement: () => setState(() => counts['school'] = (counts['school']! - 1).clamp(0, 999)),
//                     ),
//                   const SizedBox(height: 8),
//                   Text('Pax: ${_calculatePax(movie)}'),
//                   Text('Amount: ₹${_calculateAmount(movie).toStringAsFixed(0)}'),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(16),
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(backgroundColor: AppColors.accentOrange),
//           onPressed: () async {
//                   await context.push('/booking/summary/:userId',extra: widget.userId);
//                   if(!mounted)return;
//                 },
//           child: const Text('Checkout'),
//         ),
//       ),
//     );
//   }
// }
