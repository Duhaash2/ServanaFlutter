import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:servana/view/screens/section_3/home_client_screen.dart';
import 'package:servana/view/screens/section_4/wallet_screen.dart';
import '../../widgets/botton_navigation_widget.dart';
import '../section_5/client_notification_screen.dart';
import '../section_5/profile_screen.dart';
import 'history_screen.dart';

class RatingScreen extends StatefulWidget {
  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  int selectedIndex2 = 0;
  double userRating = 4.5;
  final TextEditingController issueController = TextEditingController();

  void onItemTapped2(int index2) {
    setState(() {
      selectedIndex2 = index2;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Colors.black : Colors.transparent;
    const topPadding = 70.0;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFEAF6FF), Color(0xFF86D3EC)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
                icon: const Icon(Icons.arrow_back, color: Color(0xFF0D47A1), size: 32),
              ),
              const Text(
                "Servana ",
                style: TextStyle(
                  color: Color(0xFF0D47A1),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder:
                            (context) => ClientNotificationScreen()),
                  );
                },
                icon: const Icon(Icons.notifications, color: Color(0xFF0D47A1), size: 32),
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
                    padding: const EdgeInsets.only(top: topPadding, left: 20, right: 20, bottom: 12),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.grey[900] : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "Rate Your Experience ",
                            style: TextStyle(
                              fontSize: 25,
                              color: Color(0xFF0D47A1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const CircleAvatar(
                            radius: 55,
                            backgroundImage: AssetImage("assets/images/man1.PNG"),
                          ),
                          const SizedBox(height: 8),
                          RatingBar.builder(
                            initialRating: userRating,
                            minRating: 1,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 30,
                            direction: Axis.horizontal,
                            itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                            onRatingUpdate: (rating) {
                              setState(() {
                                userRating = rating;
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: issueController,
                            maxLines: 10,
                            style: const TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                              hintText: "Leave A Review (Optional)",
                              hintStyle: TextStyle(color: Colors.grey[600]),
                              filled: true,
                              fillColor: Colors.grey[100],
                              contentPadding: const EdgeInsets.all(17),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Color(0xFF0D47A1)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0D47A1),
                              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 7),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Rating Submitted Successfully!"),
                                    backgroundColor: Colors.blueAccent,
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                                Future.delayed(const Duration(seconds: 2), () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                                  );
                                });
                              },
                              child: const Text(
                                "Submit Rating",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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

      ),
    );
  }
}
