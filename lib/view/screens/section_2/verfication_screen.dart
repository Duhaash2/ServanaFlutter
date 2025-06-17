import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../model/auth_model/verfication_model.dart';
import '../../../service/auth/authentication_service.dart';
import 'forgot_password_page.dart';
import '../../../l10n/app_localizations.dart';

class VerficationScreen extends StatefulWidget {
  final String email;

  VerficationScreen({required this.email});

  @override
  _VerficationScreenState createState() => _VerficationScreenState();
}

class _VerficationScreenState extends State<VerficationScreen> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(5, (_) => TextEditingController());
    _focusNodes = List.generate(5, (_) => FocusNode());
  }

  @override
  void dispose() {
    _controllers.forEach((c) => c.dispose());
    _focusNodes.forEach((f) => f.dispose());
    super.dispose();
  }

  Future<void> _verifyOtp() async {
    String otpCode = _controllers.map((c) => c.text).join();

    if (otpCode.length != 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the complete 5-digit code.')),
      );
      return;
    }

    setState(() => isLoading = true);

    final model = Verfication_Model(
      email: widget.email,
      otpCode: otpCode,
      isSignup: true, // ✅ hardcoded to true as you requested
    );

    // ✅✅ تم تعطيل كود التحقق من الـ OTP مؤقتًا لتجربة الواجهة فقط:
    /*
    final success = await AuthenticationService().verifyOtp(model);
    */

    setState(() => isLoading = false);

    // if (success) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('OTP verified successfully!')),
    //   );

    // ✅ الانتقال إلى شاشة تغيير كلمة المرور:
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const ForgotPasswordPage()),
    );
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Verification failed. Please try again.')),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/Servana_signup.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(color: Colors.black.withOpacity(0.3)),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey[900] : Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 20),
                        Image.asset('assets/images/otp.png', height: 80),
                        const SizedBox(height: 15),
                        Text(
                          AppLocalizations.of(context)!
                              .a_4_digit_code_has_been_sent_to_your_email_please_enter_it_to_verify
                              .replaceAll('4-digit', '5-digit'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark ? Colors.white70 : Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(5, (index) => otpBox(index)),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[900],
                            ),
                            onPressed: isLoading ? null : _verifyOtp,
                            child: isLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : Text(
                              AppLocalizations.of(context)!.verify,
                              style: const TextStyle(color: Colors.white),
                            ),
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

  Widget otpBox(int index) {
    return Container(
      width: 50,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black54),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: const InputDecoration(counterText: "", border: InputBorder.none),
        onChanged: (value) {
          if (value.length == 1 && index < 4) {
            FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
          }
        },
      ),
    );
  }
}
