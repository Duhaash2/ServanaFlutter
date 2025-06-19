import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class WorkerNotificationScreen extends StatefulWidget {
  final List<RemoteMessage>? fcmMessages;

  const WorkerNotificationScreen({super.key, this.fcmMessages});

  @override
  State<WorkerNotificationScreen> createState() => _WorkerNotificationScreenState();
}

class _WorkerNotificationScreenState extends State<WorkerNotificationScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<Map<String, dynamic>> notifications;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    notifications = widget.fcmMessages?.map((msg) {
      return {
        'icon': Icons.notifications,
        'title': msg.notification?.title ?? "No Title",
        'subtitle': msg.notification?.body ?? "No Body",
        'time': 'Just now',
        'isRead': false,
      };
    }).toList() ??
        [
          {
            'icon': Icons.work,
            'title': 'New job assigned',
            'subtitle': 'You have accepted a new job',
            'time': '1h ago',
            'isRead': false,
          },
          {
            'icon': Icons.timer,
            'title': 'Job started',
            'subtitle': 'You marked the job as started',
            'time': '3h ago',
            'isRead': true,
          },
          {
            'icon': Icons.payment,
            'title': 'Payment confirmed',
            'subtitle': 'The client confirmed payment',
            'time': 'Today',
            'isRead': false,
          },
        ];
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF121212) : Colors.white;
    final tabColor = isDark ? Colors.white : Colors.blue[900];
    final unselectedColor = isDark ? Colors.grey[500] : Colors.grey;
    final titleColor = isDark ? Colors.white : Colors.black;
    final subtitleColor = isDark ? Colors.white70 : Colors.black54;
    final avatarBg = isDark ? Colors.grey : Colors.blue[100];

    List<Map<String, dynamic>> unread = notifications.where((n) => n['isRead'] == false).toList();

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        title: Text(
          'Notifications',
          style: TextStyle(
            fontSize: 26,
            color: titleColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: tabColor,
          labelColor: tabColor,
          unselectedLabelColor: unselectedColor,
          labelStyle: const TextStyle(fontWeight: FontWeight.w500),
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Unread'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildNotificationList(notifications, titleColor, subtitleColor, avatarBg),
          _buildNotificationList(unread, titleColor, subtitleColor, avatarBg),
        ],
      ),
    );
  }

  Widget _buildNotificationList(
      List<Map<String, dynamic>> data,
      Color titleColor,
      Color subtitleColor,
      Color? avatarBg,
      ) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: data.length,
      separatorBuilder: (context, index) => const Divider(indent: 72, height: 0),
      itemBuilder: (context, index) {
        final item = data[index];
        return ListTile(
          leading: Stack(
            children: [
              CircleAvatar(
                backgroundColor: avatarBg,
                child: Icon(item['icon'], color: Colors.blue[900]),
              ),
              if (item['isRead'] == false)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
          title: Text(
            item['title'],
            style: TextStyle(fontWeight: FontWeight.bold, color: titleColor),
          ),
          subtitle: Text(item['subtitle'], style: TextStyle(color: subtitleColor)),
          trailing: Text(item['time'], style: TextStyle(fontSize: 12, color: subtitleColor)),
        );
      },
    );
  }
}
