import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servana/controller/profile_controller.dart';
import 'package:servana/view/screens/section_2/login_client_screen.dart';
import 'package:servana/view/screens/section_5/detail_profile_worker_screen.dart';
import '../../../controller/lang_controller.dart';
import '../../../core/theme/theme_provider.dart';
import '../../widgets/botton_navigation_widget.dart';
import '../section_3/home_client_screen.dart';

class ProfileWorkerScreen extends StatefulWidget {
  const ProfileWorkerScreen({super.key});

  @override
  State<ProfileWorkerScreen> createState() => _ProfileWorkerScreenState();
}

class _ProfileWorkerScreenState extends State<ProfileWorkerScreen> {
  int selectedIndex = 3;
  bool pushNotifications = true;
  bool promotionalNotifications = false;

  void onItemTapped(int index) {
    setState(() => selectedIndex = index);
  }

  void _navigate(int idx, Widget page) {
    onItemTapped(idx);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    final profileController = Provider.of<ProfileController>(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
          onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen())),
        ),
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: width * .06,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.titleMedium?.color,
          ),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: height * .02),
              CircleAvatar(
                radius: width * .15,
                backgroundColor: Colors.grey[200],
                backgroundImage: profileController.profileImage != null
                    ? FileImage(profileController.profileImage!)
                    : const AssetImage("assets/images/profile.png") as ImageProvider,
              ),
              SizedBox(height: height * .02),
              Text(
                profileController.username.isNotEmpty ? profileController.username : 'Your Name',
                style: TextStyle(
                  fontSize: width * .045,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.titleMedium?.color,
                ),
              ),
              Text(
                profileController.email.isNotEmpty ? profileController.email : 'your@email.com',
                style: TextStyle(
                  fontSize: width * .035,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
              if (profileController.pricePerHour.isNotEmpty)
                Text(
                  '${profileController.pricePerHour} JOD/hr',
                  style: TextStyle(
                    fontSize: width * .035,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
              SizedBox(height: height * .02),
              Container(
                width: width * .9,
                padding: EdgeInsets.all(width * .04),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: isDarkMode ? Colors.black.withOpacity(.5) : Colors.grey.withOpacity(.3),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'My Account',
                      style: TextStyle(
                        fontSize: width * .045,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textTheme.titleMedium?.color,
                      ),
                    ),
                    SizedBox(height: width * .02),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.person_outline, size: width * .06, color: Theme.of(context).iconTheme.color),
                      title: Text(
                        'Personal Information',
                        style: TextStyle(
                          fontSize: width * .04,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailProfileWorkerScreen())),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.language, size: width * .06, color: Theme.of(context).iconTheme.color),
                      title: Text(
                        'Language',
                        style: TextStyle(
                          fontSize: width * .04,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                      trailing: TextButton(
                        onPressed: () {
                          String currentLang = Localizations.localeOf(context).languageCode;
                          String newLang = currentLang == 'ar' ? 'en' : 'ar';
                          Provider.of<LangController>(context, listen: false).changeLang(langCode: newLang);
                        },
                        style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.blueAccent)),
                        child: const Text('عربية', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.dark_mode, size: width * .06, color: Theme.of(context).iconTheme.color),
                      title: Text(
                        'Dark Mode',
                        style: TextStyle(
                          fontSize: width * .04,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                      trailing: Switch(
                        value: Provider.of<ThemeProvider>(context).isDarkMode,
                        onChanged: (v) => Provider.of<ThemeProvider>(context, listen: false).toggleTheme(v),
                        activeColor: Colors.blue,
                        activeTrackColor: Colors.blue[100],
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.privacy_tip_outlined, size: width * .06, color: Theme.of(context).iconTheme.color),
                      title: Text(
                        'Privacy Policy',
                        style: TextStyle(
                          fontSize: width * .04,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.settings_outlined, size: width * .06, color: Theme.of(context).iconTheme.color),
                      title: Text(
                        'Settings',
                        style: TextStyle(
                          fontSize: width * .04,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              Container(
                width: width * .9,
                margin: EdgeInsets.only(top: width * .04),
                padding: EdgeInsets.all(width * .04),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: isDarkMode ? Colors.black.withOpacity(.5) : Colors.grey.withOpacity(.3),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Notifications',
                      style: TextStyle(
                        fontSize: width * .045,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textTheme.titleMedium?.color,
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.notifications_none, size: width * .06, color: Theme.of(context).iconTheme.color),
                      title: Text(
                        'Push Notifications',
                        style: TextStyle(
                          fontSize: width * .04,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                      trailing: Switch(
                        value: pushNotifications,
                        onChanged: (v) => setState(() => pushNotifications = v),
                        activeColor: Colors.blue,
                        activeTrackColor: Colors.blue[100],
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.notifications_none, size: width * .06, color: Theme.of(context).iconTheme.color),
                      title: Text(
                        'Promotional Notifications',
                        style: TextStyle(
                          fontSize: width * .04,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                      trailing: Switch(
                        value: promotionalNotifications,
                        onChanged: (v) => setState(() => promotionalNotifications = v),
                        activeColor: Colors.blue,
                        activeTrackColor: Colors.blue[100],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: width * .9,
                margin: EdgeInsets.only(top: width * .04, bottom: width * .04),
                padding: EdgeInsets.all(width * .04),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: isDarkMode ? Colors.black.withOpacity(.5) : Colors.grey.withOpacity(.3),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'More',
                      style: TextStyle(
                        fontSize: width * .045,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textTheme.titleMedium?.color,
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.help_outline, size: width * .06, color: Theme.of(context).iconTheme.color),
                      title: Text(
                        'Help Center',
                        style: TextStyle(
                          fontSize: width * .04,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.logout, size: width * .06, color: Colors.red),
                      title: Text(
                        'Log Out',
                        style: TextStyle(
                          fontSize: width * .04,
                          fontWeight: FontWeight.w400,
                          color: Colors.red,
                        ),
                      ),
                      onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginClientScreen()),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(width),
    );
  }

  BottomAppBar _buildBottomBar(double width) {
    return BottomAppBar(
      color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: SizedBox(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BottonNavigationWidget(
              icon: Icons.home_filled,
              label: "Home",
              isSelected: selectedIndex == 0,
              onTap: () => _navigate(0, const HomeScreen()),
            ),
            BottonNavigationWidget(
              icon: Icons.wallet,
              label: "Wallet",
              isSelected: selectedIndex == 1,
              onTap: () => onItemTapped(1),
            ),
            BottonNavigationWidget(
              icon: Icons.history,
              label: "History",
              isSelected: selectedIndex == 2,
              onTap: () => onItemTapped(2),
            ),
            BottonNavigationWidget(
              icon: Icons.person,
              label: "Profile",
              isSelected: selectedIndex == 3,
              onTap: () => _navigate(3, const ProfileWorkerScreen()),
            ),
          ],
        ),
      ),
    );
  }
}