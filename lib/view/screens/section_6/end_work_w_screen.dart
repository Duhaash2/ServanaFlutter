import 'package:flutter/material.dart';
import '../../widgets/botton_navigation_widget.dart';
import '../section_3/home_screen.dart';
import '../section_5/profile_screen.dart';

class EndWorkWScreen extends StatefulWidget {
  const EndWorkWScreen({super.key});

  @override
  State<EndWorkWScreen> createState() => _EndWorkWScreenState();
}

class _EndWorkWScreenState extends State<EndWorkWScreen> {
  int selectedIndex = 0;

  void _navigate(int index, Widget screen) {
    setState(() {
      selectedIndex = index;
    });
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Job In Progress',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),

      bottomNavigationBar: _buildBottomBar(MediaQuery.of(context).size.width),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _infoCard("CLIENT NAME", "John Doe", Icons.person),
            const SizedBox(height: 16),
            _infoCard("LOCATION", "123 Main St", Icons.location_on),
            const SizedBox(height: 16),
            _infoCard("ISSUE", "Leaking faucet in kitchen", Icons.warning_amber_rounded),
            const SizedBox(height: 16),
            _infoCard("DURATION", "01:25:30", Icons.timer),
            const SizedBox(height: 16),
            _infoCard("STATUS", "Working", Icons.work_outline),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle end work
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  elevation: 5,
                  shadowColor: Colors.black26,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text(
                  'End Work',
                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(String title, String value, IconData icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue[800], size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
