import 'package:flutter/material.dart';
import 'home_worker_screen.dart';

class EndWorkWScreen extends StatefulWidget {
  const EndWorkWScreen({super.key});

  @override
  State<EndWorkWScreen> createState() => _EndWorkWScreenState();
}

class _EndWorkWScreenState extends State<EndWorkWScreen> {
  int selectedIndex = 0;

  void _navigate(int index, Widget screen) {
    setState(() => selectedIndex = index);
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  void onItemTapped(int index) {
    setState(() => selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Job In Progress',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: textColor,

          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 30),
            _infoCard("CLIENT NAME", "John Doe", Icons.person),
            const SizedBox(height: 16),
            _infoCard("LOCATION", "123 Main St", Icons.location_on),
            const SizedBox(height: 16),
            _infoCard("ISSUE", "Leaking faucet in kitchen", Icons.warning_amber_rounded),
            const SizedBox(height: 16),
            _infoCard("DURATION", "01:25:30", Icons.timer),
            const SizedBox(height: 16),
            _infoCard("STATUS", "Working", Icons.work_outline),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text("Ended Work Successfully"),
                      backgroundColor: Colors.blue[400],
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                  Future.delayed(const Duration(milliseconds: 500), () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const HomeWorkerScreen()),
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  elevation: 5,
                  shadowColor: Colors.black26,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'End Work',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(String title, String value, IconData icon) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? Colors.grey[850] : Colors.blue[50];
    final iconColor = isDark ? Color(0xFF448AFF) : Colors.blue[800];
    final labelColor = isDark ? Colors.white70 : Colors.blue[800];
    final textColor = isDark ? Colors.white : Colors.black;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: labelColor,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: textColor.withOpacity(0.85),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
