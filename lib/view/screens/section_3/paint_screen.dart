import 'package:flutter/material.dart';
import 'package:servana/view/screens/section_3/home_client_screen.dart';
import 'package:servana/view/widgets/pluming_widget.dart';

import '../../../l10n/app_localizations.dart';
import '../../widgets/botton_navigation_widget.dart';
import '../section_4/request_screen.dart';

class PaintScreen extends StatefulWidget {
  const PaintScreen({super.key});

  @override
  State<PaintScreen> createState() => _PaintScreenState();
}

class _PaintScreenState extends State<PaintScreen> {
  int selectedIndex2 = 0;

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
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Painters",
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
                  const SizedBox(height: 20),

                  // Workers List
                  PlumingWidget(
                    title: "David Harris",
                    description: "Request?",
                    imagePath: "assets/images/man1.PNG",
                    rating: 4.0,
                    price: "30",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) =>  RequestScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 13),
                  PlumingWidget(
                    title: "Amanda Wood",
                    description: "Request?",
                    imagePath: "assets/images/girl1.PNG",
                    rating: 3.5,
                    price: "30",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) =>  RequestScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 13),
                  PlumingWidget(
                    title: "James Clark",
                    description: "Request?",
                    imagePath: "assets/images/man2.PNG",
                    rating: 3.0,
                    price: "30",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) =>  RequestScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 13),
                  PlumingWidget(
                    title: "Kristin Waston",
                    description: "Request?",
                    imagePath: "assets/images/girl2.PNG",
                    rating: 4.2,
                    price: "30",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) =>  RequestScreen()),
                      );
                    },
                  ),
                ],
              ),
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
                  // Navigate to WalletScreen if available
                },
              ),
              BottonNavigationWidget(
                icon: Icons.history,
                label: "History",
                isSelected: selectedIndex2 == 2,
                onTap: () {
                  onItemTapped2(2);
                  // Navigate to HistoryScreen if available
                },
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
