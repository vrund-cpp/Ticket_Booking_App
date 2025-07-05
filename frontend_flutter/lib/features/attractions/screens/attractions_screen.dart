import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:ticket_booking_app/core/constants/colors.dart';
import '../../../../../core/services/api_service.dart';
import '../model/attraction.dart';
import '../../booking/providers/booking_cart_provider.dart';
import 'package:ticket_booking_app/core/widgets/booking_tab_bar.dart';

class AttractionsScreen extends StatefulWidget {
  final String userId;
  const AttractionsScreen({super.key, required this.userId});

  @override
  State<AttractionsScreen> createState() => _AttractionsScreenState();
}

class _AttractionsScreenState extends State<AttractionsScreen> {
  late Future<List<Attraction>> _future;

  @override
  void initState() {
    super.initState();
    _future = ApiService.fetchAttractions();
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
          'attractionBooking'.tr(),
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
            BookingTabBar(
              activeTab: BookingTab.attraction,
              userId: widget.userId,
            ),
            // Title + Subtitle
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'selectAttractions'.tr(),
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'youCanChooseOneAndMore'.tr(),
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
              child: FutureBuilder<List<Attraction>>(
                future: _future,
                builder: (ctx, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snap.hasError) {
                    return Center(child: Text('errorLoadingAttractions'.tr()));
                  } else {
                    final list = snap.data!;
                    return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (ctx, i) {
                        final a = list[i];
                        final selected = cart.selectedAttractions.any(
                          (x) => x.id == a.id,
                        );

                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
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
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            leading: a.imageUrl != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      a.imageUrl!,
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : const Icon(
                                    Icons.travel_explore,
                                    color: Colors.orange,
                                    size: 40,
                                  ),
                            title: Text(
                              a.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                'Adult: ₹${a.priceAdult}  Kids: ₹${a.priceKid}\nSchool: ₹${a.priceSchool}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  height: 1.4,
                                  color: Colors.purple,
                                ),
                              ),
                            ),
                            trailing: GestureDetector(
                              onTap: () => cart.toggleAttraction(a),
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: selected
                                      ? Colors.green
                                      : Colors.transparent,
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: selected
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 16,
                                      )
                                    : null,
                              ),
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.push(
                    '/attractions/visitors',
                    extra: widget.userId,
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    backgroundColor: AppColors.purpleDark,
                  ),
                  child: Text(
                    'addVisitors'.tr(),
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
