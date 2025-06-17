import 'package:flutter/material.dart';
import 'package:servana/view/screens/section_3/home_client_screen.dart';
import 'package:servana/view/screens/section_4/request_screen.dart';
import 'package:servana/view/widgets/pluming_widget.dart';

import '../../../l10n/app_localizations.dart';
import '../../widgets/botton_navigation_widget.dart';

class PlumingScreen extends StatefulWidget {
  const PlumingScreen({super.key});

  @override
  State<PlumingScreen> createState() => _PlumingScreenState();
}

class _PlumingScreenState extends State<PlumingScreen> {
  int selectedIndex2 = 0;

  void onItemTapped2(int index2) {
    setState(() {
      selectedIndex2 = index2;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Colors.black : Colors.white;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Plumbers ",
              style: TextStyle(
                color: Colors.blue[900],
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              onPressed: () {},
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
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!
                              .search_service_workers_or_etc,
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: isDark ? Colors.grey[800] : Colors.grey[200],
                          filled: true,
                        ),
                      ),
                      const SizedBox(height: 25),

                      // List of workers
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          PlumingWidget(
                            title: "David Harris",
                            description: "Request? ",
                            imagePath: "assets/images/man1.PNG",
                            rating: 4.0,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => RequestScreen()),
                              );
                            },
                            price: "30",
                          ),
                          const SizedBox(height: 9),
                          PlumingWidget(
                            title: "Amanda Wood",
                            description: "Request? ",
                            imagePath: "assets/images/girl1.PNG",
                            rating: 3.5,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => RequestScreen()),
                              );
                            },
                            price: "30",
                          ),
                          const SizedBox(height: 9),
                          PlumingWidget(
                            title: "James Clark",
                            description: "Request? ",
                            imagePath: "assets/images/man2.PNG",
                            rating: 3.0,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => RequestScreen()),
                              );
                            },
                            price: "30",
                          ),
                          const SizedBox(height: 9),
                          PlumingWidget(
                            title: "Kristin Waston",
                            description: "Request? ",
                            imagePath: "assets/images/girl2.PNG",
                            rating: 4.2,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => RequestScreen()),
                              );
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
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: bgColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: SizedBox(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BottonNavigationWidget(
                icon: Icons.home_filled,
                label: "Home",
                isSelected: selectedIndex2 == 0,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                  onItemTapped2(0);
                },
              ),
              BottonNavigationWidget(
                icon: Icons.wallet,
                label: "Wallet",
                isSelected: selectedIndex2 == 1,
                onTap: () => onItemTapped2(1),
              ),
              BottonNavigationWidget(
                icon: Icons.history,
                label: "History ",
                isSelected: selectedIndex2 == 2,
                onTap: () => onItemTapped2(2),
              ),
              BottonNavigationWidget(
                icon: Icons.person,
                label: "Profile",
                isSelected: selectedIndex2 == 3,
                onTap: () => onItemTapped2(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
