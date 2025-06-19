import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import 'login_client_screen.dart';

class CongraScreen extends StatefulWidget {
  const CongraScreen({super.key});

  @override
  State<CongraScreen> createState() => _CongraScreenState();
}

class _CongraScreenState extends State<CongraScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginClientScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < 400;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  "assets/images/Capture.PNG",
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 13, sigmaY: 13),
                  child: Container(color: Colors.black.withOpacity(0.2)),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/images/congrats.png",
                        width: isSmall ? 220 : 350,
                        height: isSmall ? 220 : 350,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        local.congratulations,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isSmall ? 24 : 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[900],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        local.password_reset_successfully,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isSmall ? 16 : 20,
                          color: Colors.blue[900],
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
