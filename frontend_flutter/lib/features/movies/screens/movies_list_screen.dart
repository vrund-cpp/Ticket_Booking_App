import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticketease/core/constants/colors.dart';
import 'package:ticketease/core/services/api_service.dart';
import 'package:ticketease/features/movies/models/movie.dart';
import 'package:ticketease/core/widgets/movie_card.dart';

class MoviesListScreen extends StatefulWidget {
  final String userId;

  const MoviesListScreen({super.key, required this.userId});
  @override
  _MoviesListScreenState createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  late Future<List<Movie>> _futureAllMovies;
  late Future<int> _notifCountFuture;

  @override
  void initState() {
    super.initState();
    _futureAllMovies = ApiService.fetchAllMovies();
    _notifCountFuture = ApiService.getUnreadCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.purpleDark,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'allMovies'.tr(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () async {
                await context.push('/notifications', extra: widget.userId);
                if (!mounted) return;
                setState(() {
                  _notifCountFuture = ApiService.getUnreadCount();
                });
              },
              child: Stack(
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
                              '${snap.data}', // You can replace this with dynamic count if needed
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<Movie>>(
        future: _futureAllMovies,
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snap.hasError) {
            return Center(child: Text('Error: ${snap.error}'));
          }
          final movies = snap.data!;
          if (movies.isEmpty) {
            return Center(child: Text('No movies available'.tr()));
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemCount: movies.length,
            itemBuilder: (ctx, i) {
              // reuse the same MovieCard widget but make it full‐width
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: SizedBox(
                  height: 140,
                  child: MovieCard(movie: movies[i], userId: widget.userId),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
