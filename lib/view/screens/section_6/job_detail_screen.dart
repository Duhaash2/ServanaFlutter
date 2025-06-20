import 'package:flutter/material.dart';
import 'package:servana/view/screens/section_6/worker_notification_screen.dart';
import '../../widgets/botton_navigation_widget.dart';
import '../section_3/home_client_screen.dart';
import '../section_5/profile_screen.dart';

class JobDetailScreen extends StatefulWidget {
  const JobDetailScreen({super.key});

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen> {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _navigate(int index, Widget screen) {
    setState(() {
      selectedIndex = index;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF121212) : Colors.white;
    final cardColor = isDark ? const Color(0xFF1E1E1E) : const Color(0xFFEAF6FF);
    final titleColor = isDark ? Colors.white : const Color(0xFF0D47A1);
    final textColor = isDark ? Colors.white70 : Colors.black;
    final sectionColor = isDark ? Colors.white60 : Colors.black54;
    final iconColor = isDark ? Colors.white : Colors.blue[900];

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: titleColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Job Details',
          style: TextStyle(
            color: titleColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {

              Navigator.push(context, MaterialPageRoute(builder: (context)=>WorkerNotificationScreen()));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _infoCard(
                    color: cardColor,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundImage: AssetImage('assets/images/man1.PNG'),
                          backgroundColor: Colors.grey.shade200,
                        ),
                        const SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Jacob Jones',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Plumbing',
                              style: TextStyle(
                                fontSize: 14,
                                color: titleColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _sectionTitle('ISSUE DESCRIPTION', sectionColor),
                  _infoCard(
                    color: cardColor,
                    child: Row(
                      children: [
                        Icon(Icons.description, color:Colors.blue[900]),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Kitchen sink is leaking and won\'t drain properly',
                            style: TextStyle(fontSize: 15, color: textColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _sectionTitle('STARTED', sectionColor),
                  _infoCard(
                    color: cardColor,
                    child: Row(
                      children: [
                        Icon(Icons.schedule, color:Colors.blue[900]),
                        const SizedBox(width: 10),
                        Text(
                          'June 5, 10:35 AM',
                          style: TextStyle(fontSize: 15, color: textColor),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _sectionTitle('ARRIVAL STATUS', sectionColor),
                  _infoCard(
                    color: cardColor,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.directions_car, color:Colors.blue[900]),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'On the way',
                            style: TextStyle(fontSize: 15, color: textColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle contact
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
                  'Contact Worker',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, Color color) {
    return Text(
      title,
      style: TextStyle(
        color: color,
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _infoCard({required Widget child, required Color color}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.transparent),
        boxShadow: const [BoxShadow(color: Colors.transparent)],
      ),
      child: child,
    );
  }
}
