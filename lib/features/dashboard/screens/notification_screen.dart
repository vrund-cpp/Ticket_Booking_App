// lib/screens/notifications_screen.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ticket_booking_app/models/notification_item.dart';
import '../../../core/services/api_service.dart';

class NotificationScreen extends StatefulWidget {
  final String userId;
  const NotificationScreen({super.key, required this.userId});

  @override
  State<NotificationScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationScreen> {
  late Future<List<NotificationItem>> _futureNotifs;

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
        title:  Text('Notifications'.tr()),
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
              return  Center(child: Text('noNotifications'.tr()));
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
          });} catch (e) {
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


