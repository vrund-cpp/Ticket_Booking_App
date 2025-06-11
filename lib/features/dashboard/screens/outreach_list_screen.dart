import 'package:flutter/material.dart';
import 'package:ticket_booking_app/core/services/api_service.dart';
import '../../../models/outreach.dart';
import '../../../widgets/outreach_card.dart';

class OutreachListScreen extends StatefulWidget {
  const OutreachListScreen({super.key});
  @override
  _OutreachListScreenState createState() => _OutreachListScreenState();
}

class _OutreachListScreenState extends State<OutreachListScreen> {
  late Future<List<Outreach>> _futureAllOutreach;

  @override
  void initState() {
    super.initState();
    _futureAllOutreach = ApiService.fetchAllOutreach();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Outreach Programs')),
      body: FutureBuilder<List<Outreach>>(
        future: _futureAllOutreach,
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snap.hasError) {
            return Center(child: Text('Error: ${snap.error}'));
          }
          final items = snap.data!;
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (ctx, i) => OutreachCard(item: items[i]),
          );
        },
      ),
    );
  }
}
