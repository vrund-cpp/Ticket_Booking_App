import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:ticketease/core/services/api_service.dart';
import 'package:ticketease/features/parking-options/models/parking_option.dart';
import 'package:ticketease/features/booking/providers/booking_cart_provider.dart';
import 'package:ticketease/core/widgets/booking_tab_bar.dart';
import 'package:ticketease/core/constants/colors.dart';

class ParkingScreen extends StatefulWidget {
  final String userId;
  const ParkingScreen({super.key, required this.userId});

  @override
  State<ParkingScreen> createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<ParkingScreen> {
  late Future<List<ParkingOption>> _parkingFuture;

  @override
  void initState() {
    super.initState();
    _parkingFuture = ApiService.fetchParkingOptions();
  }

  String _getVehicleLabel(VehicleType type) {
    switch (type) {
      case VehicleType.two_wheeler:
        return 'Two Wheeler'.tr();
      case VehicleType.four_wheeler:
        return 'Four Wheeler'.tr();
      case VehicleType.school_bus:
        return 'School Bus'.tr();
    }
  }

  String _getVehicleDescription(VehicleType type) {
    switch (type) {
      case VehicleType.two_wheeler:
        return 'Scooter,Bike etc'.tr();
      case VehicleType.four_wheeler:
        return 'Car & Passenger Vehicles'.tr();
      case VehicleType.school_bus:
        return 'A min of 15 pax makes a group'.tr();
    }
  }

  IconData _getVehicleIcon(VehicleType type) {
    switch (type) {
      case VehicleType.two_wheeler:
        return Icons.motorcycle;
      case VehicleType.four_wheeler:
        return Icons.directions_car;
      case VehicleType.school_bus:
        return Icons.directions_bus;
    }
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
          'parkingBooking'.tr(),
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
            BookingTabBar(activeTab: BookingTab.parking, userId: widget.userId),
            // Title + Subtitle
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'selectParking'.tr(),
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'addYourVehicleType'.tr(),
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: FutureBuilder<List<ParkingOption>>(
                future: _parkingFuture,
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('errorLoadingParkingOptions'.tr()),
                    );
                  } else {
                    final options = snapshot.data!;
                    return ListView.builder(
                      itemCount: options.length,
                      itemBuilder: (ctx, i) {
                        final p = options[i];
                        final count = cart.selectedParking
                            .firstWhere(
                              (x) => x.id == p.id,
                              orElse: () => ParkingOption(
                                id: '',
                                vehicleType: VehicleType.two_wheeler,
                                description: '',
                                price: 0,
                              ),
                            )
                            .count;

                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                Icon(
                                  _getVehicleIcon(p.vehicleType),
                                  size: 48,
                                  color: Colors.grey[700],
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _getVehicleLabel(p.vehicleType),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        _getVehicleDescription(p.vehicleType),
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '₹ ${p.price.toStringAsFixed(2)} / Pax',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.purple,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: count > 0
                                          ? () => cart.removeParking(p)
                                          : null,
                                      icon: const Icon(
                                        Icons.remove_circle_outline,
                                        color: Colors.purple,
                                      ),
                                    ),
                                    Text(
                                      '$count',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => cart.addParking(p),
                                      icon: const Icon(
                                        Icons.add_circle_outline,
                                        color: Colors.purple,
                                      ),
                                    ),
                                  ],
                                ),
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

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => context.push(
                        '/attractions/booking',
                        extra: widget.userId,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4B1FA3), // purple
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'bookAttractions'.tr(),
                        style: Theme.of(
                          context,
                        ).textTheme.labelLarge!.copyWith(color: Colors.white),
                      ),
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
                      child: Text(
                        'Checkout'.tr(),
                        style: Theme.of(
                          context,
                        ).textTheme.labelLarge!.copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
