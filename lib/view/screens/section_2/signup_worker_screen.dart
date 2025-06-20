import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controller/signup_controller.dart';
import '../../../model/auth_model/signup_model.dart';
import '../../../l10n/app_localizations.dart';
import '../../widgets/signup_widget.dart';
import 'login_client_screen.dart';

enum Gender { male, female }

class SignupWorkerScreen extends StatefulWidget {
  const SignupWorkerScreen({super.key});

  @override
  _SignupWorkerScreenState createState() => _SignupWorkerScreenState();
}

class _SignupWorkerScreenState extends State<SignupWorkerScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  Gender? _selectedGender;
  String? _selectedProfession;

  Future<void> _registerUser(BuildContext context) async {
    if (_fullNameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _selectedGender == null ||
        _selectedProfession == null) {
      _showErrorDialog(
        context,
        AppLocalizations.of(context)!.error_fill_fields,
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginClientScreen()),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.error),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)!.ok),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final signUpController = Provider.of<SignUpController>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final width = MediaQuery.of(context).size.width;
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/Servana_signup.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
              child: Container(
                width: width > 600 ? 500 : double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.grey[900]!.withOpacity(0.85)
                      : Colors.white.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      local.sign_up,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text(local.already_have_an_account),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginClientScreen()),
                            );
                          },
                          child: Text(
                            local.login,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0D47A1),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    CustomTextField(
                      controller: _fullNameController,
                      labelText: local.full_name,
                    ),

                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: _emailController,
                      labelText: local.email,
                      keyboardType: TextInputType.emailAddress,
                      suffixIcon: const Icon(Icons.email),
                    ),

                    const SizedBox(height: 10),
                    Text(
                      local.gender,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<Gender>(
                            title: Text(local.male),
                            value: Gender.male,
                            groupValue: _selectedGender,
                            onChanged: (Gender? value) {
                              setState(() => _selectedGender = value);
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<Gender>(
                            title: Text(local.female),
                            value: Gender.female,
                            groupValue: _selectedGender,
                            onChanged: (Gender? value) {
                              setState(() => _selectedGender = value);
                            },
                          ),
                        ),
                      ],
                    ),

                    PhoneInputField(controller: _phoneController),

                    const SizedBox(height: 10),
                    Text(
                      local.profession,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    DropdownButtonFormField<String>(
                      value: _selectedProfession,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: isDark ? Colors.grey[800] : Colors.grey[200],
                      ),
                      hint: Text(local.select_profession),
                      items: [
                        DropdownMenuItem(value: "Plumber", child: Text(local.plumber)),
                        DropdownMenuItem(value: "Electrician", child: Text(local.electrician)),
                        DropdownMenuItem(value: "Gardner", child: Text(local.gardner)),
                        DropdownMenuItem(value: "Painter", child: Text(local.painter)),
                        DropdownMenuItem(value: "Cleaning", child: Text(local.cleaning)),
                      ],
                      onChanged: (value) {
                        setState(() => _selectedProfession = value);
                      },
                    ),

                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: _passwordController,
                      labelText: local.set_password,
                      isPassword: !_isPasswordVisible,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),

                    const SizedBox(height: 20),
                    signUpController.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[900],
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: () => _registerUser(context),
                      child: Text(
                        local.register,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
