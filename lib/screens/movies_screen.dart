import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../core/services/api_service.dart';
import '../../models/movie.dart';
import '../../providers/booking_cart_provider.dart';
import 'package:ticket_booking_app/widgets/booking_tab_bar.dart';
import 'package:ticket_booking_app/core/constants/colors.dart';

class MoviesScreen  extends StatefulWidget  {
  final String userId;
  const MoviesScreen({super.key, required this.userId});

  @override
State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState  extends State<MoviesScreen> {
  late Future<List<Movie>> _future;

  @override
  void initState() {
    super.initState();
    _future = ApiService.fetchMovies();
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
          'movieBooking'.tr(),
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
BookingTabBar(activeTab: BookingTab.movie, userId: widget.userId),
Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'selectMovies'.tr(),
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
        child: FutureBuilder<List<Movie>>(
          future: _future,
          builder: (ctx, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snap.hasError) {
              return  Center(child: Text('errorLoadingMovies'.tr()));
            } else {
              final list = snap.data!;
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (ctx, i) {
                  final m = list[i];
                  final selected = cart.selectedMovies.any((x) => x.id == m.id);

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
                            leading: m.imageUrl != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      m.imageUrl,
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                          : const Icon(
                                    Icons.movie,
                                    color: Colors.orange,
                                    size: 40,
                                  ),
                            title: Text(
                              m.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text('Time: ${m.timeSlot ?? 'N/A'}, Format: ${m.format ?? ''}'),
                          Text('Lang: ${m.language ?? 'N/A'}, Duration: ${m.duration} mins'),
                          Text(
                              'Adult: ₹${m.priceAdult} Kid: ₹${m.priceKid} School: ₹${m.priceSchool}',
                              style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                      trailing: GestureDetector(
                        onTap: () => cart.toggleMovie(m),
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: selected ? Colors.green : Colors.transparent,
                            border: Border.all(color: Colors.grey),
                          ),
                          child: selected
                              ? const Icon(Icons.check, color: Colors.white, size: 16)
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
                onPressed: () =>
                    context.push('/movies/visitors',extra: widget.userId),
                                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    backgroundColor: AppColors.purpleDark,
                  ),
                  child: Text(
                    'addVisitors'.tr(),
                    style: const TextStyle(fontSize: 16, color: Colors.white),
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