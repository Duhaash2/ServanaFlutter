import 'package:flutter/material.dart';
import 'package:servana/view/screens/section_3/home_client_screen.dart';
import 'package:servana/view/widgets/pluming_widget.dart';

import '../../../l10n/app_localizations.dart';
import '../../widgets/botton_navigation_widget.dart';
import '../section_4/history_screen.dart';
import '../section_4/request_screen.dart';
import '../section_4/wallet_screen.dart';
import '../section_5/client_notification_screen.dart';
import '../section_5/profile_screen.dart';

class GardnerScreen extends StatefulWidget {
  const GardnerScreen({super.key});

  @override
  State<GardnerScreen> createState() => _GardnerScreenState();
}

class _GardnerScreenState extends State<GardnerScreen> {
  int selectedIndex2 = 0;

  void onItemTapped2(int index2) {
    setState(() {
      selectedIndex2 = index2;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Colors.black : Colors.white;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.gardner, // ✅ localized
              style: TextStyle(
                color: Colors.blue[900],
                fontSize: size.width < 400 ? 22 : 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ClientNotificationScreen()),
                );
              },
              icon: Icon(Icons.notifications, color: Colors.blue[900], size: 30),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.search_service_workers_or_etc,
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: isDark ? Colors.grey[800] : Colors.grey[200],
                    filled: true,
                  ),
                ),
                const SizedBox(height: 20),

                // Workers List
                Column(
                  children: [
                    PlumingWidget(
                      title: "David Harris",
                      description: AppLocalizations.of(context)!.request,
                      imagePath: "assets/images/man1.PNG",
                      rating: 4.0,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) =>  RequestScreen()));
                      },
                      price: "30",
                    ),
                    const SizedBox(height: 13),
                    PlumingWidget(
                      title: "Amanda Wood",
                      description: AppLocalizations.of(context)!.request,
                      imagePath: "assets/images/girl1.PNG",
                      rating: 3.5,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) =>  RequestScreen()));
                      },
                      price: "30",
                    ),
                    const SizedBox(height: 13),
                    PlumingWidget(
                      title: "James Clark",
                      description: AppLocalizations.of(context)!.request,
                      imagePath: "assets/images/man2.PNG",
                      rating: 3.0,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) =>  RequestScreen()));
                      },
                      price: "30",
                    ),
                    const SizedBox(height: 13),
                    PlumingWidget(
                      title: "Kristin Waston",
                      description: AppLocalizations.of(context)!.request,
                      imagePath: "assets/images/girl2.PNG",
                      rating: 4.2,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) =>  RequestScreen()));
                      },
                      price: "30",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        color: bgColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BottonNavigationWidget(
                icon: Icons.home_filled,
                label: AppLocalizations.of(context)!.home,
                isSelected: selectedIndex2 == 0,
                onTap: () {
                  onItemTapped2(0);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                  );
                },
              ),
              BottonNavigationWidget(
                icon: Icons.wallet,
                label: AppLocalizations.of(context)!.wallet,
                isSelected: selectedIndex2 == 1,
                onTap: () {
                  onItemTapped2(1);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) =>  WalletScreen()),
                  );
                },
              ),
              BottonNavigationWidget(
                icon: Icons.history,
                label: AppLocalizations.of(context)!.my_requests,
                isSelected: selectedIndex2 == 2,
                onTap: () {
                  onItemTapped2(2);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HistoryScreen()),
                  );
                },
              ),
              BottonNavigationWidget(
                icon: Icons.person,
                label: AppLocalizations.of(context)!.profile,
                isSelected: selectedIndex2 == 3,
                onTap: () {
                  onItemTapped2(3);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ProfileScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
