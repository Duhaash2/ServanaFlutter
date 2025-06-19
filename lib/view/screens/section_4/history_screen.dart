import 'package:flutter/material.dart';
import 'package:servana/view/screens/section_3/home_client_screen.dart';
import 'package:servana/view/screens/section_4/wallet_screen.dart';
import 'package:servana/view/screens/section_5/profile_screen.dart';
import 'package:servana/view/widgets/history_widget.dart';
import '../../../l10n/app_localizations.dart';
import '../../widgets/botton_navigation_widget.dart';
import '../section_5/client_notification_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int selectedIndex2 = 0;

  void onItemTapped2(int index2) {
    setState(() {
      selectedIndex2 = index2;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF121212) : const Color(0xFFF3EEEC);
    final textColor = isDark ? Colors.white : Colors.black;
   // final bgColor = isDark ? Colors.black : Colors.white;
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
              },
              icon: Icon(Icons.arrow_back, color: Colors.blue[900], size: 32),
            ),
            Text(
              local.history,
              style: TextStyle(
                color: Colors.blue[900],
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ClientNotificationScreen()));
              },
              icon: Icon(Icons.notifications, color: Colors.blue[900], size: 32),
            ),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        style: TextStyle(color: textColor),
                        decoration: InputDecoration(
                          hintText: local.search_workers,
                          hintStyle: TextStyle(color: isDark ? Colors.white70 : Colors.grey),
                          prefixIcon: Icon(Icons.search, color: isDark ? Colors.white70 : Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: isDark ? Colors.grey[800] : Colors.grey[200],
                          filled: true,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const SizedBox(height: 15),
                      Column(
                        children: const [
                          HistoryWidget(
                            title: "David Harris",
                            description: "Completed",
                            price: "28",
                            description1: 'Plumber',
                            date: '20/2/2025',
                          ),
                          SizedBox(height: 7),
                          HistoryWidget(
                            title: "Amanda Wood",
                            description: "Completed",
                            price: "30",
                            description1: 'Gardner',
                            date: '10/4/2025',
                          ),
                          SizedBox(height: 7),
                          HistoryWidget(
                            title: "James Clark",
                            description: "Completed",
                            price: "35",
                            description1: 'Painter',
                            date: '10/5/2025',
                          ),
                          SizedBox(height: 7),
                          HistoryWidget(
                            title: "Kristin Waston",
                            description: "Completed",
                            price: "40",
                            description1: 'Electrician',
                            date: '22/7/2025',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: isDark ? Colors.grey[900] : Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BottonNavigationWidget(
                icon: Icons.home_filled,
                label: local.bottomNavHome,
                isSelected: selectedIndex2 == 1,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
                  onItemTapped2(1);
                },
              ),
              BottonNavigationWidget(
                icon: Icons.wallet,
                label: local.bottomNavWallet,
                isSelected: selectedIndex2 == 1,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) =>  WalletScreen()));
                  onItemTapped2(1);
                },
              ),
              BottonNavigationWidget(
                icon: Icons.history,
                label: local.bottomNavHistory,
                isSelected: selectedIndex2 == 0,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen()));
                  onItemTapped2(0);
                },
              ),
              BottonNavigationWidget(
                icon: Icons.person,
                label: local.bottomNavProfile,
                isSelected: selectedIndex2 == 3,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
                  onItemTapped2(3);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
