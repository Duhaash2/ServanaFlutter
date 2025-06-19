import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../l10n/app_localizations.dart';
import '../../widgets/botton_navigation_widget.dart';
import '../section_3/home_client_screen.dart';
import 'profile_screen.dart';

class StartWorkScreen extends StatefulWidget {
  const StartWorkScreen({super.key});

  @override
  State<StartWorkScreen> createState() => _StartWorkScreenState();
}

class _StartWorkScreenState extends State<StartWorkScreen> {
  int selectedIndex = 0;

  void _navigate(int index, Widget screen) {
    setState(() {
      selectedIndex = index;
    });
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final local = AppLocalizations.of(context)!;
    double scale = MediaQuery.of(context).textScaleFactor;
    const String whatsappNumber =
        '962788888888'; // Replace this with actual number

    return Scaffold(
      backgroundColor: const Color(0xFFF3EEEC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          local.jobDetails,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BottonNavigationWidget(
                icon: Icons.home_filled,
                label: local.bottomNavHome,
                isSelected: selectedIndex == 0,
                onTap: () => _navigate(0, const HomeScreen()),
              ),
              BottonNavigationWidget(
                icon: Icons.wallet,
                label: local.bottomNavWallet,
                isSelected: selectedIndex == 1,
                onTap: () => onItemTapped(1),
              ),
              BottonNavigationWidget(
                icon: Icons.history,
                label: local.bottomNavHistory,
                isSelected: selectedIndex == 2,
                onTap: () => onItemTapped(2),
              ),
              BottonNavigationWidget(
                icon: Icons.person,
                label: local.bottomNavProfile,
                isSelected: selectedIndex == 3,
                onTap: () => _navigate(3, const ProfileScreen()),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                local.clientName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'John Smith',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),

              const Divider(height: 50),

              Text(
                local.location,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 15),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/map.png',
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 30),
              const Divider(),

              Text(
                local.issueDescription,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                local.issueText,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),

              const Divider(height: 50),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    local.hourlyRate,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    '\$25.00/hr',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

             // const SizedBox(height: 20),
              const Divider(height: 50),
              /// ✅ Contact Section
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Contact Worker",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(width: 122),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          // Replace with actual phone logic
                        },
                        borderRadius: BorderRadius.circular(scale * 30),
                        child: Padding(
                          padding: EdgeInsets.all(scale * 6.0),
                          child: Icon(
                            Icons.phone,
                            color: Colors.green,
                            size: scale * 28,
                          ),
                        ),
                      ),
                      SizedBox(width: scale * 16),
                      InkWell(
                        onTap: () async {
                          final url = Uri.parse(
                            "https://wa.me/$whatsappNumber",
                          );
                          if (await canLaunchUrl(url)) {
                            await launchUrl(
                              url,
                              mode: LaunchMode.externalApplication,
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Could not open WhatsApp"),
                              ),
                            );
                          }
                        },
                        child: Image.asset(
                          'assets/images/whatsApp.png',
                          width: scale * 28,
                          height: scale * 28,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 40),

              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Start work action here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    elevation: 3,
                    shadowColor: Colors.black26,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    local.startWork,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
