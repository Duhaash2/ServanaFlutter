import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../l10n/app_localizations.dart';
import '../../../controller/lang_controller.dart';
import 'intro4_location_screen.dart';

class Intro2Screen extends StatefulWidget {
  const Intro2Screen({super.key});

  @override
  State<Intro2Screen> createState() => _Intro2ScreenState();
}

class _Intro2ScreenState extends State<Intro2Screen> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFEAF6FF), // Light blue background

      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: height * 0.4,
                    child: Transform.scale(
                      scale: width > 600 ? 1.4 : 1.2,
                      child: Image.asset(
                        "assets/images/intodu2.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.09),
                  Text(
                    AppLocalizations.of(context)!.receive_professional_help_on_time,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.blue[900],
                    ),
                  ),
                  SizedBox(height: height * 0.015),
                  Text(
                    AppLocalizations.of(context)!.request_services_from_comfort_of_home,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: width * 0.042,
                      color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: height * 0.06),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Intro4LocationScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[900],
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.15,
                          vertical: height * 0.015,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.btn_cont,
                        style: TextStyle(fontSize: width * 0.045, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Intro4LocationScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Skip",
                    style: TextStyle(
                      fontSize: width * 0.04,
                      color: isDarkMode ? Colors.white : Colors.blue[900],
                    ),
                  ),
                ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 2,
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Intro4LocationScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
