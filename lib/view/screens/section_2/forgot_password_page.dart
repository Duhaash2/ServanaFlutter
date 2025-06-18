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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[900] : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginClientScreen(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.arrow_back_sharp),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            local.reset_password,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            local.want_to_try_with_my_current_password,
                            style: TextStyle(
                              fontSize: 10,
                              color: isDark ? Colors.white70 : Colors.black54,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginClientScreen(),
                                ),
                              );
                            },
                            child: Text(
                              local.login,
                              style: TextStyle(
                                color: Colors.blue[900],
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: newPassTextEditingController,
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          label: Text(local.new_password),
                          fillColor: isDark ? Colors.grey[850] : Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: confirmPassTextEditingController,
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: isDark ? Colors.grey[850] : Colors.white,
                          labelText: local.confirm_new_password,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
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
                            MaterialPageRoute(builder: (context) => const CongraScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[900],
                          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          local.update_password,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
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
