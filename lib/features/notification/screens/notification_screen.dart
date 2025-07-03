// lib/screens/notifications_screen.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ticket_booking_app/features/notification/models/notification_item.dart';
import '../../../core/services/api_service.dart';

class NotificationScreen extends StatefulWidget {
  final String userId;
  const NotificationScreen({super.key, required this.userId});

  @override
  State<NotificationScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationScreen> {
  late Future<List<NotificationItem>> _futureNotifs;

  void _confirmMarkAllRead(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Mark all as read?'.tr()),
        content: Text('This action will mark all notifications as read.'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel'.tr()),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Confirm'.tr()),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await ApiService.markAllNotificationsRead();
        setState(() {
          _futureNotifs = ApiService.getUserNotifications(); // refresh list
        });
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _futureNotifs = ApiService.getUserNotifications();
    // mark all read when screen opens
    ApiService.markAllNotificationsRead().catchError((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all),
            tooltip: 'Mark all as read'.tr(),
            onPressed: () => _confirmMarkAllRead(context),
          ),
        ],
      ),
      body: FutureBuilder<List<NotificationItem>>(
        future: _futureNotifs,
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snap.hasError) {
            return Center(child: Text('Error: ${snap.error}'));
          } else {
            final items = snap.data!;
            if (items.isEmpty) {
              return Center(child: Text('noNotifications'.tr()));
            }

            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (ctx, i) {
                final n = items[i];
                return ListTile(
                  leading: Icon(
                    Icons.notifications,
                    color: n.isRead ? Colors.grey : Colors.blue,
                  ),
                  title: Text(n.title),
                  subtitle: Text(n.message),
                  tileColor: n.isRead ? Colors.white : Colors.blue.shade50,
                  onTap: () async {
                    if (!n.isRead) {
                      // Mark as read
                      try {
                        await ApiService.markNotificationRead(n.id);
                        setState(() {
                          n.isRead = true;
                        });
                      } catch (e) {
                        print('Error marking notification read: $e');
                      }
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
