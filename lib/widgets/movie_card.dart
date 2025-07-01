// lib/widgets/movie_card.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/movie.dart';

/// A card for a single movie in the “Movies” carousel.
class MovieCard extends StatelessWidget {
  final Movie movie;
  final String userId;

  const MovieCard({super.key, required this.movie,required this.userId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap: () {
      context.push('/movie-details', extra: {
  'movie': movie,
  'userId': userId,
}); // 👈 pass movie object
    },
    child: Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
              width: 220,
              height: 120,
              color: Colors.grey[300],
              child: Stack(
fit: StackFit.expand, // ensures all children take full size
              children: [Image.network(
                movie.imageUrl,
                fit: BoxFit.cover,
              ),

            // Black gradient overlay at bottom half
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 60,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black54,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),

            // Title & subtitle on top of gradient
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    movie.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}