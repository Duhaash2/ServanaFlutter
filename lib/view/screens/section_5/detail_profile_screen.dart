import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../../../controller/profile_controller.dart';
import '../../../l10n/app_localizations.dart';
import 'profile_screen.dart';

class DetailProfileScreen extends StatefulWidget {
  const DetailProfileScreen({super.key});

  @override
  State<DetailProfileScreen> createState() => _DetailProfileScreenState();
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
      final profile = Provider.of<ProfileController>(context, listen: false);
      _usernameController = TextEditingController(text: profile.fullname);
      _emailController = TextEditingController(text: profile.email);
      _phoneController = TextEditingController(text: profile.phoneNumber);
      _passwordController = TextEditingController(text: profile.password);
      _addressController = TextEditingController(text: profile.address);
      _profileImage = profile.profileImage;
      setState(() {});
    });
  }

  Future<void> _pickImage() async {
    await Permission.photos.request();
    await Permission.camera.request();
    final locale = AppLocalizations.of(context)!;

    showModalBottomSheet(
      context: context,
      builder: (_) => Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: Text(locale.take_from_camera),
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
            title: Text(locale.pick_from_gallery),
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

  Future<void> detectLocationAndSetAddress() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Location permission denied")),
        );
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;
      String address = '${place.street}, ${place.locality}, ${place.country}';
      setState(() {
        _addressController.text = address;
      });
    }
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

  @override
  Widget build(BuildContext context) {
    final profileController = Provider.of<ProfileController>(context);
    final locale = AppLocalizations.of(context)!;
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
                      image: _profileImage != null
                          ? DecorationImage(image: FileImage(_profileImage!), fit: BoxFit.cover)
                          : null,
                    ),
                    child: _profileImage == null
                        ? const Center(child: Icon(Icons.person, size: 60, color: Colors.white))
                        : null,
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
              const SizedBox(height: 5),
              Text(profileController.fullname,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              Text(profileController.email, style: const TextStyle(fontSize: 14, color: Colors.white70)),
              const SizedBox(height: 8),
              _buildInfoCard(profileController, isDark, locale),
              const SizedBox(height: 8),
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
                    SnackBar(content: Text(locale.profile_updated_successfully)),
                  );
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
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
          _buildAddressField(isDark, locale),
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
          Text(label,
              style: TextStyle(fontSize: 14, color: isDark ? Colors.white70 : Colors.black87, fontWeight: FontWeight.w500)),
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

  Widget _buildAddressField(bool isDark, AppLocalizations locale) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(locale.address,
              style: TextStyle(fontSize: 14, color: isDark ? Colors.white70 : Colors.black87, fontWeight: FontWeight.w500)),
          const SizedBox(height: 3),
          GestureDetector(
            onTap: detectLocationAndSetAddress,
            child: AbsorbPointer(
              child: TextField(
                controller: _addressController,
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: isDark ? Colors.grey[700] : Colors.grey[100],
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  suffixIcon: const Icon(Icons.location_on),
                  hintText: "Tap to detect your location", // you can localize this too if needed
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
