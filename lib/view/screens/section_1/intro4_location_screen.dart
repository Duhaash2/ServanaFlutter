import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:servana/view/screens/section_2/login_selection_screen.dart';
import '../../../l10n/app_localizations.dart';

class Intro4LocationScreen extends StatefulWidget {
  const Intro4LocationScreen({super.key});

  @override
  State<Intro4LocationScreen> createState() => _Intro4LocationScreenState();
}

class _Intro4LocationScreenState extends State<Intro4LocationScreen> {
  Future<void> _enableLocation(BuildContext context) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("📍 Location services are disabled. Please enable them."),
        ),
      );
      await Geolocator.openLocationSettings();
      return;
    }

    PermissionStatus permission = await Permission.location.request();

    if (permission == PermissionStatus.granted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ Location permission granted!")),
      );

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      print("✅ Latitude: ${position.latitude}");
      print("✅ Longitude: ${position.longitude}");

      // ✅ Save onboarding complete
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isFirstTime', false);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginSelectionScreen()),
      );
    } else if (permission == PermissionStatus.denied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("❌ Location permission denied.")),
      );
    } else if (permission == PermissionStatus.permanentlyDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("⚠️ Location permission permanently denied. Open settings to allow."),
        ),
      );
      await openAppSettings();
    }
  }

  Future<void> _skipIntro(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginSelectionScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.5,
                width: double.infinity,
                child: Image.asset("assets/images/intodu3.PNG", fit: BoxFit.cover),
              ),
              SizedBox(height: height * 0.03),
              Text(
                AppLocalizations.of(context)!.turn_on_your_location,
                style: TextStyle(
                  fontSize: width * 0.05,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.blue[900],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: height * 0.015),
              Text(
                AppLocalizations.of(context)!
                    .to_continues_let_your_device_turn_on_location_which_uses_googles_location_service,
                style: TextStyle(
                  fontSize: width * 0.04,
                  color: isDarkMode ? Colors.grey[300] : Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: height * 0.07),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _enableLocation(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: EdgeInsets.symmetric(vertical: height * 0.02),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.yes_turn_it_on,
                    style: TextStyle(
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => _skipIntro(context),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    side: BorderSide(
                      color: isDarkMode ? Colors.grey[600]! : Colors.grey[400]!,
                    ),
                    padding: EdgeInsets.symmetric(vertical: height * 0.02),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.btn_cancel,
                    style: TextStyle(
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
