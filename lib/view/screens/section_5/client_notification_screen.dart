import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controller/notification_controller.dart';
import '../../../l10n/app_localizations.dart';
import 'package:servana/view/screens/section_3/home_client_screen.dart';
import 'package:servana/view/screens/section_5/profile_screen.dart';
import 'package:servana/view/screens/section_5/start_work_screen.dart';
import 'package:servana/view/widgets/botton_navigation_widget.dart';

class ClientNotificationScreen extends StatefulWidget {
  const ClientNotificationScreen({super.key});

  @override
  State<ClientNotificationScreen> createState() => _ClientNotificationScreenState();
}

class _ClientNotificationScreenState extends State<ClientNotificationScreen> with SingleTickerProviderStateMixin {
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fcmMessages = Provider.of<NotificationController>(context).messages;

    List<Map<String, dynamic>> notifications = fcmMessages.map((msg) {
      final status = msg.data['status'];
      if (status == 'Accepted') {
        Future.delayed(Duration.zero, () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const StartWorkScreen()),
          );
        });
      }
      return {
        'icon': Icons.notifications,
        'title': msg.notification?.title ?? "No Title",
        'subtitle': msg.notification?.body ?? "No Body",
        'time': 'Just now',
        'isRead': false,
        'status': status,
      };
    }).toList();

    List<Map<String, dynamic>> unreadNotifications = notifications.where((n) => n['isRead'] == false).toList();

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.grey[900] : Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black),
        title: Text(
          AppLocalizations.of(context)!.notifications,
          style: TextStyle(
            fontSize: 26,
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.blue[900],
          labelColor: Colors.blue[900],
          unselectedLabelColor: isDark ? Colors.white60 : Colors.grey,
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
                  _buildNotificationList(notifications, isDark),
                  _buildNotificationList(unreadNotifications, isDark),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: _buildBottomBar(MediaQuery.of(context).size.width, isDark),
    );
  }

  Widget _buildNotificationList(List<Map<String, dynamic>> data, bool isDark) {
    if (data.isEmpty) {
      return Center(
        child: Text(
          AppLocalizations.of(context)!.no_notifications,
          style: TextStyle(color: isDark ? Colors.white60 : Colors.grey, fontSize: 16),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: data.length,
      separatorBuilder: (context, index) => const Divider(indent: 72, height: 0),
      itemBuilder: (context, index) {
        final item = data[index];
        final isDeclined = item['status'] == 'Declined';

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
          title: Text(
            item['title'],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          subtitle: isDeclined
              ? Text(
            AppLocalizations.of(context)!.request_declined,
            style: TextStyle(
              color: Colors.red[700],
              fontWeight: FontWeight.bold,
            ),
          )
              : Text(
            item['subtitle'],
            style: TextStyle(color: isDark ? Colors.white70 : Colors.black87),
          ),
          trailing: Text(
            item['time'],
            style: TextStyle(fontSize: 12, color: isDark ? Colors.white60 : Colors.grey),
          ),
        );
      },
    );
  }

  BottomAppBar _buildBottomBar(double width, bool isDark) {
    return BottomAppBar(
      color: isDark ? Colors.grey[900] : Colors.white,
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
