import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servana/view/screens/section_2/login_worker_screen.dart';
import '../../../controller/signup_controller.dart';
import '../../../model/auth_model/signup_model.dart';
import '../../../l10n/app_localizations.dart';
import '../../widgets/signup_widget.dart';

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
        'Please fill in all required fields and select gender and profession',
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginWorkerScreen()),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
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
    final topPadding = MediaQuery.of(context).size.height * 0.18;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/Servana_signup.png",
              fit: BoxFit.cover,
            ),
          ),
          if (isDark)
            Positioned.fill(
              child: Container(color: Colors.black.withOpacity(0.3)),
            ),
          Positioned.fill(
            top: topPadding,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.grey[900]!.withOpacity(0.85)
                          : Colors.white.withOpacity(0.88),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.sign_up,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Text(AppLocalizations.of(context)!.already_have_an_account),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const LoginWorkerScreen()),
                                );
                              },
                              child: Text(
                                AppLocalizations.of(context)!.login,
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
                          labelText: AppLocalizations.of(context)!.full_name,
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: _emailController,
                          labelText: AppLocalizations.of(context)!.email,
                          keyboardType: TextInputType.emailAddress,
                          suffixIcon: const Icon(Icons.email),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          AppLocalizations.of(context)!.gender,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: RadioListTile<Gender>(
                                title: Text(AppLocalizations.of(context)!.male),
                                value: Gender.male,
                                groupValue: _selectedGender,
                                onChanged: (Gender? value) {
                                  setState(() {
                                    _selectedGender = value;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<Gender>(
                                title: Text(AppLocalizations.of(context)!.female),
                                value: Gender.female,
                                groupValue: _selectedGender,
                                onChanged: (Gender? value) {
                                  setState(() {
                                    _selectedGender = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        PhoneInputField(controller: _phoneController),
                        const SizedBox(height: 10),
                        Text(
                          "Profession",
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
                          hint: const Text("Select your profession"),
                          items: const [
                            DropdownMenuItem(value: "Plumber", child: Text("Plumber")),
                            DropdownMenuItem(value: "Electrician", child: Text("Electrician")),
                            DropdownMenuItem(value: "Gardner", child: Text("Gardner")),
                            DropdownMenuItem(value: "Painter", child: Text("Painter")),
                            DropdownMenuItem(value: "Cleaning", child: Text("Cleaning")),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedProfession = value;
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: _passwordController,
                          labelText: AppLocalizations.of(context)!.set_password,
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
                            AppLocalizations.of(context)!.register,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
