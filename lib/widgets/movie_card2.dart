import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieBookingCard2 extends StatelessWidget {
  final Movie movie;
  final Map<String, int> count;
  final Function(String) onAdd;
  final Function(String) onRemove;

  const MovieBookingCard2({
    super.key,
    required this.movie,
    required this.count,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final releaseText = movie.releaseDate != null
        ? "Releases: ${movie.releaseDate.toLocal().toIso8601String().substring(0, 10)}"
        : "";

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(movie.imageUrl, width: 80, height: 100, fit: BoxFit.cover),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text("${movie.language ?? ''} • ${movie.format ?? ''} • ${movie.timeSlot ?? ''}"),
                  const SizedBox(height: 4),
                  Text(releaseText),
                ],
              ),
            ),
          ]),
          const SizedBox(height: 12),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            _counter("Adult", movie.priceAdult, count["adult"] ?? 0, () => onAdd("adult"), () => onRemove("adult")),
            _counter("Kid", movie.priceKid, count["kid"] ?? 0, () => onAdd("kid"), () => onRemove("kid")),
            _counter("School", movie.priceSchool, count["school"] ?? 0, () => onAdd("school"), () => onRemove("school")),
          ])
        ]),
      ),
    );
  }

  Widget _counter(String label, double price, int qty, VoidCallback onAdd, VoidCallback onRemove) {
    return Column(children: [
      Text("$label ₹${price.toInt()}", style: const TextStyle(fontSize: 12)),
      Row(children: [
        IconButton(icon: const Icon(Icons.remove, size: 20), onPressed: onRemove),
        Text('$qty'),
        IconButton(icon: const Icon(Icons.add, size: 20), onPressed: onAdd),
      ]),
    ]);
  }
}
