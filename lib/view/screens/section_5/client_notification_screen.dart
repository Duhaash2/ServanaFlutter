import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:servana/view/screens/section_5/profile_screen.dart';
import 'package:servana/view/screens/section_3/home_client_screen.dart';
import 'package:servana/view/widgets/botton_navigation_widget.dart';
import 'package:servana/view/screens/section_6/worker_notification_screen.dart';
import '../../../l10n/app_localizations.dart';

class ClientNotificationScreen extends StatefulWidget {
  final List<RemoteMessage>? fcmMessages;

  const ClientNotificationScreen({super.key, this.fcmMessages});

  @override
  State<ClientNotificationScreen> createState() => _ClientNotificationScreenState();
}

class _ClientNotificationScreenState extends State<ClientNotificationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedIndex = 0;
  late List<Map<String, dynamic>> notifications;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    if (widget.fcmMessages != null && widget.fcmMessages!.isNotEmpty) {
      notifications = widget.fcmMessages!.map((msg) {
        return {
          'icon': Icons.notifications,
          'title': msg.notification?.title ?? "No Title",
          'subtitle': msg.notification?.body ?? "No Body",
          'time': 'Just now',
          'isRead': false,
        };
      }).toList();
    } else {
      notifications = [
        {
          'icon': Icons.check_circle,
          'title': AppLocalizations.of(context)!.job_completed_title,
          'subtitle': AppLocalizations.of(context)!.job_completed_body,
          'time': '2h ago',
          'isRead': false,
        },
        {
          'icon': Icons.payment,
          'title': AppLocalizations.of(context)!.payment_received_title,
          'subtitle': AppLocalizations.of(context)!.payment_received_body,
          'time': '4h ago',
          'isRead': true,
        },
        {
          'icon': Icons.message,
          'title': AppLocalizations.of(context)!.new_message_title,
          'subtitle': AppLocalizations.of(context)!.new_message_body_1,
          'time': 'Yesterday',
          'isRead': false,
        },
        {
          'icon': Icons.check_circle,
          'title': AppLocalizations.of(context)!.job_started_title,
          'subtitle': AppLocalizations.of(context)!.job_started_body,
          'time': 'Yesterday',
          'isRead': true,
        },
        {
          'icon': Icons.message,
          'title': AppLocalizations.of(context)!.new_message_title,
          'subtitle': AppLocalizations.of(context)!.new_message_body_2,
          'time': '2d ago',
          'isRead': false,
        },
        {
          'icon': Icons.check_circle,
          'title': AppLocalizations.of(context)!.job_request_accepted_title,
          'subtitle': AppLocalizations.of(context)!.job_request_accepted_body,
          'time': '2d ago',
          'isRead': true,
        },
      ];
    }
  }

  void onItemTapped(int index) {
    setState(() => selectedIndex = index);
  }

  void _navigate(int index, Widget screen) {
    setState(() => selectedIndex = index);
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> unreadNotifications =
    notifications.where((n) => n['isRead'] == false).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.notifications,
          style: const TextStyle(
            fontSize: 26,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.blue[900],
          labelColor: Colors.blue[900],
          unselectedLabelColor: Colors.grey,
          labelStyle: const TextStyle(fontWeight: FontWeight.w500),
          tabs: [
            Tab(text: AppLocalizations.of(context)!.all),
            Tab(text: AppLocalizations.of(context)!.unread),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildNotificationList(notifications),
                  _buildNotificationList(unreadNotifications),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: _buildBottomBar(MediaQuery.of(context).size.width),
    );
  }

  Widget _buildNotificationList(List<Map<String, dynamic>> data) {
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
                backgroundColor: Colors.blue[100],
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
          title: Text(item['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(item['subtitle']),
          trailing: Text(item['time'], style: const TextStyle(fontSize: 12, color: Colors.grey)),
        );
      },
    );
  }

  BottomAppBar _buildBottomBar(double width) {
    return BottomAppBar(
      color: Colors.white,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottonNavigationWidget(
              icon: Icons.home_filled,
              label: "Home",
              isSelected: selectedIndex == 0,
              onTap: () => _navigate(0, const HomeScreen()),
            ),
            BottonNavigationWidget(
              icon: Icons.wallet,
              label: "Wallet",
              isSelected: selectedIndex == 1,
              onTap: () => onItemTapped(1),
            ),
            BottonNavigationWidget(
              icon: Icons.history,
              label: "History",
              isSelected: selectedIndex == 2,
              onTap: () => onItemTapped(2),
            ),
            BottonNavigationWidget(
              icon: Icons.person,
              label: "Profile",
              isSelected: selectedIndex == 3,
              onTap: () => _navigate(3, const ProfileScreen()),
            ),
          ],
        ),
      ),
    );
  }
}
