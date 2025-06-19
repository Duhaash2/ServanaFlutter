import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../l10n/app_localizations.dart';
import 'intro2_screen.dart';
import 'intro4_location_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _controller = PageController();

  Future<void> setOnboardingSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

  }

  void goToNextScreen(Widget screen) async {
    await setOnboardingSeen();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFEAF6FF),
      body: Column(
        children: [
          // 🔵 Top Image Section
          SizedBox(
            height: height * 0.55,
            width: double.infinity,
            child: Image.asset(
              "assets/images/introdu1.png",
              fit: BoxFit.cover,
            ),
          ),

          // 🔵 Texts and Button Section
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.welcome_to_servana,
                    style: TextStyle(
                      fontSize: width * 0.060,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.blue[900],
                    ),
                  ),
                  SizedBox(height: height * 0.015),
                  Text(
                    AppLocalizations.of(context)!.experience_quick_seamless_service,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: width * 0.042,
                      color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: height * 0.05),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => goToNextScreen(const Intro2Screen()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[900],
                        padding: EdgeInsets.symmetric(
                          vertical: height * 0.018,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.btn_cont,
                        style: TextStyle(
                          fontSize: width * 0.045,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 🔵 Bottom Navigation Row
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.05,
              vertical: height * 0.02,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => goToNextScreen(const Intro4LocationScreen()),
                  child: Text(
                    "Skip",
                    style: TextStyle(
                      fontSize: width * 0.04,
                      color: isDarkMode ? Colors.blue[900] : Colors.grey,
                    ),
                  ),
                ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 1,
                  effect: ExpandingDotsEffect(
                    activeDotColor: Colors.blue[900]!,
                    dotHeight: 8,
                    dotWidth: 8,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.blue[900],
                    size: width * 0.07,
                  ),
                  onPressed: () => goToNextScreen(const Intro2Screen()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
