import 'package:flutter/material.dart';
import 'package:servana/view/screens/section_2/login_client_screen.dart';
import 'package:servana/view/screens/section_2/login_worker_screen.dart';

class LoginSelectionScreen extends StatelessWidget {
  const LoginSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isDarkMode = theme.brightness == Brightness.dark;
    final isSmall = size.width < 400;

    return Scaffold(
      backgroundColor: isDarkMode ? theme.scaffoldBackgroundColor : const Color(0xFFEAF6FF),
      body: SafeArea(
        child: Column(
          children: [
            // Top Illustration
            SizedBox(
              height: size.height * 0.4,
              width: double.infinity,
              child: Image.asset(
                "assets/images/wo&clie.png",
                fit: BoxFit.cover,
              ),
            ),

            // Bottom Container
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 20),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                        ),
                        boxShadow: [
                          if (!isDarkMode)
                            const BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              offset: Offset(0, -4),
                            ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 15),
                          Text(
                            "Welcome! Are you a client or worker?",
                            style: theme.textTheme.titleMedium!.copyWith(
                              fontSize: isSmall ? 20 : 22,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Please choose one of the options below.",
                            style: theme.textTheme.bodyMedium!.copyWith(
                              fontSize: isSmall ? 14 : 15,
                              color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 35),

                          // Client Button
                          ElevatedButton.icon(
                            icon: Icon(
                              Icons.person_outline,
                              color: isDarkMode ? Colors.white : Colors.black87,
                            ),
                            label: Text(
                              "Login as Client",
                              style: TextStyle(
                                fontSize: 16,
                                color: isDarkMode ? Colors.white : Colors.black87,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                              isDarkMode ? Colors.blue[900]: const Color(0xFFDCEFFF),
                              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginClientScreen()),
                              );
                            },
                          ),
                          const SizedBox(height: 20),

                          // Worker Button
                          ElevatedButton.icon(
                            icon: const Icon(
                              Icons.build_outlined,
                              color: Colors.white,
                            ),
                            label: const Text(
                              "Login as Worker",
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                              isDarkMode ? Colors.orange[700] : Colors.orangeAccent,
                              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginWorkerScreen()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
