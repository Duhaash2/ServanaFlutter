import 'package:flutter/material.dart';
import 'package:servana/view/screens/section_6/home_worker_screen.dart';
import 'package:servana/view/screens/section_6/job_detail_screen.dart';

import '../../../l10n/app_localizations.dart';

class IncomingRequestWScreen extends StatefulWidget {
  const IncomingRequestWScreen({super.key});

  @override
  State<IncomingRequestWScreen> createState() => _IncomingRequestsScreenState();
}

class _IncomingRequestsScreenState extends State<IncomingRequestWScreen> {
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF121212) : const Color(0xFFF3EEEC);
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final titleColor = isDark ? Colors.white : Colors.black;
    final subtitleColor = isDark ? Colors.white70 : Colors.grey[700];
    final declineButtonColor = isDark ? Colors.grey[800] : Colors.blue[50];

    final local = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          local.incoming_requests,
          style: TextStyle(
            color: titleColor,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: titleColor),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        children: [
          _buildRequestCard(
            name: 'Alice Smith',
            service: 'Plumbing - Leaky Faucet',
            address: '123 Mani St. Anytown',
            cardColor: cardColor,
            titleColor: titleColor,
            subtitleColor: subtitleColor!,
            declineButtonColor: declineButtonColor!,
            onTap: () => _navigate(0, const JobDetailScreen()),
            local: local,
          ),
          _buildRequestCard(
            name: 'Dayid Johnson',
            service: 'Electrical - Light Fixture',
            address: '45 Ehn St. Anytown',
            cardColor: cardColor,
            titleColor: titleColor,
            subtitleColor: subtitleColor!,
            declineButtonColor: declineButtonColor!,
            onTap: () => _navigate(0, const JobDetailScreen()),
            local: local,
          ),
          _buildRequestCard(
            name: 'Susan Brown',
            service: 'HVAC - Amotallation',
            address: '55 Gan St. Anytown',
            onTap: () => _navigate(0, const JobDetailScreen()),
            local: local,
            cardColor: cardColor,
            titleColor: titleColor,
            subtitleColor: subtitleColor!,
            declineButtonColor: declineButtonColor!,
          ),
          _buildRequestCard(
            name: 'Jakob Alice',
            service: 'HVAC - Amotallation',
            address: '123 Mani St. Anytown',
            cardColor: cardColor,
            titleColor: titleColor,
            subtitleColor: subtitleColor!,
            declineButtonColor: declineButtonColor!,
            onTap: () => _navigate(0, const JobDetailScreen()),
            local: local,
          ),
        ],
      ),
    );
  }

  Widget _buildRequestCard({
    required String name,
    required String service,
    required String address,
    required VoidCallback onTap,
    required AppLocalizations local,
    required Color cardColor,
    required Color titleColor,
    required Color subtitleColor,
    required Color declineButtonColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: titleColor)),
          Text(service, style: TextStyle(fontSize: 14, color: subtitleColor)),
          Text(address, style: TextStyle(fontSize: 13, color: subtitleColor)),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const JobDetailScreen()),
                );
              },
              child:  Text(
                local.view_details,
                style: TextStyle(
                  fontSize: 13,
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(local.request_accepted),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                  Future.delayed(const Duration(milliseconds: 500), () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeWorkerScreen()));
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(local.accept, style: const TextStyle(fontSize: 13, color: Colors.white)),
              ),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(local.request_declined),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                  Future.delayed(const Duration(milliseconds: 500), () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeWorkerScreen()));
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: declineButtonColor,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(local.decline, style: TextStyle(color: titleColor)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
