import 'dart:async';
import 'package:flutter/material.dart';
import 'package:servana/view/screens/section_6/profile_worker_screen.dart';
import 'package:servana/view/screens/section_6/end_work_w_screen.dart';
import 'package:servana/view/screens/section_6/incoming_request_w_screen.dart';
import 'package:servana/view/screens/section_6/worker_notification_screen.dart';
import 'package:servana/view/widgets/home_worker_widget.dart';
import '../../../l10n/app_localizations.dart';

class HomeWorkerScreen extends StatefulWidget {
  const HomeWorkerScreen({super.key});

  @override
  State<HomeWorkerScreen> createState() => _HomeWorkerScreenState();
}

class _HomeWorkerScreenState extends State<HomeWorkerScreen> {
  final List<List<Color>> gradientColors = [
    [const Color(0xFFB3E5FC), const Color(0xFF81D4FA)],
    [const Color(0xFF81D4FA), const Color(0xFF4FC3F7)],
    [const Color(0xFF4FC3F7), const Color(0xFF29B6F6)],
    [const Color(0xFF29B6F6), const Color(0xFF03A9F4)],
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
    final local = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.blue[900];

    return Scaffold(
        backgroundColor: isDark ? Colors.white : Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                local.worker_title,
                style: TextStyle(
                  color: textColor,
                  fontSize: 30,
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
                  color: textColor,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
        body: Stack(
            children: [
              if (!isDark)
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
                )
              else
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
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
                        local.welcome_text,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: textColor,
                          fontSize: 30,
                        ),
                      ),
                      Text(
                        local.search_for_tasks,
                        style: TextStyle(color: textColor, fontSize: 26),
                      ),
                      const SizedBox(height: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          HomeWorkerWidget(
                            title: local.notification_card_title,
                            description: local.notification_card_sub,
                            Icons: Icons.notifications,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const WorkerNotificationScreen()),
                              );
                            },
                          ),
                          HomeWorkerWidget(
                            title: local.job_request_title,
                            description: local.job_request_sub,
                            Icons: Icons.next_week_rounded,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const IncomingRequestWScreen()),
                              );
                            },
                          ),
                          HomeWorkerWidget(
                            title: local.end_work_title,
                            description: local.end_work_sub,
                            Icons: Icons.check_circle_outline,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const EndWorkWScreen()),
                              );
                            },
                          ),
                          HomeWorkerWidget(
                            title: local.profile_title,
                            description: local.profile_sub,
                            Icons: Icons.person,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileWorkerScreen(),
                                ),
                              );
                            },
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
