import 'package:flutter/material.dart';
import 'package:servana/view/screens/section_3/electrical_screen.dart';
import 'package:servana/view/screens/section_3/gardner_screen.dart';
import 'package:servana/view/screens/section_3/paint_screen.dart';
import 'package:servana/view/screens/section_3/pluming%20_screen.dart';
import 'package:servana/view/screens/section_4/history_screen.dart';
import 'package:servana/view/screens/section_4/wallet_screen.dart';
import 'package:servana/view/screens/section_5/client_notification_screen.dart';
import 'package:servana/view/screens/section_5/profile_screen.dart';
import 'package:servana/view/widgets/botton_navigation_widget.dart';
import 'package:servana/view/widgets/category_button_widget.dart';
import 'package:servana/view/widgets/top_rated_widget.dart';
import '../../../l10n/app_localizations.dart';
import '../../widgets/filter_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  final double? latitude;
  final double? longitude;

  const HomeScreen({this.latitude, this.longitude, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  int selectedIndex2 = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void onItemTapped2(int index2) {
    setState(() {
      selectedIndex2 = index2;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Colors.black : Colors.white;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Blue Container
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                  decoration: BoxDecoration(
                    color: Colors.blue[900],
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Servana",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => ClientNotificationScreen(),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.notifications,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),

                      // Search
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText:
                                AppLocalizations.of(
                                  context,
                                )!.search_service_workers_or_etc,
                            prefixIcon: const Icon(Icons.search),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Categories
                      Text(
                        "Categories",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.blue[900],
                        ),
                      ),
                      const SizedBox(height: 13),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            CategoryButtonWidget(
                              title: AppLocalizations.of(context)!.pluming,
                              isSelected: selectedIndex == 0,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => PlumingScreen(),
                                  ),
                                );
                                onItemTapped(0);
                              },
                              ImagePath: 'assets/images/plumingg.png',
                            ),
                            CategoryButtonWidget(
                              title: AppLocalizations.of(context)!.electrical,
                              isSelected: selectedIndex == 1,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ElectricalScreen(),
                                  ),
                                );
                                onItemTapped(1);
                              },
                              ImagePath: 'assets/images/Electricall.png',
                            ),
                            CategoryButtonWidget(
                              title: AppLocalizations.of(context)!.gardner,
                              isSelected: selectedIndex == 2,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => GardnerScreen(),
                                  ),
                                );
                                onItemTapped(2);
                              },
                              ImagePath: 'assets/images/gardnerr.png',
                            ),
                            CategoryButtonWidget(
                              title: AppLocalizations.of(context)!.paint,
                              isSelected: selectedIndex == 3,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => PaintScreen(),
                                  ),
                                );
                                onItemTapped(3);
                              },
                              ImagePath: 'assets/images/paintingg.png',
                            ),
                            CategoryButtonWidget(
                              title: AppLocalizations.of(context)!.cleaning,
                              isSelected: selectedIndex == 4,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => PaintScreen(),
                                  ),
                                );
                                onItemTapped(4);
                              },
                              ImagePath: 'assets/images/cleaningg.png',
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 26),

                      // Top Rated
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Top Rated Workers",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 21,
                              color: Colors.blue[900],
                            ),
                          ),

                          IconButton(
                            icon: Icon(Icons.tune, color: Colors.blue[900]),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(25),
                                  ),
                                ),
                                builder: (context) => FilterBottomSheet(),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            TopRatedWidget(
                              title: "John Deo",
                              imagePath: "assets/images/man2.PNG",
                              rating: 4.5,
                              subtitle: "24 Jobs",
                              tag: "Top Rated",
                              onPressed: () {},
                              description: 'Plumbing',
                            ),
                            TopRatedWidget(
                              title: "Emma Smith",
                              imagePath: "assets/images/girl2.PNG",
                              rating: 3.0,
                              subtitle: "18 Jobs",
                              onPressed: () {},
                              description: 'Cleaning',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 11),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            TopRatedWidget(
                              title: "Clivia Brown",
                              imagePath: "assets/images/girl1.PNG",
                              rating: 4.0,
                              subtitle: "10 Jobs",
                              onPressed: () {},
                              description: 'Paint',
                            ),
                            TopRatedWidget(
                              title: "James Jonson",
                              imagePath: "assets/images/man1.PNG",
                              rating: 3.5,
                              subtitle: "18 Jobs",
                              onPressed: () {},
                              description: 'Plumbing',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // Bottom Navigation
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
                label: "Home",
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
                label: "Wallet",
                isSelected: selectedIndex2 == 1,
                onTap: () {
                  onItemTapped2(1);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => WalletScreen()),
                  );
                },
              ),
              BottonNavigationWidget(
                icon: Icons.history,
                label: "History",
                isSelected: selectedIndex2 == 2,
                onTap: () {
                  onItemTapped2(2);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => HistoryScreen()),
                  );
                },
              ),
              BottonNavigationWidget(
                icon: Icons.person,
                label: "Profile",
                isSelected: selectedIndex2 == 3,
                onTap: () {
                  onItemTapped2(3);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => ProfileScreen(),
                    ),
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
