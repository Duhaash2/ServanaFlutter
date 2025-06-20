import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/auth_model/reset_password_model.dart';
import '../../../service/auth/authentication_service.dart';
import 'login_client_screen.dart';
import 'otp_screen.dart';
import '../../../l10n/app_localizations.dart';

class ResetPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final topPadding = MediaQuery.of(context).size.height * 0.3;

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
          // 🔹 النموذج
          Positioned.fill(
            top: topPadding,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 450),
                  child: Consumer<AuthenticationService>(
                    builder: (context, authService, child) {
                      return Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: isDark
                              ? Theme.of(context).cardColor.withOpacity(0.95)
                              : Colors.white.withOpacity(0.88),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            if (!isDark)
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (_) => LoginClientScreen()),
                                );
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.arrow_back,
                                    color: isDark ? Colors.white70 : Colors.black54,
                                  ),
                                  const SizedBox(width: 5),
                                  RichText(
                                    text: TextSpan(
                                      text: AppLocalizations.of(context)!.back_to,
                                      style: TextStyle(
                                        color: isDark ? Colors.white70 : Colors.black54,
                                      ),
                                      children: <TextSpan>[
                                        const TextSpan(text: " "),
                                        const TextSpan(
                                          text: "Login",
                                          style: TextStyle(color: Color(0xFF0D47A1)),
                                        ),
                                        const TextSpan(text: " Page"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              AppLocalizations.of(context)!.reset_password,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              AppLocalizations.of(context)!
                                  .enter_your_email_or_phone_and_we_will_send_you_a_link_to_get_back_into_your_account,
                              style: TextStyle(
                                color: isDark ? Colors.white70 : Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: AppLocalizations.of(context)!.email,
                                filled: true,
                                fillColor: isDark ? Colors.grey[850] : Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              height: 45,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF0D47A1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onPressed: () async {
                                  final email = emailController.text.trim();

                                  if (email.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Please enter your email'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                    return;
                                  }

                                  // ✅ اتصال API معطّل مؤقتًا
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => OTPScreen(email: email),
                                    ),
                                  );
                                },
                                child: authService.isLoading
                                    ? const CircularProgressIndicator(color: Colors.white)
                                    : Text(
                                  AppLocalizations.of(context)!.btn_send,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
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
