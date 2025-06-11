// lib/screens/dashboard_screen.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticket_booking_app/core/services/api_service.dart';
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
    _notifCountFuture = ApiService.getUnreadCount(widget.userId);

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
      drawer: const Drawer(child: SizedBox()),
      appBar: AppBar(
        backgroundColor: AppColors.purpleDark,
        elevation: 0,
        leading: Builder(
          builder:(ctx)=>IconButton(
            icon: const Icon(Icons.menu, color:Colors.white, size:24),
            onPressed:()=>Scaffold.of(ctx).openDrawer(),
          ),
        ),
        title: const Text(
          'Dashboard',
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
  setState(() {
    _notifCountFuture = ApiService.getUnreadCount(widget.userId);
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
          const Padding(
            padding: EdgeInsets.only(left: 16.0, bottom: 12.0),
            child: Text(
              'Quick Booking',
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
                      label: 'ENTRY TICKET',
                      circleColor: AppColors.accentOrange,
                      onTap: () {
                        // TODO: Navigate to Entry Ticket
                      },
                    ),
                    const SizedBox(width: 32),
                    QuickBookingItem(
                      icon: Icons.local_parking,
                      label: 'PARKING',
                      circleColor: AppColors.cyanAccent,
                      onTap: () {
                        // TODO: Navigate to Parking
                      },
                    ),
                    const SizedBox(width: 32),
                    QuickBookingItem(
                      icon: Icons.rocket_launch,
                      label: 'ATTRACTIONS',
                      circleColor: Colors.purple,
                      onTap: () {
                        // TODO: Navigate to Attractions
                      },
                    ),
                    const SizedBox(width: 32),
                    QuickBookingItem(
                      icon: Icons.movie_creation_outlined,
                      label: 'MOVIES',
                      circleColor: AppColors.accentOrange,
                      onTap: () {
                        // TODO: Navigate to Movies
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
                const Text(
                  'Movies',
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
                  onPressed: () => context.push('/movies'),
                  child: const Text(
                    'See All',
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
                      'Error loading movies',
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
                          return MovieCard(movie: movies[index]);
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
                const Text(
                  'Outreach Programs',
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
                  onPressed: () => context.push('/outreach'),
                  child: const Text(
                    'See All',
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
                      'Error loading outreach',
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
                const Text(
                  'Attractions',
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
                  onPressed: () =>context.push('/attractions'),
                  child: const Text(
                    'See All',
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
                      'Error loading attractions',
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
                const Text(
                  'Latest News',
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
                  onPressed: () =>context.push('/news'),
                  child: const Text(
                    'See All',
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
                      'Error loading news',
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


// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:ticket_booking_app/core/constants/colors.dart';
// import 'package:ticket_booking_app/features/quickbooking/providers/quickbooking_provider.dart';
// import 'package:ticket_booking_app/features/quickbooking/model/quick_booking_item.dart';
// import 'package:ticket_booking_app/features/home/presentation/widgets/quickbooking_carousel.dart';
// import 'package:ticket_booking_app/features/home/presentation/widgets/section_header.dart';
// import 'package:ticket_booking_app/core/services/dashboard_service.dart';
// import 'package:ticket_booking_app/features/movies/presentation/model/movie_item.dart';
// import 'package:ticket_booking_app/features/movies/presentation/screens/see_all_movies_screen.dart';
// import 'package:ticket_booking_app/features/notification/presentation/providers/notification_provider.dart';
// import 'package:ticket_booking_app/features/attractions/presentation/model/attraction_item.dart';
// import 'package:ticket_booking_app/features/outreach/presentation/model/outreach_item.dart';
// import 'package:ticket_booking_app/features/news/presentation/model/news_item.dart';

// class DashboardScreen extends ConsumerStatefulWidget {
//   const DashboardScreen({Key? key}): super(key:key);

//   @override
//   ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends ConsumerState<DashboardScreen> {
//   late Future<List<MovieModel>> _moviesFuture;
//   late Future<List<OutreachModel>> _outreachFuture;
//   late Future<List<AttractionModel>> _attractionFuture;
//   late Future<List<NewsItem>> _newsFuture;

//   @override
//   void initState() {
//     super.initState();
//     _moviesFuture = DashboardService.fetchMoviesLatest();
//     _outreachFuture = DashboardService.fetchOutreachLatest();
//     _attractionFuture = DashboardService.fetchAttractionsLatest();
//     _newsFuture = DashboardService.fetchNewsLatest();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final unreadCount = ref.watch(unreadNotificationCountProvider);
//     final quickBookingAsync = ref.watch(quickBookingProvider);

//     return Scaffold(
//       backgroundColor: AppColors.backgroundPurple,
//       appBar: AppBar(
//         backgroundColor: AppColors.backgroundPurple,
//         elevation: 0,
//         title: const Text('Dashboard',
//             style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
//         actions: [
//           Stack(
//             children: [
//               IconButton(
//                 icon: const Icon(Icons.notifications, color: Colors.white),
//                 onPressed: () => Navigator.pushNamed(context, '/notifications'),
//               ),
//               if (unreadCount.asData?.value != null && unreadCount.asData!.value > 0)
//                 Positioned(
//                   top: 8,
//                   right: 8,
//                   child: Container(
//                     padding: const EdgeInsets.all(4),
//                     decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
//                     child: Text(
//                       '${unreadCount.asData!.value}',
//                       style: const TextStyle(color: Colors.white, fontSize: 10),
//                     ),
//                   ),
//                 ),
//             ],
//           )
//         ],
//       ),
//       body: SafeArea(
//         child: ListView(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
//           children: [
//             // Quick Booking Section
//             const Text('Quick Booking',
//                 style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600)),
//             const SizedBox(height: 12),
//             SizedBox(
//               height: 110,
//               child: quickBookingAsync.when(
//                 loading: () => const Center(child: CircularProgressIndicator()),
//                 error: (_, __) => const Center(child: Text('Error loading quick booking', style: TextStyle(color: Colors.red))),
//                 data: (items) {
//                   if (items.isEmpty) {
//                     return const Center(
//                         child: Text('No booking options', style: TextStyle(color: Colors.white)));
//                   }
//                   return ListView.separated(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: items.length,
//                     separatorBuilder: (_, __) => const SizedBox(width: 12),
//                     itemBuilder: (context, index) {
//                       final qb = items[index];
//                       return QuickBookingCarousel(
//                         title: qb.title,
//                         icon: Icons.confirmation_num,
//                         onTap: () {
//                           // Navigate to specific booking flow based on qb.type
//                           switch (qb.type.toLowerCase()) {
//                             case 'entry':
//                               Navigator.pushNamed(context, '/booking-entry');
//                               break;
//                             case 'parking':
//                               Navigator.pushNamed(context, '/booking-parking');
//                               break;
//                             case 'attraction':
//                               Navigator.pushNamed(context, '/booking-attraction');
//                               break;
//                             case 'movie':
//                               Navigator.pushNamed(context, '/booking-movie');
//                               break;
//                             default:
//                               break;
//                           }
//                         },
//                         colorHex: qb.colorHex,
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),

//             const SizedBox(height: 24),
//             // Movies Section
//             SectionHeader(
//               title: "Movies",
//               onSeeAll: () => Navigator.pushNamed(context, '/see-all-movies'),
//             ),
//             Container(
//               height: 180,
//               decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(8)),
//               child: _buildHorizontalFutureSection<MovieModel>(
//                 future: _moviesFuture,
//                 itemBuilder: (movie) => Column(
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(12),
//                       child: Image.network(movie.imageUrl, height: 120, width: 100, fit: BoxFit.cover),
//                     ),
//                     const SizedBox(height: 6),
//                     Text(movie.title, style: const TextStyle(color: Colors.white, fontSize: 12)),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 24),
//             // Outreach Programs Section
//             SectionHeader(
//               title: "Outreach Programs",
//               onSeeAll: () => Navigator.pushNamed(context, '/see-all-outreach'),
//             ),
//             Container(
//               height: 160,
//               decoration: BoxDecoration(color: AppColors.lightBlue, borderRadius: BorderRadius.circular(8)),
//               child: _buildHorizontalFutureSection<OutreachModel>(
//                 future: _outreachFuture,
//                 itemBuilder: (program) => Column(
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(12),
//                       child: Image.network(program.imageUrl, height: 100, width: 100, fit: BoxFit.cover),
//                     ),
//                     const SizedBox(height: 6),
//                     Text(program.title, style: const TextStyle(color: Colors.black, fontSize: 12)),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 24),
//             // Attractions Section
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 gradient: LinearGradient(
//                   colors: [Colors.deepPurple.shade400, Colors.blue.shade300],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SectionHeader(
//                     title: "Attractions",
//                     onSeeAll: () => Navigator.pushNamed(context, '/see-all-attractions'),
//                   ),
//                   _buildHorizontalFutureSection<AttractionModel>(
//                     future: _attractionFuture,
//                     itemBuilder: (attraction) => Column(
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(12),
//                           child: Image.network(attraction.imageUrl, height: 100, width: 100, fit: BoxFit.cover),
//                         ),
//                         const SizedBox(height: 6),
//                         Text(attraction.title, style: const TextStyle(color: Colors.white, fontSize: 12)),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 24),
//             // Latest News Section
//             Container(
//               width: double.infinity,
//               decoration: BoxDecoration(color: AppColors.offWhite, borderRadius: BorderRadius.circular(8)),
//               padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SectionHeader(
//                     title: "Latest News",
//                     onSeeAll: () => Navigator.pushNamed(context, '/see-all-news'),
//                   ),
//                   _buildVerticalFutureSection<NewsItem>(
//                     future: _newsFuture,
//                     itemBuilder: (news) => ListTile(
//                       leading: ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: Image.network(news.imageUrl, width: 60, height: 60, fit: BoxFit.cover),
//                       ),
//                       title: Text(news.title, style: const TextStyle(color: Colors.black)),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 24),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSectionHeader(String title, VoidCallback onTap) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
//           TextButton(
//             onPressed: onTap,
//             style: TextButton.styleFrom(backgroundColor: AppColors.yellow),
//             child: const Text("See All", style: TextStyle(color: Colors.black)),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildHorizontalFutureSection<T>({
//     required Future<List<T>> future,
//     required Widget Function(T) itemBuilder,
//   }) {
//     return FutureBuilder<List<T>>(
//       future: future,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return const Center(child: Text("Error loading data", style: TextStyle(color: Colors.red)));
//         } else {
//           final data = snapshot.data!;
//           if (data.isEmpty) {
//             return const Center(child: Text("No items found", style: TextStyle(color: Colors.white)));
//           }
//           return ListView.separated(
//             scrollDirection: Axis.horizontal,
//             itemCount: data.length,
//             separatorBuilder: (_, __) => const SizedBox(width: 12),
//             itemBuilder: (context, index) {
//               return itemBuilder(data[index]);
//             },
//           );
//         }
//       },
//     );
//   }

//   Widget _buildVerticalFutureSection<T>({
//     required Future<List<T>> future,
//     required Widget Function(T) itemBuilder,
//   }) {
//     return FutureBuilder<List<T>>(
//       future: future,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return const Center(child: Text("Error loading data", style: TextStyle(color: Colors.red)));
//         } else {
//           final data = snapshot.data!;
//           if (data.isEmpty) {
//             return const Center(child: Text("No items found", style: TextStyle(color: Colors.black)));
//           }
//           return Column(
//             children: data.map((item) => itemBuilder(item)).toList(),
//           );
//         }
//       },
//     );
//   }
// }






// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:ticket_booking_app/core/constants/colors.dart';
// import 'package:ticket_booking_app/features/home/presentation/widgets/quickbooking_carousel.dart';
// import 'package:ticket_booking_app/features/home/presentation/widgets/section_header.dart';
// import 'package:ticket_booking_app/features/notification/presentation/providers/notification_provider.dart';
// import 'package:ticket_booking_app/features/movies/presentation/screens/see_all_movies_screen.dart';
// import 'package:ticket_booking_app/features/attractions/presentation/model/attraction_model.dart';
// import 'package:ticket_booking_app/features/news/presentation/model/news_item.dart';
// import 'package:ticket_booking_app/features/outreach/presentation/model/outreach_model.dart';
// import 'package:ticket_booking_app/features/movies/presentation/model/movie_model.dart';
// import 'package:ticket_booking_app/core/services/dashboard_service.dart';

// class DashboardScreen extends ConsumerStatefulWidget {
//   const DashboardScreen({super.key});

//   @override
//   ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends ConsumerState<DashboardScreen> {
//   late Future<List<MovieModel>> _moviesFuture;
//   late Future<List<OutreachModel>> _outreachFuture;
//   late Future<List<Attraction>> _attractionFuture;
//   late Future<List<NewsItem>> _newsFuture;

//   @override
//   void initState() {
//     super.initState();
//     _moviesFuture = DashboardService.fetchMovies();
//     _outreachFuture = DashboardService.fetchOutreach();
//     _attractionFuture = DashboardService.fetchAttractions();
//     _newsFuture = DashboardService.fetchNews();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final unreadCount = ref.watch(unreadNotificationCountProvider);

//     return Scaffold(
//       backgroundColor: AppColors.backgroundPurple,
//       appBar: AppBar(
//         backgroundColor: AppColors.backgroundPurple,
//         elevation: 0,
//         title: const Text('Dashboard',
//             style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
//         actions: [
//           Stack(
//             children: [
//               IconButton(
//                 icon: const Icon(Icons.notifications, color: Colors.white),
//                 onPressed: () => Navigator.pushNamed(context, '/notifications'),
//               ),
//               if (unreadCount > 0)
//                 Positioned(
//                   top: 8,
//                   right: 8,
//                   child: Container(
//                     padding: const EdgeInsets.all(4),
//                     decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
//                     child: Text(
//                       '$unreadCount',
//                       style: const TextStyle(color: Colors.white, fontSize: 10),
//                     ),
//                   ),
//                 )
//             ],
//           )
//         ],
//       ),
//       body: SafeArea(
//         child: ListView(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
//           children: [

//             const Text('Quick Booking',
//                 style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600)),
//             const SizedBox(height: 12),

//             SizedBox(
//               height: 110,
//               child: ListView(
//                 scrollDirection: Axis.horizontal,
//                 children: [
//                   QuickBookingCarousel(
//                     title: "Entry Ticket",
//                     icon: Icons.confirmation_num,
//                     onTap: () {},
//                   ),
//                   QuickBookingCarousel(
//                     title: "Parking",
//                     icon: Icons.local_parking,
//                     onTap: () {},
//                   ),
//                   QuickBookingCarousel(
//                     title: "Attractions",
//                     icon: Icons.place,
//                     onTap: () {},
//                   ),
//                   QuickBookingCarousel(
//                     title: "Movie Booking",
//                     icon: Icons.movie,
//                     onTap: () {},
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 24),

//             _buildSectionHeader("Movies", () {
//               Navigator.push(context, MaterialPageRoute(builder: (_) => const SeeAllMoviesScreen()));
//             }),
//             _buildHorizontalFutureSection<MovieModel>(
//               future: _moviesFuture,
//               height: 180,
//               backgroundColor: Colors.black,
//               itemBuilder: (movie) => Column(
//                 children: [
//                   Image.network(movie.imageUrl, height: 120, width: 100, fit: BoxFit.cover),
//                   const SizedBox(height: 6),
//                   Text(movie.title, style: const TextStyle(color: Colors.white, fontSize: 12)),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 24),

//             _buildSectionHeader("Outreach Programs", () {
//               Navigator.pushNamed(context, '/see-all-outreach');
//             }),
//             _buildHorizontalFutureSection<OutreachModel>(
//               future: _outreachFuture,
//               height: 160,
//               backgroundColor: Colors.black87,
//               itemBuilder: (program) => Column(
//                 children: [
//                   Image.network(program.imageUrl, height: 100, width: 100, fit: BoxFit.cover),
//                   const SizedBox(height: 6),
//                   Text(program.title, style: const TextStyle(color: Colors.white, fontSize: 12)),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 24),

//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 gradient: LinearGradient(
//                   colors: [Colors.deepPurple.shade400, Colors.blue.shade300],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildSectionHeader("Attractions", () {
//                     Navigator.pushNamed(context, '/see-all-attractions');
//                   }),
//                   _buildHorizontalFutureSection<Attraction>(
//                     future: _attractionFuture,
//                     height: 160,
//                     backgroundColor: Colors.transparent,
//                     itemBuilder: (attraction) => Column(
//                       children: [
//                         Image.network(attraction.imageUrl, height: 100, width: 100, fit: BoxFit.cover),
//                         const SizedBox(height: 6),
//                         Text(attraction.title, style: const TextStyle(color: Colors.white, fontSize: 12)),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 24),

//             SectionHeader(
//               title: "Latest News",
//               onSeeAll: () {
//                 Navigator.pushNamed(context, '/see-all-news');
//               },
//             ),

//             FutureBuilder<List<NewsItem>>(
//               future: _newsFuture,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   return const Text("Error loading news", style: TextStyle(color: Colors.red));
//                 } else {
//                   final news = snapshot.data!;
//                   return Column(
//                     children: news
//                         .map(
//                           (item) => ListTile(
//                             leading: Image.network(item.imageUrl, width: 60, height: 60, fit: BoxFit.cover),
//                             title: Text(item.title, style: const TextStyle(color: Colors.white)),
//                           ),
//                         )
//                         .toList(),
//                   );
//                 }
//               },
//             ),

//             const SizedBox(height: 24),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSectionHeader(String title, VoidCallback onTap) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
//           TextButton(
//             onPressed: onTap,
//             child: const Text("See All", style: TextStyle(color: Colors.yellow)),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildHorizontalFutureSection<T>({
//     required Future<List<T>> future,
//     required double height,
//     required Widget Function(T) itemBuilder,
//     Color backgroundColor = Colors.transparent,
//   }) {
//     return Container(
//       height: height,
//       color: backgroundColor,
//       child: FutureBuilder<List<T>>(
//         future: future,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return const Center(child: Text("Error loading data", style: TextStyle(color: Colors.red)));
//           } else {
//             final data = snapshot.data!;
//             return ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: data.length,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: itemBuilder(data[index]),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
