import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:servana/view/screens/section_2/signup_worker_screen.dart';
import 'package:servana/view/screens/section_6/home_worker_screen.dart';
import '../../../controller/login_controller.dart';
import '../../../l10n/app_localizations.dart';
import '../../widgets/input_widget.dart';
import 'rest_password_screen.dart';

class LoginWorkerScreen extends StatefulWidget {
  const LoginWorkerScreen({super.key});

  @override
  State<LoginWorkerScreen> createState() => _LoginWorkerScreenState();
}

class _LoginWorkerScreenState extends State<LoginWorkerScreen> {
  final TextEditingController emailTextEditingController = TextEditingController();
  final TextEditingController passTextEditingController = TextEditingController();
  bool rememberMe = false;

  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _checkAutoLogin();
  }

  Future<void> _checkAutoLogin() async {
    String? remember = await secureStorage.read(key: 'rememberMe');
    String? userId = await secureStorage.read(key: 'userId');
    String? loginCountStr = await secureStorage.read(key: 'rememberLoginCount');
    int loginCount = int.tryParse(loginCountStr ?? '0') ?? 0;

    if (remember == 'true' && userId != null && loginCount < 2) {
      await secureStorage.write(key: 'rememberLoginCount', value: '${loginCount + 1}');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeWorkerScreen()),
      );
    }
  }

  Future<void> _saveCredentials(String email, String userId) async {
    if (rememberMe) {
      await secureStorage.write(key: 'rememberMe', value: 'true');
      await secureStorage.write(key: 'userId', value: userId);
      await secureStorage.write(key: 'email', value: email);
      await secureStorage.write(key: 'rememberLoginCount', value: '0');
    } else {
      await secureStorage.deleteAll();
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginController = Provider.of<LoginController>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final topPadding = constraints.maxHeight * 0.25;

          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/Servana_login.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: topPadding, left: 20, right: 20, bottom: 12),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey[900]!.withOpacity(0.85) : Colors.white.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
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
                        Text(
                          AppLocalizations.of(context)!.login,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.dont_have_an_account,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const SignupWorkerScreen()),
                                );
                              },
                              child: Text(
                                AppLocalizations.of(context)!.sign_up,
                                style: TextStyle(color: Colors.blue[900], fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Consumer<LoginController>(
                          builder: (context, loginController, child) {
                            return InputWidget(
                              obscureText: false,
                              textEditingController: emailTextEditingController,
                              label: AppLocalizations.of(context)!.email,
                              hintText: "worker@example.com",
                              errorText: loginController.showErrorEmail
                                  ? loginController.errorEmailMessage
                                  : null,
                            );
                          },
                        ),
                        const SizedBox(height: 15),
                        Consumer<LoginController>(
                          builder: (context, loginController, child) {
                            return TextFormField(
                              controller: passTextEditingController,
                              obscureText: loginController.obscureTextPassword,
                              decoration: InputDecoration(
                                fillColor: isDark ? Colors.grey[800] : Colors.white,
                                labelText: AppLocalizations.of(context)!.password,
                                labelStyle: TextStyle(color: isDark ? Colors.white : null),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                suffixIcon: IconButton(
                                  onPressed: () => loginController.changeObscureTextPassword(),
                                  icon: Icon(
                                    loginController.obscureTextPassword ? Icons.visibility : Icons.visibility_off,
                                    color: isDark ? Colors.white : null,
                                  ),
                                ),
                                errorText: loginController.showErrorPassword
                                    ? loginController.errorPasswordMessage
                                    : null,
                              ),
                              style: TextStyle(color: isDark ? Colors.white : Colors.black),
                            );
                          },
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: Checkbox(
                                    value: rememberMe,
                                    onChanged: (value) {
                                      setState(() {
                                        rememberMe = value!;
                                      });
                                    },
                                    activeColor: Colors.blue[900],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  AppLocalizations.of(context)!.remember_me,
                                  style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 14),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>  ResetPasswordScreen()),
                                );
                              },
                              child: Text(
                                AppLocalizations.of(context)!.forgot_password,
                                style: TextStyle(color: Colors.blue[900], fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            if (emailTextEditingController.text.isEmpty ||
                                passTextEditingController.text.isEmpty) {
                              loginController.showCustomEmailError(
                                AppLocalizations.of(context)!.please_enter_email_and_password,
                              );
                              return;
                            }

                            loginController.checkEmail(email: emailTextEditingController.text);
                            loginController.checkPassword(
                              password: passTextEditingController.text,
                              email: emailTextEditingController.text,
                            );

                            if (loginController.showErrorEmail || loginController.showErrorPassword) return;

                            await _saveCredentials(emailTextEditingController.text, "user_id_123");
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const HomeWorkerScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[900],
                            minimumSize: const Size(double.infinity, 45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.login,
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
          );
        },
      ),
    );
  }
}
