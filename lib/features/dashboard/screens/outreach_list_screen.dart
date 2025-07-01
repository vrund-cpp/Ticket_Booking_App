import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticket_booking_app/core/constants/colors.dart';
import 'package:ticket_booking_app/core/services/api_service.dart';
import '../../../models/outreach.dart';
import '../../../widgets/outreach_card.dart';

class OutreachListScreen extends StatefulWidget {
    final String userId;
  const OutreachListScreen({super.key, required this.userId});
  @override
  _OutreachListScreenState createState() => _OutreachListScreenState();
}

class _OutreachListScreenState extends State<OutreachListScreen> {
  late Future<List<Outreach>> _futureAllOutreach;
  late Future<int> _notifCountFuture;

  @override
  void initState() {
    super.initState();
    _futureAllOutreach = ApiService.fetchAllOutreach();
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
          'allOutreachPrograms'.tr(),
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
