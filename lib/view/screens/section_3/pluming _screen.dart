import 'package:flutter/material.dart';
import 'package:servana/view/screens/section_3/home_client_screen.dart';
import 'package:servana/view/screens/section_4/rating_screen.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Colors.black : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final screenWidth = MediaQuery.of(context).size.width;
    final fontSize = screenWidth * 0.05; // or any scale that fits your design

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        //  titleSpacing: 0,
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

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText:
                      AppLocalizations.of(
                        context,
                      )!.search_service_workers_or_etc,
                  prefixIcon: Icon(Icons.search),
                  // suffixIcon: IconButton(
                  //   icon: Icon(Icons.tune),
                  //   onPressed:
                  //       () => Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (_) => FilterScreen()),
                  //   ),
                  // ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: isDark ? Colors.grey[800] : Colors.grey[200],
                  filled: true,
                ),
              ),
              SizedBox(height: 25),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       "A Plumbers",
              //       style: TextStyle(
              //         fontSize: 22,
              //         color: Colors.teal,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //   ],
              // ),
              SingleChildScrollView(
                child: Column(
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
                          MaterialPageRoute(
                            builder: (context) => RequestScreen(),
                          ),
                        );
                      },
                      price: "30",
                    ),
                    SizedBox(height: 9),
                    PlumingWidget(
                      title: "Amanda Wood",
                      description: "Request? ",
                      imagePath: "assets/images/girl1.PNG",
                      rating: 3.5,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RequestScreen(),
                          ),
                        );
                      },
                      price: "30",
                    ),
                    SizedBox(height: 9),

                    PlumingWidget(
                      title: "James Clark",
                      description: "Request? ",
                      imagePath: "assets/images/man2.PNG",
                      rating: 3.0,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RequestScreen(),
                          ),
                        );
                      },
                      price: "30",
                    ),
                    SizedBox(height: 9),

                    PlumingWidget(
                      title: "Kristin Waston",
                      description: "Request? ",
                      imagePath: "assets/images/girl2.PNG",
                      rating: 4.2,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RequestScreen(),
                          ),
                        );
                      },
                      price: "30",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: bgColor,
        shape: CircularNotchedRectangle(),
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
                onTap:
                    () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      ),

                      onItemTapped2(0),
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
