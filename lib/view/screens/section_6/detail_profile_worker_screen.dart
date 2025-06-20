import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../../controller/profile_controller.dart';
import '../../../l10n/app_localizations.dart';
import '../section_6/profile_worker_screen.dart';

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
  String? _selectedProfession;
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
      _selectedProfession = profileController.categoryName;
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
    final locale = AppLocalizations.of(context)!;
    final profileController = Provider.of<ProfileController>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)]
              : [Color(0xFF81B9D6), Color(0xFFE1F5FE)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(locale.profile, style: const TextStyle(color: Colors.white)),
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
                  Container(
                    width: width * 0.26,
                    height: width * 0.26,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[500],
                    ),
                    child: const Center(
                      child: Icon(Icons.person, size: 60, color: Colors.white),
                    ),
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
              Text(profileController.fullname, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              Text(profileController.email, style: const TextStyle(fontSize: 14, color: Colors.white70)),
              SizedBox(height: height * 0.03),
              _buildInfoCard(profileController, isDark, locale),
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
                    category: _selectedProfession,
                    profileImage: _profileImage,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(locale.profile_updated_successfully)),
                  );
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ProfileWorkerScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark ? Colors.grey[600] : Colors.blue[900],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: width * 0.1, vertical: height * 0.015),
                ),
                child: Text(locale.update),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(ProfileController controller, bool isDark, AppLocalizations locale) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), spreadRadius: 2, blurRadius: 5)],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildTextField(locale.full_name, _usernameController, controller.updateUsername, isDark),
          _buildTextField(locale.email, _emailController, controller.updateEmail, isDark, readOnly: true),
          _buildTextField(locale.phone_number, _phoneController, controller.updatePhoneNumber, isDark),
          _buildTextField(locale.password, _passwordController, controller.updatePassword, isDark, isPassword: true),
          _buildTextField(locale.price_per_hour, _priceController, controller.updatePricePerHour, isDark),
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                locale.profession,
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? Colors.white70 : Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: isDark ? Colors.grey[850] : Colors.white,
                ),
                child: DropdownButtonFormField<String>(
                  value: [
                    locale.plumber,
                    locale.electrician,
                    locale.gardner,
                    locale.painter,
                    locale.cleaning,
                  ].contains(_selectedProfession)
                      ? _selectedProfession
                      : null,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: isDark ? Colors.grey[700] : Colors.grey[100],
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: isDark ? Colors.white54 : Colors.grey, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: isDark ? Colors.white : Colors.blue, width: 1.5),
                    ),
                  ),
                  style: TextStyle(color: isDark ? Colors.white : Colors.black),
                  iconEnabledColor: isDark ? Colors.white70 : Colors.black54,
                  items: [
                    DropdownMenuItem(value: locale.plumber, child: Text(locale.plumber)),
                    DropdownMenuItem(value: locale.electrician, child: Text(locale.electrician)),
                    DropdownMenuItem(value: locale.gardner, child: Text(locale.gardner)),
                    DropdownMenuItem(value: locale.painter, child: Text(locale.painter)),
                    DropdownMenuItem(value: locale.cleaning, child: Text(locale.cleaning)),
                  ],
                  onChanged: (value) {
                    setState(() => _selectedProfession = value);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      String label,
      TextEditingController controller,
      Function(String) onChanged,
      bool isDark, {
        bool isPassword = false,
        bool readOnly = false,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 14, color: isDark ? Colors.white70 : Colors.black87, fontWeight: FontWeight.w500)),
          const SizedBox(height: 3),
          TextField(
            obscureText: isPassword,
            controller: controller,
            onChanged: onChanged,
            readOnly: readOnly,
            style: TextStyle(color: isDark ? Colors.white : Colors.black),
            decoration: InputDecoration(
              filled: true,
              fillColor: isDark ? Colors.grey[700] : Colors.grey[100],
              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: isDark ? Colors.white54 : Colors.grey, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: isDark ? Colors.white : Colors.blue, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
