import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servana/controller/profile_controller.dart';
import 'package:servana/view/screens/section_2/login_client_screen.dart';
import 'package:servana/view/screens/section_4/history_screen.dart';
import 'package:servana/view/screens/section_5/detail_profile_screen.dart';
import '../../../controller/lang_controller.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../l10n/app_localizations.dart';
import '../../widgets/botton_navigation_widget.dart';
import '../section_3/home_client_screen.dart';
import '../section_4/wallet_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
    final local = AppLocalizations.of(context)!;
    final currentLang = Localizations.localeOf(context).languageCode;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDarkMode ? Colors.white : Colors.black),
          onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen())),
        ),
        title: Text(
          local.profile,
          style: TextStyle(
            fontSize: width * .06,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDarkMode
                ? [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)]
                : [Color(0xFF81B9D6), Color(0xFFE1F5FE)],
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        SizedBox(height: height * .12),Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: width * 0.3,
                              height: width * 0.3,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[500],
                              ),
                              child: profileController.profileImage != null
                                  ? ClipOval(
                                child: Image.file(
                                  profileController.profileImage!,
                                  fit: BoxFit.cover,
                                  width: width * 0.3,
                                  height: width * 0.3,
                                ),
                              )
                                  : const Center(
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
                        SizedBox(height: height * .02),
                        _buildCard(width, context, isDarkMode, local.my_account, [
                          _buildTile(context, Icons.person_outline, local.personal_info, () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) =>  DetailProfileScreen()));
                          }),
                          _buildTile(context, Icons.language, local.language, null,
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
                              )),
                          _buildTile(context, Icons.dark_mode, local.dark_mode, null,
                              trailing: Switch(
                                value: Provider.of<ThemeProvider>(context).isDarkMode,
                                onChanged: (v) => Provider.of<ThemeProvider>(context, listen: false).toggleTheme(v),
                                activeColor: Colors.white,
                                activeTrackColor: Colors.white38,
                              )),
                        ]),
                        _buildCard(width, context, isDarkMode, local.notifications, [
                          _buildTile(
                            context,
                            Icons.notifications_none,
                            local.push_notifications,
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
                          _buildTile(
                            context,
                            Icons.notifications_none,
                            'Promotional Notifications',
                            null,
                            trailing: Switch(
                              value: promotionalNotifications,
                              onChanged: (v) => setState(() => promotionalNotifications = v),
                              activeColor: isDarkMode ? Colors.white : Colors.grey,
                              activeTrackColor: isDarkMode ? Colors.white38 : Colors.black26,
                              inactiveThumbColor: isDarkMode ? Colors.grey[600] : Colors.grey[400],
                              inactiveTrackColor: isDarkMode ? Colors.grey : Colors.grey[300],
                            ),
                          ),
                        ]),
                        _buildCard(width, context, isDarkMode, local.more, [
                          _buildTile(context, Icons.help_outline, local.help_center, () {}),
                          _buildTile(context, Icons.logout, local.logout, () {
                            Navigator.pushReplacement(
                                context, MaterialPageRoute(builder: (_) => const LoginClientScreen()));
                          }, iconColor: Colors.red, textColor: Colors.red),
                        ]),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),bottomNavigationBar: BottomAppBar(
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
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => WalletScreen()));
                onItemTapped(1);
              },
            ),
            BottonNavigationWidget(
              icon: Icons.history,
              label: "History",
              isSelected: selectedIndex == 2,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryScreen()));
                onItemTapped(2);
              },
            ),
            BottonNavigationWidget(
              icon: Icons.person,
              label: "Profile",
              isSelected: selectedIndex == 3,
              onTap: () => _navigate(3, ProfileScreen()),
            ),
          ],
        ),
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
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
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
              color: isDarkMode ? Colors.white : Colors.black,
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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, size: width * .06, color: iconColor ?? (isDarkMode ? Colors.white : Colors.black)),
      title: Text(
        title,
        style: TextStyle(
          fontSize: width * .04,
          fontWeight: FontWeight.w400,
          color: textColor ?? (isDarkMode ? Colors.white : Colors.black),
        ),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
