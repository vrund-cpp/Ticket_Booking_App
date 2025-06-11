import 'package:flutter/material.dart';
import 'package:ticket_booking_app/core/services/api_service.dart';
import '../../../models/news.dart';
import '../../../widgets/news_card.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});
  @override
  _NewsListScreenState createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  late Future<List<News>> _futureAllNews;

  @override
  void initState() {
    super.initState();
    _futureAllNews = ApiService.fetchAllNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All News')),
      body: FutureBuilder<List<News>>(
        future: _futureAllNews,
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snap.hasError) {
            return Center(child: Text('Error: ${snap.error}'));
          }
          final items = snap.data!;
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemCount: items.length,
            itemBuilder: (ctx, i) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SizedBox(
                height: 120,
                child: NewsCard(news: items[i]),
              ),
            ),
          );
        },
      ),
    );
  }
}
