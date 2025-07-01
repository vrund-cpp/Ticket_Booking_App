import 'package:flutter/material.dart';
import '../models/attraction.dart';

class AttractionCard2 extends StatelessWidget {
  final Attraction attraction;
  final Map<String, int> count; // userType: quantity
  final Function(String) onAdd;
  final Function(String) onRemove;

  const AttractionCard2({
    super.key,
    required this.attraction,
    required this.count,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(attraction.imageUrl ?? '', height: 80, width: 80, fit: BoxFit.cover),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(attraction.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(attraction.description, maxLines: 2, overflow: TextOverflow.ellipsis),
                ],
              ),
            )
          ]),
          const SizedBox(height: 12),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            _priceControl("Adult", attraction.priceAdult, count["adult"] ?? 0, () => onAdd("adult"), () => onRemove("adult")),
            _priceControl("Kid", attraction.priceKid, count["kid"] ?? 0, () => onAdd("kid"), () => onRemove("kid")),
            _priceControl("School", attraction.priceSchool, count["school"] ?? 0, () => onAdd("school"), () => onRemove("school")),
          ]),
        ]),
      ),
    );
  }

  Widget _priceControl(String label, double price, int qty, VoidCallback onAdd, VoidCallback onRemove) {
    return Column(
      children: [
        Text("$label ₹${price.toInt()}", style: const TextStyle(fontSize: 12)),
        Row(
          children: [
            IconButton(icon: const Icon(Icons.remove, size: 20), onPressed: onRemove),
            Text('$qty'),
            IconButton(icon: const Icon(Icons.add, size: 20), onPressed: onAdd),
          ],
        )
      ],
    );
  }
}
