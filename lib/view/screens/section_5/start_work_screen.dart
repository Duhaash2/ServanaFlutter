import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widgets/botton_navigation_widget.dart';
import '../section_3/home_client_screen.dart';
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

  Future<void> _openMapLink() async {
    final url = Uri.parse('https://maps.app.goo.gl/Zh26qhtLt2GWUMQZA');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not open the map link")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final local = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF3EEEC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          local.jobDetails,
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: isDark ? Colors.grey[900] : Colors.white,
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? Colors.grey[850] : Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text( local.clientName,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20, color: isDark ? Colors.white : Colors.black87)),
              const SizedBox(height: 4),
              Text('John Smith', style: TextStyle(fontSize: 16, color: isDark ? Colors.white70 : Colors.black)),

              const Divider(height: 50),

              Text(local.location,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20, color: isDark ? Colors.white : Colors.black87)),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: _openMapLink,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/map.png',
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 30),
              const Divider(),

              Text(  local.issueDescription,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20, color: isDark ? Colors.white : Colors.black87)),
              const SizedBox(height: 8),
              Text(
                local.issueText,                style: TextStyle(fontSize: 14, color: isDark ? Colors.grey[300] : Colors.grey[700]),
              ),

              const Divider(height: 50),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(local.hourlyRate,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
                  Text('\$25.00/hr',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
                ],
              ),

              const Spacer(),

              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Start work action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    elevation: 3,
                    shadowColor: Colors.black26,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: Text(
                    local.startWork,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
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
}
