import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../../widgets/botton_navigation_widget.dart';
import '../section_3/home_client_screen.dart';
import '../section_5/profile_screen.dart';
import 'home_worker_screen.dart';

class EndWorkWScreen extends StatefulWidget {
  const EndWorkWScreen({super.key});

  @override
  State<EndWorkWScreen> createState() => _EndWorkWScreenState();
}

class _EndWorkWScreenState extends State<EndWorkWScreen> {
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
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          local.job_in_progress,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _infoCard(local.client_name, "John Doe", Icons.person),
            const SizedBox(height: 16),
            _infoCard(local.location, "123 Main St", Icons.location_on),
            const SizedBox(height: 16),
            _infoCard(local.issue, "Leaking faucet in kitchen", Icons.warning_amber_rounded),
            const SizedBox(height: 16),
            _infoCard(local.duration, "01:25:30", Icons.timer),
            const SizedBox(height: 16),
            _infoCard(local.status, local.working_status, Icons.work_outline),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(local.end_work_success),
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
                child: Text(
                  local.end_work,
                  style: const TextStyle(
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue[800], size: 28),
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
                    color: Colors.blue[800],
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
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
