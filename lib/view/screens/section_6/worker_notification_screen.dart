import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../controller/notification_controller.dart';
import '../../../l10n/app_localizations.dart';
import 'package:servana/view/screens/section_3/home_client_screen.dart';
import 'package:servana/view/screens/section_5/profile_screen.dart';
import 'package:servana/view/widgets/botton_navigation_widget.dart';

class WorkerNotificationScreen extends StatefulWidget {
  const WorkerNotificationScreen({super.key});

  @override
  State<WorkerNotificationScreen> createState() => _WorkerNotificationScreenState();
}

class _WorkerNotificationScreenState extends State<WorkerNotificationScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
    final local = AppLocalizations.of(context)!;
    final fcmMessages = Provider.of<NotificationController>(context).messages;

    List<Map<String, dynamic>> notifications = fcmMessages.map((msg) {
      return {
        'icon': Icons.notifications,
        'title': msg.notification?.title ?? "No Title",
        'subtitle': msg.notification?.body ?? "No Body",
        'time': 'Just now',
        'isRead': false,
      };
    }).toList();

    List<Map<String, dynamic>> unread = notifications.where((n) => n['isRead'] == false).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          local.notifications,
          style: const TextStyle(fontSize: 26, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.blue[900],
          labelColor: Colors.blue[900],
          unselectedLabelColor: Colors.grey,
          labelStyle: const TextStyle(fontWeight: FontWeight.w500),
          tabs: [
            Tab(text: local.all),
            Tab(text: local.unread),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildNotificationList(notifications, local),
          _buildNotificationList(unread, local),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(MediaQuery.of(context).size.width, local),
    );
  }

  Widget _buildNotificationList(List<Map<String, dynamic>> data, AppLocalizations local) {
    if (data.isEmpty) {
      return Center(
        child: Text(
          local.no_notifications,
          style: const TextStyle(color: Colors.grey, fontSize: 16),
        ),
      );
    }

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
                const Positioned(
                  right: 0,
                  top: 0,
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 5,
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

  BottomAppBar _buildBottomBar(double width, AppLocalizations local) {
    return BottomAppBar(
      color: Colors.white,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottonNavigationWidget(
              icon: Icons.home_filled,
              label: local.bottomNavHome,
              isSelected: selectedIndex == 0,
              onTap: () => _navigate(0, const HomeScreen()),
            ),
            BottonNavigationWidget(
              icon: Icons.wallet,
              label: local.bottomNavWallet,
              isSelected: selectedIndex == 1,
              onTap: () => onItemTapped(1),
            ),
            BottonNavigationWidget(
              icon: Icons.history,
              label: local.bottomNavHistory,
              isSelected: selectedIndex == 2,
              onTap: () => onItemTapped(2),
            ),
            BottonNavigationWidget(
              icon: Icons.person,
              label: local.bottomNavProfile,
              isSelected: selectedIndex == 3,
              onTap: () => _navigate(3, const ProfileScreen()),
            ),
          ],
        ),
      ),
    );
  }
}
