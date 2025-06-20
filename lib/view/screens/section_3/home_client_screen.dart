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
import '../section_5/start_work_screen.dart';

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
    setState(() => selectedIndex = index);
  }

  void onItemTapped2(int index2) {
    setState(() => selectedIndex2 = index2);
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final hintTextColor = isDark ? Colors.grey[400] : Colors.grey[700];
    final iconColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isDark
                          ? [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)]
                          : [Colors.blue.shade900, Colors.lightBlue.shade100],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
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
                        children: [
                          Text(
                            "Servana",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ClientNotificationScreen()),

                              );
                            },
                            icon: Icon(Icons.notifications, color: Colors.white, size: 28),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Container(
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextField(
                          style: TextStyle(color: textColor),
                          decoration: InputDecoration(
                            hintText: local.search_service_workers_or_etc,
                            prefixIcon: const Icon(Icons.search),
                            hintStyle: TextStyle(color: hintTextColor),

                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isDark ? Color(0xFF1E1E1E) : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue[700],
                              child: Icon(Icons.build, color: Colors.white),
                            ),
                            title: Text(
                              'Incoming Request',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text('Plumber needed at 3:00 PM today.'),
                            trailing: Icon(Icons.chevron_right),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => StartWorkScreen()),
                              );
                            },

                          ),
                        ),
                      ),

                      Text(
                        local.categories,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: isDark ? Colors.white : Colors.blue[900],
                        ),
                      ),
                      const SizedBox(height: 13),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            CategoryButtonWidget(
                              title: local.plumbing,
                              isSelected: selectedIndex == 0,
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => PlumingScreen()));
                                onItemTapped(0);
                              },
                              ImagePath: 'assets/images/plumingg.png',
                            ),
                            CategoryButtonWidget(
                              title: local.electrical,
                              isSelected: selectedIndex == 1,
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => ElectricalScreen()));
                                onItemTapped(1);
                              },
                              ImagePath: 'assets/images/Electricall.png',
                            ),
                            CategoryButtonWidget(
                              title: local.gardner,
                              isSelected: selectedIndex == 2,
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => GardnerScreen()));
                                onItemTapped(2);
                              },
                              ImagePath: 'assets/images/gardnerr.png',
                            ),
                            CategoryButtonWidget(
                              title: local.paint,
                              isSelected: selectedIndex == 3,
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => PaintScreen()));
                                onItemTapped(3);
                              },
                              ImagePath: 'assets/images/paintingg.png',
                            ),
                            CategoryButtonWidget(
                              title: local.cleaning,
                              isSelected: selectedIndex == 4,
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => PaintScreen()));
                                onItemTapped(4);
                              },
                              ImagePath: 'assets/images/cleaningg.png',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 26),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            local.top_rated_workers,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 21,
                              color: isDark ? Colors.white : Colors.blue[900],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.tune, color: isDark ? Colors.white : Colors.blue[900]),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
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
                              price: "30",
                              subtitle: "24 ${local.jobs}",
                              tag: local.top_rated,
                              onPressed: () {},
                              description: local.plumbing,
                            ),
                            TopRatedWidget(
                              title: "Emma Smith",
                              imagePath: "assets/images/girl2.PNG",
                              rating: 3.0,
                              price: "15",
                              subtitle: "18 ${local.jobs}",
                              onPressed: () {},
                              description: local.cleaning,
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
                              price: "25",
                              subtitle: "10 ${local.jobs}",
                              onPressed: () {},
                              description: local.paint,
                            ),
                            TopRatedWidget(
                              title: "James Jonson",
                              imagePath: "assets/images/man1.PNG",
                              rating: 3.5,
                              price: "17",
                              subtitle: "18 ${local.jobs}",
                              onPressed: () {},
                              description: local.plumbing,
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
                label: local.bottomNavHome,
                isSelected: selectedIndex2 == 0,
                onTap: () {
                  onItemTapped2(0);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
                },
              ),
              BottonNavigationWidget(
                icon: Icons.wallet,
                label: local.bottomNavWallet,
                isSelected: selectedIndex2 == 1,
                onTap: () {
                  onItemTapped2(1);
                  Navigator.push(context, MaterialPageRoute(builder: (_) => WalletScreen()));
                },
              ),
              BottonNavigationWidget(
                icon: Icons.history,
                label: local.bottomNavHistory,
                isSelected: selectedIndex2 == 2,
                onTap: () {
                  onItemTapped2(2);
                  Navigator.push(context, MaterialPageRoute(builder: (_) => HistoryScreen()));
                },
              ),
              BottonNavigationWidget(
                icon: Icons.person,
                label: local.bottomNavProfile,
                isSelected: selectedIndex2 == 3,
                onTap: () {
                  onItemTapped2(3);
                  Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}