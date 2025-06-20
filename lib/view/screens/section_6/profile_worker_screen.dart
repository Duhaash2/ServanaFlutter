import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servana/controller/profile_controller.dart';
import 'package:servana/view/screens/section_2/login_worker_screen.dart';
import 'package:servana/view/screens/section_6/detail_profile_worker_screen.dart';
import 'package:servana/view/screens/section_6/home_worker_screen.dart';
import '../../../controller/lang_controller.dart';
import '../../../core/theme/theme_provider.dart';

class ProfileWorkerScreen extends StatefulWidget {
  const ProfileWorkerScreen({super.key});

  @override
  State<ProfileWorkerScreen> createState() => _ProfileWorkerScreenState();
}

class _ProfileWorkerScreenState extends State<ProfileWorkerScreen> {
  int selectedIndex = 3;
  bool pushNotifications = true;
  bool promotionalNotifications = false;

  @override
  Widget build(BuildContext context) {
    final profileController = Provider.of<ProfileController>(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDarkMode
                ? [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)]
                : [Color(0xFF81B9D6), Color(0xFFE1F5FE)],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: false,
              floating: true,
              snap: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeWorkerScreen()));
                },
              ),
              title: Text(
                'Profile',
                style: TextStyle(
                  fontSize: width * .06,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: height * .1),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: width * 0.3,
                        height: width * 0.3,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[500],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: height * .02),
                  Text(
                    profileController.fullname.isNotEmpty ? profileController.fullname : 'Your Name',
                    style: TextStyle(
                      fontSize: width * .045,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    profileController.email.isNotEmpty ? profileController.email : 'your@email.com',
                    style: TextStyle(
                      fontSize: width * .035,
                      color: Colors.white70,
                    ),
                  ),
                  if (profileController.pricePerHour.isNotEmpty)
                    Text(
                      '${profileController.pricePerHour} JOD/hr',
                      style: TextStyle(
                        fontSize: width * .035,
                        color: Colors.white70,
                      ),
                    ),
                  SizedBox(height: height * .02),

                  /// My Account
                  _buildCard(width, context, isDarkMode, 'My Account', [
                    _buildTile(context, Icons.person_outline, 'Personal Information', () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => DetailProfileWorkerScreen()));
                    }),
                    _buildTile(context, Icons.language, 'Language', null,
                      trailing: TextButton(
                        onPressed: () {
                          String currentLang = Localizations.localeOf(context).languageCode;
                          String newLang = currentLang == 'ar' ? 'en' : 'ar';
                          Provider.of<LangController>(context, listen: false).changeLang(langCode: newLang);
                        },
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all(isDarkMode ? Colors.white : Colors.black),
                          overlayColor: MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: Text(
                          Localizations.localeOf(context).languageCode == 'en' ? 'عربية' : 'English',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),

                      ),
                    ),

                    _buildTile(context, Icons.dark_mode, 'Dark Mode', null,
                        trailing: Switch(
                          value: Provider.of<ThemeProvider>(context).isDarkMode,
                          onChanged: (v) => Provider.of<ThemeProvider>(context, listen: false).toggleTheme(v),
                          activeColor: Colors.white,
                          activeTrackColor: Colors.white38,
                        )),
                  ]),

                  /// Notifications
                  _buildCard(width, context, isDarkMode, 'Notifications', [
                    _buildTile(
                      context,
                      Icons.notifications_none,
                      'Push Notifications',
                      null,
                      trailing: Switch(
                        value: pushNotifications,
                        onChanged: (v) => setState(() => pushNotifications = v),
                        activeColor: isDarkMode ? Colors.white : Colors.black,
                        activeTrackColor: isDarkMode ? Colors.white38 : Colors.black26,
                        inactiveThumbColor: isDarkMode ? Colors.grey[600] : Colors.grey[400],
                        inactiveTrackColor: isDarkMode ? Colors.grey : Colors.grey[300],
                      ),
                    ),

                  ]),

                  /// More
                  _buildCard(width, context, isDarkMode, 'More', [
                    _buildTile(context, Icons.help_outline, 'Help Center', () {}),
                    _buildTile(context, Icons.logout, 'Log Out', () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginWorkerScreen()));
                    }, iconColor: Colors.red, textColor: Colors.red),
                  ]),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(double width, BuildContext context, bool isDarkMode, String title, List<Widget> children) {
    return Container(
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
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: width * .045,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.titleMedium?.color,
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTile(BuildContext context, IconData icon, String title, VoidCallback? onTap,
      {Widget? trailing, Color? iconColor, Color? textColor}) {
    final width = MediaQuery.of(context).size.width;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, size: width * .06, color: iconColor ?? Theme.of(context).iconTheme.color),
      title: Text(
        title,
        style: TextStyle(
          fontSize: width * .04,
          fontWeight: FontWeight.w400,
          color: textColor ?? Theme.of(context).textTheme.bodyMedium?.color,
        ),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
