// lib/screens/booking/checkout_screen.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ticket_booking_app/core/constants/colors.dart';
import '../../providers/booking_cart_provider.dart';
import '../../core/services/api_service.dart';

class CheckoutScreen extends StatefulWidget {
  final String userId;
  const CheckoutScreen({super.key, required this.userId});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<BookingCartProvider>(context);
    final entries = cart.selectedEntryTickets;
    final parkings = cart.selectedParking;
    final attractions = cart.selectedAttractions;
    final movies = cart.selectedMovies;
    final attractionVisitorSlots = cart.selectedAttractionVisitorSlots;
    final movieVisitorSlots = cart.selectedMovieVisitorSlots;

    final entryPax = cart.entryTicketPax;
    final entryAmount = cart.entryTotalAmount;

    final parkingPax = cart.parkingPax;
    final parkingAmount = cart.parkingTotalAmount;

    final attractionPax = cart.attractionVisitorPax;
    final attractionAmount = cart.visitorAttractionTotalAmount;

    final moviePax = cart.movieVisitorPax;
    final movieAmount = cart.movieVisitorTotalAmount;

    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: AppColors.purpleDark,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'bookingOverview'.tr(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: [
                if (entries.isNotEmpty)
                  _buildSection('Entry Tickets', Icons.confirmation_number, [
                    for (final e in entries)
                      _buildLineItem(
                        title: e.name,
                        count: e.count,
                        unitPrice: e.price,
                      ),
                    _buildPaxAmountSummary(entryPax, entryAmount),
                  ]),
                if (parkings.isNotEmpty)
                  _buildSection('Parking', Icons.local_parking, [
                    for (final p in parkings)
                      _buildLineItem(
                        title: p.vehicleType.name.toUpperCase(),
                        count: p.count,
                        unitPrice: p.price,
                      ),
                    _buildPaxAmountSummary(parkingPax, parkingAmount),
                  ]),
                if (attractions.isNotEmpty)
                  _buildSection('Attractions', Icons.rocket_launch, [
                    for (final attraction in attractions)
                      if (attractionVisitorSlots.any(
                        (slot) => slot.attractionId == attraction.id,
                      )) ...[
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 4),
                          child: Text(
                            attraction.title,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        for (final slot in attractionVisitorSlots.where(
                          (s) => s.attractionId == attraction.id,
                        ))
                          _buildLineItem(
                            title: slot.type.name,
                            count: slot.count,
                            unitPrice: slot.price,
                          ),
                      ],
                    _buildPaxAmountSummary(attractionPax, attractionAmount),
                  ]),

                if (movies.isNotEmpty)
                  _buildSection('Movies', Icons.movie, [
                    for (final movie in movies)
                      if (movieVisitorSlots.any(
                        (slot) => slot.attractionId == movie.id,
                      )) ...[
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 4),
                          child: Text(
                            movie.title,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        for (final slot in movieVisitorSlots.where(
                          (s) => s.attractionId == movie.id,
                        ))
                          _buildLineItem(
                            title: slot.type.name,
                            count: slot.count,
                            unitPrice: slot.price,
                          ),
                      ],
                    _buildPaxAmountSummary(moviePax, movieAmount),
                  ]),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: const Border(top: BorderSide(color: Colors.grey)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Total Pax: ${cart.totalPax}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  'Total Amount: ₹${cart.overallTotalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
  final cart = context.read<BookingCartProvider>();
  final bookingId = await ApiService.createBooking(widget.userId, cart);

  if (bookingId != null) {
    context.push('/payment', extra: {
      'userId': widget.userId,
      'amount': cart.overallTotalAmount,
      'bookingId': bookingId,
    });
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text('failedToCreateBooking'.tr())),
    );
  }
},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    backgroundColor: AppColors.purpleDark,
                  ),
                  child:  Text('proceedToPay'.tr(),
                  style: TextStyle(fontSize: 16, color: Colors.white),),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, IconData icon, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.deepPurple),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ...items,
        const Divider(thickness: 1),
      ],
    );
  }

  Widget _buildLineItem({
    required String title,
    required int count,
    required double unitPrice,
  }) {
    final total = count * unitPrice;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Row(
        children: [
          Expanded(child: Text('$title × $count')),
          Text(
            '₹${total.toStringAsFixed(2)}',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

Widget _buildPaxAmountSummary(int pax, double amount) {
  return Padding(
    padding: const EdgeInsets.only(top: 4, left: 8, right: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Total Pax: $pax',
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        Text(
          '₹${amount.toStringAsFixed(2)}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
