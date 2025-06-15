import 'package:flutter/material.dart';
import 'package:servana/view/screens/section_3/electrical_screen.dart';
import 'package:servana/view/screens/section_3/gardner_screen.dart';
import 'package:servana/view/screens/section_3/paint_screen.dart';
import 'package:servana/view/screens/section_3/pluming%20_screen.dart';
import 'package:servana/view/screens/section_4/history_screen.dart';
import 'package:servana/view/screens/section_4/wallet_screen.dart';
import 'package:servana/view/widgets/botton_navigation_widget.dart';
import 'package:servana/view/widgets/category_button_widget.dart';
import 'package:servana/view/widgets/top_rated_widget.dart';

import '../../../l10n/app_localizations.dart';

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

    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 50,
                left: 20,
                right: 20,
                bottom: 20,
              ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      const Text(
                        "Servana",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.notifications, color: Colors.white, size: 28),
                    ],
                  ),
                  const SizedBox(height: 15),

                  const SizedBox(height: 15),
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                              MaterialPageRoute(builder: (_) => PaintScreen()),
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
                              MaterialPageRoute(builder: (_) => PaintScreen()),
                            );
                            onItemTapped(4);
                          },
                          ImagePath: 'assets/images/cleaningg.png',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 26),
                  Text(
                    "Top Rated Workers",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                      color: Colors.blue[900],
                    ),
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
                           subtitle: " 24 Jobs",
                            tag: "Top Rated",
                          onPressed: () {},
                          description: 'Pluming',
                        ),


                        TopRatedWidget(
                          title: "Emma Smith",
                          imagePath: "assets/images/girl2.PNG",
                          rating: 3.0,
                           subtitle: " 18 Jobs",
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
                          subtitle: " 10 Jobs",
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                  );
                  onItemTapped2(0);
                },
              ),
              BottonNavigationWidget(
                icon: Icons.wallet,
                label: "Wallet",
                isSelected: selectedIndex2 == 1,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => WalletScreen()),
                  );
                  onItemTapped2(1);
                },
              ),
              BottonNavigationWidget(
                icon: Icons.history,
                label: "History",
                isSelected: selectedIndex2 == 2,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => HistoryScreen()),
                  );
                  onItemTapped2(2);
                },
              ),
              BottonNavigationWidget(
                icon: Icons.person,
                label: "Profile",
                isSelected: selectedIndex2 == 3,
                onTap: () {
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
