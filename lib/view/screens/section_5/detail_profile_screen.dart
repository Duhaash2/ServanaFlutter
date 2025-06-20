import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../../controller/profile_controller.dart';
import '../../../l10n/app_localizations.dart';
import '../../widgets/botton_navigation_widget.dart';
import '../section_3/home_client_screen.dart';
import '../section_4/wallet_screen.dart';
import '../section_4/history_screen.dart';
import 'profile_screen.dart';

class DetailProfileScreen extends StatefulWidget {
  int selectedIndex = 0;
  DetailProfileScreen({super.key});

  @override
  _DetailProfileScreenState createState() => _DetailProfileScreenState();
}

class _DetailProfileScreenState extends State<DetailProfileScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  late TextEditingController _addressController;

  File? _profileImage;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final profileController = Provider.of<ProfileController>(context, listen: false);
      _usernameController = TextEditingController(text: profileController.fullname);
      _emailController = TextEditingController(text: profileController.email);
      _phoneController = TextEditingController(text: profileController.phoneNumber);
      _passwordController = TextEditingController(text: profileController.password);
      _addressController = TextEditingController(text: profileController.address);
      _profileImage = profileController.profileImage;
      setState(() {});
    });
  }

  Future<void> _pickImage() async {
    await Permission.photos.request();
    await Permission.camera.request();

    showModalBottomSheet(
      context: context,
      builder: (_) => Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: Text(AppLocalizations.of(context)!.take_from_camera),
            onTap: () async {
              Navigator.pop(context);
              final picked = await picker.pickImage(source: ImageSource.camera);
              if (picked != null) {
                final imageFile = File(picked.path);
                setState(() => _profileImage = imageFile);
                Provider.of<ProfileController>(context, listen: false).updateProfileImage(imageFile);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: Text(AppLocalizations.of(context)!.pick_from_gallery),
            onTap: () async {
              Navigator.pop(context);
              final picked = await picker.pickImage(source: ImageSource.gallery);
              if (picked != null) {
                final imageFile = File(picked.path);
                setState(() => _profileImage = imageFile);
                Provider.of<ProfileController>(context, listen: false).updateProfileImage(imageFile);
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void onItemTapped(int index) => setState(() => widget.selectedIndex = index);

  void _navigate(int index, Widget screen) {
    onItemTapped(index);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    final profileController = Provider.of<ProfileController>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final width = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF83BAD8), Color(0xFFE1F5FE)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(AppLocalizations.of(context)!.profile, style: const TextStyle(color: Colors.white)),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: _usernameController == null
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey[200],
                            backgroundImage: _profileImage != null
                                ? FileImage(_profileImage!)
                                : const AssetImage("assets/images/profile.png") as ImageProvider,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: _pickImage,
                              child: const CircleAvatar(
                                radius: 16,
                                backgroundColor: Colors.blue,
                                child: Icon(Icons.edit, size: 16, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(profileController.fullname,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      Text(profileController.email,
                          style: const TextStyle(fontSize: 14, color: Colors.white70)),
                      const SizedBox(height: 20),
                      _buildInfoCard(profileController, isDarkMode),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          profileController.setAllUserData(
                            username: _usernameController.text,
                            email: _emailController.text,
                            phoneNumber: _phoneController.text,
                            password: _passwordController.text,
                            address: _addressController.text,
                            profileImage: _profileImage,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(AppLocalizations.of(context)!.profile_updated_successfully)),
                          );
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[900],
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                        ),
                        child: Text(AppLocalizations.of(context)!.update, style: const TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: _buildBottomBar(width),
          ),
        );
      },
    );
  }

  Widget _buildInfoCard(ProfileController controller, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.white30 : Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildTextField(AppLocalizations.of(context)!.username, _usernameController, controller.updateUsername, isDarkMode: isDark),
          _buildTextField(AppLocalizations.of(context)!.email, _emailController, controller.updateEmail, isDarkMode: isDark),
          _buildTextField(AppLocalizations.of(context)!.phone_number, _phoneController, controller.updatePhoneNumber, isDarkMode: isDark),
          _buildTextField(AppLocalizations.of(context)!.password, _passwordController, controller.updatePassword, isPassword: true, isDarkMode: isDark),
          _buildTextField(AppLocalizations.of(context)!.address, _addressController, controller.updateAddress, isDarkMode: isDark),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, Function(String) onChanged,
      {bool isPassword = false, bool isDarkMode = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: TextField(
        obscureText: isPassword,
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: isDarkMode ? Colors.grey[800] : Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: isDarkMode ? Colors.white70 : Colors.grey, width: 1),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar(double width) {
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
              label: AppLocalizations.of(context)!.home,
              isSelected: widget.selectedIndex == 3,
              onTap: () => _navigate(3, const HomeScreen()),
            ),
            BottonNavigationWidget(
              icon: Icons.wallet,
              label: AppLocalizations.of(context)!.wallet,
              isSelected: widget.selectedIndex == 1,
              onTap: () => _navigate(1,  WalletScreen()),
            ),
            BottonNavigationWidget(
              icon: Icons.history,
              label: AppLocalizations.of(context)!.history,
              isSelected: widget.selectedIndex == 2,
              onTap: () => _navigate(2, const HistoryScreen()),
            ),
            BottonNavigationWidget(
              icon: Icons.person,
              label: AppLocalizations.of(context)!.profile,
              isSelected: widget.selectedIndex == 0,
              onTap: () => _navigate(0, const ProfileScreen()),
            ),
          ],
        ),
      ),
    );
  }
}