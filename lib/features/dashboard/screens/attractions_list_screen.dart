import 'package:flutter/material.dart';
import '../../../core/services/api_service.dart';
import '../../../models/attraction.dart';
import '../../../widgets/attraction_card.dart';

class AttractionsListScreen extends StatefulWidget {
  const AttractionsListScreen({super.key});
  @override
  _AttractionsListScreenState createState() => _AttractionsListScreenState();
}

class _AttractionsListScreenState extends State<AttractionsListScreen> {
  late Future<List<Attraction>> _futureAllAttractions;

  @override
  void initState() {
    super.initState();
    _futureAllAttractions = ApiService.fetchAllAttractions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Attractions')),
      body: FutureBuilder<List<Attraction>>(
        future: _futureAllAttractions,
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snap.hasError) {
            return Center(child: Text('Error: ${snap.error}'));
          }
          final items = snap.data!;
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 120/140,
            ),
            itemCount: items.length,
            itemBuilder: (ctx, i) => AttractionCard(attraction: items[i]),
          );
        },
      ),
    );
  }
}
