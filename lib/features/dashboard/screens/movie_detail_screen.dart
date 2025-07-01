import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticket_booking_app/core/constants/colors.dart';
import 'package:ticket_booking_app/models/movie.dart';
import 'package:ticket_booking_app/core/services/api_service.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;
  final String userId;

  const MovieDetailScreen({super.key, required this.movie, required this.userId});

  @override
    State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
      late Future<int> _notifCountFuture;

        @override
  void initState() {
    super.initState();
    _notifCountFuture = ApiService.getUnreadCount();
  }

    @override
  Widget build(BuildContext context) {
    final releaseDateFormatted = DateFormat('d MMM yyyy').format(widget.movie.releaseDate);

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
          'movieDetail'.tr(),
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
                  const Icon(Icons.notifications, color: Colors.white, size: 24),
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
                  )
                ],
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top image
            Image.network(
              widget.movie.imageUrl,
              width: double.infinity,
              height: 220,
              fit: BoxFit.cover,
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Movie title
                  Text(
                    widget.movie.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Date row with icon
                  Row(
                    children: [
                      const Icon(Icons.calendar_month, size: 18, color: Colors.grey),
                      const SizedBox(width: 6),
                      Text(
                        releaseDateFormatted,
                        style: const TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                  const Divider(height: 32),

                  // Description
                  Text(
                    widget.movie.description,
                    style: const TextStyle(fontSize: 15, height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
