import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../controller/login_controller.dart';
import 'Congra_screen.dart';
import 'login_client_screen.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController newPassTextEditingController = TextEditingController();
  final TextEditingController confirmPassTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginController = Provider.of<LoginController>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final topPadding = MediaQuery.of(context).size.height * 0.25;
    final local = AppLocalizations.of(context)!;

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
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const LoginClientScreen()),
                              );
                            },
                            icon: const Icon(Icons.arrow_back_sharp),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            local.reset_password,
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                local.want_to_try_with_my_current_password,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: isDark ? Colors.white70 : Colors.black54,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => const LoginClientScreen()),
                                );
                              },
                              child: Text(
                                local.login,
                                style: const TextStyle(
                                  color: Color(0xFF0D47A1),
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: newPassTextEditingController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: local.new_password,
                            filled: true,
                            fillColor: isDark ? Colors.grey[850] : Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: confirmPassTextEditingController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: local.confirm_new_password,
                            filled: true,
                            fillColor: isDark ? Colors.grey[850] : Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            loginController.checkPassword(
                              password: newPassTextEditingController.text,
                              email: "placeholder@email.com",
                            );

                            if (newPassTextEditingController.text != confirmPassTextEditingController.text) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(local.passwords_do_not_match)),
                              );
                              return;
                            }

                            if (loginController.showErrorPassword) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(loginController.errorPasswordMessage)),
                              );
                              return;
                            }

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const CongraScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0D47A1),
                            minimumSize: const Size(double.infinity, 45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            local.update_password,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
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
}
