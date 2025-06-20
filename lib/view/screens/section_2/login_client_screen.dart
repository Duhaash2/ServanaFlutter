import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import '../../../controller/login_controller.dart';
import '../../../model/auth_model/sign_model.dart';
import '../../../service/auth/authentication_service.dart';
import '../../../l10n/app_localizations.dart';
import '../../widgets/input_widget.dart';
import '../section_2/rest_password_screen.dart';
import '../section_2/signup_client_screen.dart';
import '../section_3/home_client_screen.dart';

class LoginClientScreen extends StatefulWidget {
  const LoginClientScreen({super.key});

  @override
  State<LoginClientScreen> createState() => _LoginClientScreenState();
}

class _LoginClientScreenState extends State<LoginClientScreen> {
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passTextEditingController =
      TextEditingController();
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
      await secureStorage.write(
        key: 'rememberLoginCount',
        value: '${loginCount + 1}',
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
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
    final topPadding = MediaQuery.of(context).size.height * 0.25;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/Servana_login.png",
              fit: BoxFit.cover,
            ),
          ),
          if (isDark)
            Positioned.fill(
              child: Container(color: Colors.black.withOpacity(0.4)),
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
                      color:
                          isDark
                              ? Colors.grey[900]!.withOpacity(0.85)
                              : Colors.white.withOpacity(0.88),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.login,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0D47A1),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(
                                context,
                              )!.dont_have_an_account,
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium!.copyWith(fontSize: 15),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignUpScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                AppLocalizations.of(context)!.sign_up,
                                style: const TextStyle(
                                  color: Color(0xFF0D47A1),
                                  fontSize: 15,
                                ),
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
                              hintText: "you@example.com",
                              errorText:
                                  loginController.showErrorEmail
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
                                labelText:
                                    AppLocalizations.of(context)!.password,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                suffixIcon: IconButton(
                                  onPressed:
                                      () =>
                                          loginController
                                              .changeObscureTextPassword(),
                                  icon: Icon(
                                    loginController.obscureTextPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                ),
                                errorText:
                                    loginController.showErrorPassword
                                        ? loginController.errorPasswordMessage
                                        : null,
                              ),
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
                                    activeColor: const Color(0xFF0D47A1),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  AppLocalizations.of(context)!.remember_me,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ResetPasswordScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                AppLocalizations.of(context)!.forgot_password,
                                style: const TextStyle(
                                  color: Color(0xFF0D47A1),
                                  fontSize: 14,
                                ),
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
                                AppLocalizations.of(
                                  context,
                                )!.please_enter_email_and_password,
                              );
                              return;
                            }

                            loginController.checkEmail(
                              email: emailTextEditingController.text,
                            );
                            loginController.checkPassword(
                              password: passTextEditingController.text,
                              email: emailTextEditingController.text,
                            );

                            if (loginController.showErrorEmail ||
                                loginController.showErrorPassword)
                              return;

                            // ✅✅ تم تعطيل الكود الأصلي لتسجيل الدخول مؤقتًا لتجربة الواجهة بدون تحقق من السيرفر:
                            /*
                            Sign_Model signModel = Sign_Model(
                              email: emailTextEditingController.text,
                              password: passTextEditingController.text,
                            );

                            final authService = AuthenticationService();
                            bool success = await authService.login(signModel);

                            if (success) {
                              await _saveCredentials(emailTextEditingController.text, "user_id_123");
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => HomeScreen()),
                              );
                            } else {
                              loginController.showCustomEmailError("Login failed. Please check your credentials.");
                            }
                            */

                            // ✅ تسجيل دخول وهمي بدون تحقق
                            await _saveCredentials(
                              emailTextEditingController.text,
                              "user_id_123",
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
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
          ),
        ],
      ),
    );
  }
}
