
// lib/screens/notifications_screen.dart

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
        title: const Text('Notifications'),
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
              return const Center(child: Text('No notifications'));
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
                  // subtitle: Text(
                  //   '${n.createdAt.toLocal()}'.split('.')[0],
                  //   style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  // ),
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


// File: frontend/lib/features/notification/screens/notification_screen.dart

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:ticket_booking_app/core/constants/colors.dart';
// import 'package:ticket_booking_app/features/dashboard/providers/notification_provider.dart';
// import 'package:ticket_booking_app/services/dashboard_service.dart';
// import 'package:ticket_booking_app/features/auth/providers/auth_provider.dart';

// class NotificationScreen extends ConsumerStatefulWidget {
//   const NotificationScreen({super.key});

//   @override
//   ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
// }

// class _NotificationScreenState extends ConsumerState<NotificationScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _markAllRead();
//   }

//   Future<void> _markAllRead() async {
//     final user = ref.read(userProvider)!;
//     final token = ref.read(authTokenProvider)!;
//     await DashboardService.markAllNotificationsRead(user.id, token: token);
//     ref.refresh(unreadNotificationCountProvider);
//     ref.refresh(notificationListProvider);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final notificationAsync = ref.watch(notificationListProvider);

//     return Scaffold(
//       backgroundColor: AppColors.offWhite,
//       appBar: AppBar(title: const Text("Notifications")),
//       body: notificationAsync.when(
//         data: (notifications) {
//           if (notifications.isEmpty) {
//             return const Center(child: Text('No notifications', style: TextStyle(fontSize: 16)));
//           }
//           return ListView.separated(
//             padding: const EdgeInsets.all(12),
//             itemCount: notifications.length,
//             separatorBuilder: (_, __) => const Divider(),
//             itemBuilder: (context, index) {
//               final n = notifications[index];
//               return ListTile(
//                 tileColor: n.isRead ? Colors.white : Colors.orange.shade50,
//                 title: Text(n.title, style: const TextStyle(fontWeight: FontWeight.bold)),
//                 subtitle: Text(n.message),
//                 trailing: n.isRead ? null : const Icon(Icons.circle, color: Colors.red, size: 8),
//                 onTap: () async {
//                   if (!n.isRead) {
//                     final token = ref.read(authTokenProvider)!;
//                     await DashboardService.markNotificationRead(n.id, token: token);
//                     ref.refresh(notificationListProvider);
//                     ref.refresh(unreadNotificationCountProvider);
//                   }
//                 },
//               );
//             },
//           );
//         },
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (err, _) => Center(
//             child: Text('Error loading notifications: $err',
//                 style: const TextStyle(color: Colors.red))),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart' as http;
// import 'package:ticket_booking_app/core/services/dashboard_service.dart';
// import 'package:ticket_booking_app/features/auth/presentation/providers/auth_provider.dart';
// import 'package:ticket_booking_app/features/notification/presentation/providers/notification_provider.dart';
// import 'package:ticket_booking_app/features/notification/presentation/model/notification_model.dart';

// class NotificationScreen extends ConsumerStatefulWidget {
//   const NotificationScreen({Key? key}): super(key:key);

//   @override
//   ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
// }

// class _NotificationScreenState extends ConsumerState<NotificationScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _markAllRead();
//   }

//   Future<void> _markAllRead() async {
//     final user = ref.read(userProvider);
//     final token = ref.read(authTokenProvider);
//     if (user != null && token != null) {
//       await DashboardService.markAllNotificationsRead(user.id, token: token);
//       ref.refresh(unreadNotificationCountProvider);
//       ref.refresh(notificationListProvider);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final notificationAsync = ref.watch(notificationListProvider);

//     return Scaffold(
//       appBar: AppBar(title: const Text("Notifications")),
//       body: notificationAsync.when(
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (_, __) => const Center(child: Text("Error loading notifications", style: TextStyle(color: Colors.red))),
//         data: (notifications) {
//           if (notifications.isEmpty) {
//             return const Center(child: Text("No notifications", style: TextStyle(fontSize: 16)));
//           }
//           return ListView.separated(
//             padding: const EdgeInsets.all(12),
//             itemCount: notifications.length,
//             separatorBuilder: (_, __) => const Divider(),
//             itemBuilder: (context, index) {
//               final n = notifications[index];
//               return ListTile(
//                 tileColor: n.isRead ? Colors.white : Colors.orange.shade50,
//                 title: Text(n.title, style: const TextStyle(fontWeight: FontWeight.bold)),
//                 subtitle: Text(n.message),
//                 trailing: n.isRead ? null : const Icon(Icons.circle, color: Colors.red, size: 8),
//                 onTap: () async {
//                   if (!n.isRead) {
//                     final token = ref.read(authTokenProvider);
//                     await DashboardService.markNotificationRead(n.id, token: token);
//                     ref.refresh(notificationListProvider);
//                     ref.refresh(unreadNotificationCountProvider);
//                   }
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// // class NotificationScreen extends ConsumerWidget {
// //   const NotificationScreen({super.key});

// //     Future<void> markAsRead(int id) async {
// //     await http.patch(Uri.parse("http://localhost:3000/api/notifications/$id/read"));
// //   }
// // @override
// //   Widget build(BuildContext context, WidgetRef ref) {
// //     final notificationsAsync = ref.watch(notificationProvider);

// //     return Scaffold(
// //       appBar: AppBar(title: const Text("Notifications")),
// //       body: notificationsAsync.when(
// //         loading: () => const Center(child: CircularProgressIndicator()),
// //         error: (e, _) => Center(child: Text("Error: $e")),
// //         data: (notifications) => ListView.builder(
// //           padding: const EdgeInsets.all(12),
// //           itemCount: notifications.length,
// //           itemBuilder: (context, index) {
// //             final note = notifications[index];
// //             return ListTile(
// //               tileColor: note.isRead ? Colors.white : Colors.yellow[100],
// //               title: Text(note.title),
// //               subtitle: Text(note.message),
// //               trailing: note.isRead ? null : const Icon(Icons.circle, size: 10, color: Colors.red),
// //               onTap: () async {
// //                 if (!note.isRead) {
// //                   await markAsRead(note.id);
// //                   ref.invalidate(notificationProvider);
// //                 }
// //               },
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }
