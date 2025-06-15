import 'package:flutter/material.dart';
import '../../widgets/botton_navigation_widget.dart';
import '../section_3/home_screen.dart';
import 'profile_screen.dart';

class StartWorkScreen extends StatefulWidget {
  const StartWorkScreen({super.key});

  @override
  State<StartWorkScreen> createState() => _StartWorkScreenState();
}

class _StartWorkScreenState extends State<StartWorkScreen> {
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
      backgroundColor: const Color(0xFFF3EEEC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text('Job Details',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(MediaQuery.of(context).size.width),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Client Name',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black87),
              ),
              const SizedBox(height: 4),
              const Text('John Smith', style: TextStyle(fontSize: 16, color: Colors.black)),

              const Divider(height: 50),

              const Text('Location', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black87)),
              const SizedBox(height: 15),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/map.png',
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 30),
              const Divider(),


              const Text('Issue Description',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black87)),
              const SizedBox(height: 8),
              const Text(
                'Kitchen sink is leaking under the cabinet.\nWater is pooling inside the cabinet whenever the faucet is turned on.',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),

              const Divider(height: 50),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Hourly Rate', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('\$25.00/hr', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),

              const Spacer(),

              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    elevation: 3,
                    shadowColor: Colors.black26,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text(
                    'Start Work',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  BottomAppBar _buildBottomBar(double width) {
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
