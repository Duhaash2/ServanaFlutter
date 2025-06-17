import 'package:flutter/material.dart';
import 'package:servana/view/screens/section_2/login_client_screen.dart';
import 'package:servana/view/screens/section_2/login_worker_screen.dart';

class LoginSelectionScreen extends StatelessWidget {
  const LoginSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 400;

    return Scaffold(
      backgroundColor: const Color(0xFFEAF6FF),
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
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, -4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 15,),
                          Text(
                            "Welcome! Are you a client or worker?",
                            style: TextStyle(
                              fontSize: isSmall ? 20 : 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Please choose one of the options below.",
                            style: TextStyle(
                              fontSize: isSmall ? 14 : 15,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 35),

                          // Client Button
                          ElevatedButton.icon(
                            icon: const Icon(
                              Icons.person_outline,
                              color: Colors.black87,
                            ),
                            label: const Text(
                              "Login as Client",
                              style: TextStyle(fontSize: 16, color: Colors.black87),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFDCEFFF),
                              padding: const EdgeInsets.symmetric(
                                vertical: 14,
                                horizontal: 20,
                              ),
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
                              backgroundColor: Colors.orangeAccent,
                              padding: const EdgeInsets.symmetric(
                                vertical: 14,
                                horizontal: 20,
                              ),
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
