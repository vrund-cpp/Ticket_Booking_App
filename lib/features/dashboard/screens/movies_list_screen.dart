import 'package:flutter/material.dart';
import 'package:ticket_booking_app/core/services/api_service.dart';
import '../../../models/movie.dart';
import '../../../widgets/movie_card.dart';

class MoviesListScreen extends StatefulWidget {
  const MoviesListScreen({super.key});
  @override
  _MoviesListScreenState createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  late Future<List<Movie>> _futureAllMovies;

  @override
  void initState() {
    super.initState();
    _futureAllMovies = ApiService.fetchAllMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Movies')),
      body: FutureBuilder<List<Movie>>(
        future: _futureAllMovies,
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snap.hasError) {
            return Center(child: Text('Error: ${snap.error}'));
          }
          final movies = snap.data!;
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemCount: movies.length,
            itemBuilder: (ctx, i) {
              // reuse the same MovieCard widget but make it full‐width
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: SizedBox(
                  height: 140,
                  child: MovieCard(movie: movies[i])),
                  );
            }
              );
            },
      ),
          );
        }
  }

  // because our MovieCard widget constructor expects a Movie model,
  // you can either change it to accept the fields directly, or:
//   Widget movieCard({required String imageUrl, required String title, required String description, required DateTime releaseDate}) {
//     return MovieCard(movie: Movie(
//       id: 0, title: title, description: description, imageUrl: imageUrl, releaseDate: releaseDate
//     ));
//   }
// }
