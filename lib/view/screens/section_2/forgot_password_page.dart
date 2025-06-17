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
    final width = MediaQuery.of(context).size.width;

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
                            AppLocalizations.of(context)!.reset_password,
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
                            AppLocalizations.of(context)!.want_to_try_with_my_current_password,
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
                              AppLocalizations.of(context)!.login,
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
                          label: Text(AppLocalizations.of(context)!.new_password),
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
                          labelText: AppLocalizations.of(context)!.confirm_new_password,
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
                            email: "placeholder@email.com", // 💡 Email وهمي فقط
                          );

                          if (newPassTextEditingController.text != confirmPassTextEditingController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Passwords do not match")),
                            );
                            return;
                          }

                          if (loginController.showErrorPassword) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(loginController.errorPasswordMessage)),
                            );
                            return;
                          }

                          // ✅✅ هذا الجزء مؤقت، المفروض هون يتم استدعاء API لتحديث كلمة المرور
                          // await authService.resetPassword(...);
                          // إذا نجح، ننتقل لصفحة التهنئة
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
                          AppLocalizations.of(context)!.update_password,
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
