import 'dart:async';
import 'package:flutter/material.dart';
import 'package:servana/view/screens/section_6/end_work_w_screen.dart';
import 'package:servana/view/screens/section_6/incoming_request_w_screen.dart';
import 'package:servana/view/screens/section_6/worker_notification_screen.dart';
import 'package:servana/view/widgets/home_worker_widget.dart';

class HomeWorkerScreen extends StatefulWidget {
  const HomeWorkerScreen({super.key});

  @override
  State<HomeWorkerScreen> createState() => _HomeWorkerScreenState();
}

class _HomeWorkerScreenState extends State<HomeWorkerScreen> {
  final List<List<Color>> gradientColors = [
    [Color(0xFFB3E5FC), Color(0xFF81D4FA)],
    [Color(0xFF81D4FA), Color(0xFF4FC3F7)],
    [Color(0xFF4FC3F7), Color(0xFF29B6F6)],
    [Color(0xFF29B6F6), Color(0xFF03A9F4)],
  ];

  int currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startGradientAnimation();
  }

  void _startGradientAnimation() {
    _timer = Timer.periodic(const Duration(seconds: 6), (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % gradientColors.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;


    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              " Worker",
              style: TextStyle(
                color: Colors.blue[900],
                fontSize: size.width < 400 ? 22 : 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WorkerNotificationScreen(),
                  ),
                );
              },
              icon: Icon(
                Icons.notifications,
                color: Colors.blue[900],
                size: 30,
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(seconds: 2),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors[currentIndex],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  Text(
                    "Welcome ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    "Search for tasks and jobs",
                    style: TextStyle(color: Colors.blue[900], fontSize: 26),
                  ),
                  const SizedBox(height: 50),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      HomeWorkerWidget(
                        title: "Notification",
                        description: "You Have A New Notification ! ",
                        Icons: Icons.notifications,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WorkerNotificationScreen(),
                            ),
                          );
                        },
                      ),
                      HomeWorkerWidget(
                        title: "Job Request",
                        Icons: Icons.next_week_rounded,

                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const IncomingRequestWScreen(),
                            ),
                          );
                        }, description: 'Click On It To See A Requests',
                      ),
                      HomeWorkerWidget(
                        title: "End Work ",
                        Icons: Icons.check_circle_outline,

                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const EndWorkWScreen()),
                          );
                        }, description: 'Click On It To End Work',
                      ),
                      HomeWorkerWidget(
                        title: "Profile",
                        Icons: Icons.person,

                        onTap: () {
                          // Add navigation to Profile Screen here
                        }, description: 'See Your Profile',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
