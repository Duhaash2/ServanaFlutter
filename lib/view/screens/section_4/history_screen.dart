import 'package:flutter/material.dart';
import 'package:servana/view/screens/section_3/home_client_screen.dart';
import 'package:servana/view/screens/section_4/rating_screen.dart';
import 'package:servana/view/screens/section_4/request_screen.dart';
import 'package:servana/view/screens/section_4/wallet_screen.dart';
import 'package:servana/view/widgets/history_widget.dart';
import 'package:servana/view/widgets/pluming_widget.dart';

import '../../../l10n/app_localizations.dart';
import '../../widgets/botton_navigation_widget.dart';

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
    final screenHeight = MediaQuery.of(context).size.height;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Colors.black : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      //take color from alaa
      backgroundColor:  Color(0xFFF3EEEC),

      appBar: AppBar(
        backgroundColor:  Color(0xFFF5F5DC),
        elevation: 0,
        automaticallyImplyLeading: false,
        //  titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              icon: Icon(Icons.arrow_back, color: Colors.blue[900], size: 32),
            ),
            Text(
              "History ",
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
              SizedBox(height: 10),
              SizedBox(height: 15),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    HistoryWidget(
                      title: "David Harris",
                      description: "Completed",
                      price: "28",
                      description1: 'Plumber', date: '20/2/2025',
                    ),
                    SizedBox(height: 7),
                    HistoryWidget(
                      title: "Amanda Wood",
                      description: " Completed",
                      price: "30",
                      description1: 'Gardner', date: '10/4/2025',
                    ),
                    SizedBox(height: 7),

                    HistoryWidget(
                      title: "James Clark",
                      description: "Completed",
                      price: "35",
                      description1: 'Painter',
                      description2: '', date: '10/5/2025',
                    ),
                    SizedBox(height: 7),

                    HistoryWidget(
                      title: "Kristin Waston",
                      description: "Completed  ",
                      price: "40",
                      description1: 'Electrician ',
                      description2: '', date: '22/7/2025',
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
                isSelected: selectedIndex2 == 1,
                onTap:
                    () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  ),

                  onItemTapped2(1),
                },
              ),
              BottonNavigationWidget(
                icon: Icons.wallet,
                label: "Wallet",
                isSelected: selectedIndex2 == 1,
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WalletScreen()),
                  ),

                  onItemTapped2(1)},
              ),
              BottonNavigationWidget(
                icon: Icons.history,
                label: "History ",
                isSelected: selectedIndex2 == 0,
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HistoryScreen()),
                  ),
                  onItemTapped2(0)},
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
