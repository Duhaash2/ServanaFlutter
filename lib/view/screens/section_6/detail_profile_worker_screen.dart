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
import 'profile_worker_screen.dart';

class DetailProfileWorkerScreen extends StatefulWidget {
  int selectedIndex = 0;
  DetailProfileWorkerScreen({super.key});

  @override
  _DetailProfileWorkerScreenState createState() => _DetailProfileWorkerScreenState();
}

class _DetailProfileWorkerScreenState extends State<DetailProfileWorkerScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  late TextEditingController _priceController;

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
      _priceController = TextEditingController(text: profileController.pricePerHour);
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
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileController = Provider.of<ProfileController>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final loc = AppLocalizations.of(context)!;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF81B9D6), Color(0xFFE1F5FE)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(loc.profile, style: const TextStyle(color: Colors.white)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: _usernameController == null
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: height * 0.02),
          child: Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: width * 0.13,
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
                      child: CircleAvatar(
                        radius: width * 0.045,
                        backgroundColor: Colors.blue,
                        child: const Icon(Icons.edit, size: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.015),
              Text(profileController.fullname,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              Text(profileController.email,
                  style: const TextStyle(fontSize: 14, color: Colors.white70)),
              SizedBox(height: height * 0.03),
              _buildInfoCard(profileController, isDarkMode, loc),
              SizedBox(height: height * 0.03),
              ElevatedButton(
                onPressed: () {
                  profileController.setAllUserData(
                    username: _usernameController.text,
                    email: _emailController.text,
                    phoneNumber: _phoneController.text,
                    password: _passwordController.text,
                    address: profileController.address,
                    pricePerHour: _priceController.text,
                    profileImage: _profileImage,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(loc.profile_updated_successfully)),
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const ProfileWorkerScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue[900],
                  padding: EdgeInsets.symmetric(horizontal: width * 0.1, vertical: height * 0.015),
                ),
                child: Text(loc.update),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(ProfileController controller, bool isDark, AppLocalizations loc) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildTextField(loc.username, _usernameController, controller.updateUsername),
          _buildTextField(loc.email, _emailController, controller.updateEmail),
          _buildTextField(loc.phone_number, _phoneController, controller.updatePhoneNumber),
          _buildTextField(loc.password, _passwordController, controller.updatePassword, isPassword: true),
          _buildTextField(loc.price_per_hour, _priceController, controller.updatePricePerHour),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, Function(String) onChanged, {
    bool isPassword = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: TextField(
        obscureText: isPassword,
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey, width: 1),
          ),
        ),
      ),
    );
  }
}