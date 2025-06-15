import 'package:flutter/material.dart';
import 'package:servana/view/screens/section_5/profile_screen.dart';
import '../../widgets/botton_navigation_widget.dart';
import '../section_3/home_screen.dart';

class WorkerNotificationScreen extends StatefulWidget {
  const WorkerNotificationScreen({super.key});

  @override
  State<WorkerNotificationScreen> createState() => _WorkerNotificationScreenState();
}

class _WorkerNotificationScreenState extends State<WorkerNotificationScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedIndex = 0;

  final List<Map<String, dynamic>> notifications = [
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
    {
      'icon': Icons.chat,
      'title': 'New message from client',
      'subtitle': 'Client: Please arrive before 3 PM',
      'time': 'Yesterday',
      'isRead': true,
    },
    {
      'icon': Icons.check_circle,
      'title': 'Job completed',
      'subtitle': 'You marked the job as done',
      'time': '2d ago',
      'isRead': true,
    },
    {
      'icon': Icons.cancel,
      'title': 'Job cancelled',
      'subtitle': 'The client cancelled the request',
      'time': '2d ago',
      'isRead': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _navigate(int index, Widget screen) {
    setState(() {
      selectedIndex = index;
    });
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> unread = notifications.where((n) => n['isRead'] == false).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Notifications',
          style: TextStyle(
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
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Unread'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildNotificationList(notifications),
          _buildNotificationList(unread),
        ],
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
