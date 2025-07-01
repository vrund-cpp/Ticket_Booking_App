// lib/screens/dashboard_screen.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ticket_booking_app/core/services/api_service.dart';
import 'package:ticket_booking_app/providers/profile_provider.dart';
import 'package:ticket_booking_app/widgets/custom_drawer.dart';
// import 'package:ticket_booking_app/core/services/auth_service.dart';
// import 'package:ticket_booking_app/core/services/notification_service.dart';
import '../../../core/constants/colors.dart';
import '../../../models/movie.dart';
import '../../../models/outreach.dart';
import '../../../models/attraction.dart';
import '../../../models/news.dart';
import '../../../widgets/quick_booking_item.dart';
import '../../../widgets/movie_card.dart';
import '../../../widgets/outreach_card.dart';
import '../../../widgets/attraction_card.dart';
import '../../../widgets/news_card.dart';
// import '../../../models/notification_item.dart';

class DashboardScreen extends StatefulWidget {
  final String userId;
  const DashboardScreen({super.key, required this.userId});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Futures for asynchronous data fetching
  late Future<List<Movie>> _moviesFuture;
  late Future<List<Outreach>> _outreachFuture;
  late Future<List<Attraction>> _attractionsFuture;
  late Future<List<News>> _newsFuture;
  late Future<int> _notifCountFuture;

  // Controller for Movie PageView & current page index
  final PageController _moviePageController = PageController(
    viewportFraction: 0.85,
  );
  int _currentMoviePage = 0;

  @override
  void initState() {
    super.initState();
    _moviesFuture = ApiService.fetchLatestMovies();
    _outreachFuture = ApiService.fetchLatestOutreach();
    _attractionsFuture = ApiService.fetchLatestAttractions();
    _newsFuture = ApiService.fetchLatestNews();
    _notifCountFuture = ApiService.getUnreadCount();
    
Future.microtask(() async {
  print('👀 Fetching profile...');
  await context.read<ProfileProvider>().fetchProfileData();
  print('✅ Profile loaded');
});

    _moviePageController.addListener(() {
      final next = _moviePageController.page!.round();
      if (_currentMoviePage != next) {
        setState(() {
          _currentMoviePage = next;
        });
      }
    });
  }

  // @override
  // void dispose() {
  //   _moviePageController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. Purple AppBar with Hamburger & Notification
      drawer: CustomDrawer(userId: widget.userId),
      appBar: AppBar(
        backgroundColor: AppColors.purpleDark,
        elevation: 0,
        leading: Builder(
          builder:(ctx)=>IconButton(
            icon: const Icon(Icons.menu, color:Colors.white, size:24),
            onPressed:()=>Scaffold.of(ctx).openDrawer(),
          ),
        ),
        title:  Text(
          'Dashboard'.tr(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GestureDetector(
              onTap: () async {
                await context.push('/notifications', extra: widget.userId);
  if (!mounted) return;
  setState(() {
    _notifCountFuture = ApiService.getUnreadCount();
  });
              },
              child: Stack(
                // alignment: Alignment.topRight,
                children: [
                  const Icon(
                    Icons.notifications,
                    color: Colors.white,
                    size: 24,
                  ),
                  FutureBuilder<int>(
                    future: _notifCountFuture,
                    builder: (ctx, snap) {
                      if (snap.hasData && snap.data! > 0) {
                        return Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            width: 16,
                            height: 16,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '${snap.data}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
      

        // 2. Body (scrollable)
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildQuickBookingSection(),
              _buildMoviesSection(),
              _buildOutreachSection(),
              _buildAttractionsSection(),
              _buildNewsSection(),
            ],
          )
        ),
    );
  }

  // -----------------------------
  // SECTION 1: Quick Booking
  // -----------------------------
  Widget _buildQuickBookingSection() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.purpleDark, AppColors.purpleLight],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title: "Quick Booking"
          Padding(
            padding: EdgeInsets.only(left: 16.0, bottom: 12.0),
            child: Text(
              'quickBooking'.tr(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          // Horizontal scroll of 4 circular items
          SizedBox(
            height: 100,
            child: Stack(
              children: [
                ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  children: [
                    QuickBookingItem(
                      icon: Icons.confirmation_number_outlined,
                      label: 'entryTicket'.tr(),
                      circleColor: AppColors.accentOrange,
                      onTap: () async {
                        await context.push('/entry-tickets/booking', extra: widget.userId);
                      },
                    ),
                    const SizedBox(width: 32),
                    QuickBookingItem(
                      icon: Icons.local_parking,
                      label: 'PARKING'.tr(),
                      circleColor: AppColors.cyanAccent,
                      onTap: () async {
                        await context.push('/parking-options/booking', extra: widget.userId);
                      },
                    ),
                    const SizedBox(width: 32),
                    QuickBookingItem(
                      icon: Icons.rocket_launch,
                      label: 'ATTRACTIONS'.tr(),
                      circleColor: Colors.purple,
                      onTap: () async {
                        await context.push('/attractions/booking', extra: widget.userId);
                      },
                    ),
                    const SizedBox(width: 32),
                    QuickBookingItem(
                      icon: Icons.movie_creation_outlined,
                      label: 'Movies'.tr(),
                      circleColor: AppColors.accentOrange,
                      onTap: () async {
                        await context.push('/movies/booking', extra: widget.userId);
                      },
                    ),
                  ],
                ),
                // “>” chevron overlay at right
                Positioned(
                  right: 8,
                  top: 40,
                  child: Opacity(
                    opacity: 0.6,
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: const BoxDecoration(
                        color: Colors.white24,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // -----------------------------
  // SECTION 2: Movies
  // -----------------------------
  Widget _buildMoviesSection() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 8, bottom: 12),
      child: Column(
        children: [
          // Title Row: "Movies" + "See All"
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                 Text(
                  'Movies'.tr(),
                  style: TextStyle(
                    color: AppColors.purpleDark,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentOrange,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 4.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () => context.push('/movies', extra: widget.userId),
                  child:  Text(
                    'seeAll'.tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Fetch & display movies in PageView + dots
          FutureBuilder<List<Movie>>(
            future: _moviesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  height: 160,
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                return SizedBox(
                  height: 160,
                  child: Center(
                    child: Text(
                      'errorLoadingMovies'.tr(),
                      style: TextStyle(color: Colors.red[700]),
                    ),
                  ),
                );
              } else {
                final movies = snapshot.data!;
                final count = movies.length;
                return Column(
                  children: [
                    SizedBox(
                      height: 140,
                      child: PageView.builder(
                        controller: _moviePageController,
                        itemCount: count,
                        padEnds: false,
                        itemBuilder: (context, index) {
                          return MovieCard(movie: movies[index], userId: widget.userId);
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Pagination dots
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(count, (index) {
                        return Container(
                          width: 6,
                          height: 6,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentMoviePage == index
                                ? AppColors.accentOrange
                                : const Color(0xFFD0D0D0),
                          ),
                        );
                      }),
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  // -----------------------------
  // SECTION 3: Outreach Programs
  // -----------------------------
  Widget _buildOutreachSection() {
    return Container(
      color: AppColors.lightGreyBlue,
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: Column(
        children: [
          // Title Row: "Outreach Programs" + "See All"
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                 Text(
                  'outreachPrograms'.tr(),
                  style: TextStyle(
                    color: AppColors.purpleDark,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentOrange,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 4.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () => context.push('/outreach', extra: widget.userId),
                  child:  Text(
                    'seeAll'.tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Vertical list of outreach items
          FutureBuilder<List<Outreach>>(
            future: _outreachFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  height: 200,
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                return SizedBox(
                  height: 200,
                  child: Center(
                    child: Text(
                      'errorLoadingOutreach'.tr(),
                      style: TextStyle(color: Colors.red[700]),
                    ),
                  ),
                );
              } else {
                final items = snapshot.data!;
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    return OutreachCard(item: items[index]);
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }

  // -----------------------------
  // SECTION 4: Attractions
  // -----------------------------
  Widget _buildAttractionsSection() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.purpleDark, AppColors.purpleLight],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      padding: const EdgeInsets.only(top: 12, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Row: "Attractions" + "See All"
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                 Text(
                  'Attractions'.tr(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentOrange,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 4.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () =>context.push('/attractions',extra: widget.userId),
                  child:  Text(
                    'seeAll'.tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Horizontal carousel of attractions
          FutureBuilder<List<Attraction>>(
            future: _attractionsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  height: 180,
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                return SizedBox(
                  height: 180,
                  child: Center(
                    child: Text(
                      'errorLoadingAttractions'.tr(),
                      style: TextStyle(color: Colors.red[700]),
                    ),
                  ),
                );
              } else {
                final items = snapshot.data!;
                return SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return AttractionCard(attraction: items[index]);
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  // -----------------------------
  // SECTION 5: Latest News
  // -----------------------------
  Widget _buildNewsSection() {
    return Container(
      color: AppColors.lightGreyBlue,
      padding: const EdgeInsets.only(top: 12, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Row: "Latest News" + "See All"
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                 Text(
                  'latestNews'.tr(),
                  style: TextStyle(
                    color: AppColors.purpleDark,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentOrange,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 4.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () =>context.push('/news', extra: widget.userId),
                  child:  Text(
                    'seeAll'.tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Horizontal carousel of news items
          FutureBuilder<List<News>>(
            future: _newsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  height: 130,
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                return SizedBox(
                  height: 130,
                  child: Center(
                    child: Text(
                      'errorLoadingNews'.tr(),
                      style: TextStyle(color: Colors.red[700]),
                    ),
                  ),
                );
              } else {
                final items = snapshot.data!;
                return SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return NewsCard(news: items[index]);
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}