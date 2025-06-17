import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../controller/signup_controller.dart';
import '../../../controller/profile_controller.dart'; // ✅ جديد
import '../../../model/auth_model/signup_model.dart';
import '../../../l10n/app_localizations.dart';
import '../../widgets/signup_widget.dart';
import 'login_client_screen.dart';
import '../section_5/detail_profile_screen.dart'; // ✅ جديد

enum Gender { male, female }

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  String? _backendFormattedDate;
  Gender? _selectedGender;

  Future<void> _registerUser(BuildContext context) async {
    if (_firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _dateController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _selectedGender == null) {
      _showErrorDialog(context, 'Please fill in all required fields and select gender');
      return;
    }

    final signUpController = Provider.of<SignUpController>(context, listen: false);
    final SignUpModel user = SignUpModel(
      email: _emailController.text,
      password: _passwordController.text,
      phonenum: _phoneController.text,
      firstname: _firstNameController.text,
      lastname: _lastNameController.text,
      birthDate: _backendFormattedDate,
      gender: _selectedGender == Gender.male ? "Male" : "Female",
    );

    log('Sending user data with birthDate: ${user.birthDate}, gender: ${user.gender}');
    final success = await signUpController.registerUser(user);

    if (success) {
      // ✅ حفظ البيانات داخل ProfileController
      final profileController = Provider.of<ProfileController>(context, listen: false);
      profileController.setAllUserData(
        username: "${_firstNameController.text} ${_lastNameController.text}",
        email: _emailController.text,
        phoneNumber: _phoneController.text,
        password: _passwordController.text,
        address: '',
      );

      // ✅ التوجيه لصفحة DetailProfileScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => DetailProfileScreen()),
      );
    } else {
      _showErrorDialog(context, signUpController.errorMessage);
    }
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
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 90),
                const SizedBox(height: 100),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
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
                                MaterialPageRoute(builder: (context) => LoginClientScreen()),
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
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller: _firstNameController,
                              labelText: AppLocalizations.of(context)!.first_name,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomTextField(
                              controller: _lastNameController,
                              labelText: AppLocalizations.of(context)!.last_name,
                            ),
                          ),
                        ],
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
                      CustomTextField(
                        controller: _dateController,
                        labelText: AppLocalizations.of(context)!.birth_date,
                        readOnly: true,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                            );

                            if (pickedDate != null) {
                              final formattedDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                                  .format(pickedDate.toUtc());

                              log('Selected date formatted: $formattedDate');

                              setState(() {
                                _dateController.text =
                                    DateFormat('dd/MM/yyyy').format(pickedDate);
                                _backendFormattedDate = formattedDate;
                              });
                            }
                          },
                        ),
                      ),
                      PhoneInputField(controller: _phoneController),
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
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
