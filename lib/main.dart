import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:servana/firebase_options.dart';
import 'package:servana/service/auth/authentication_service.dart';
import 'package:servana/view/screens/section_1/splash_screen.dart';
import 'package:servana/view/screens/section_5/client_notification_screen.dart';
import 'package:servana/view/screens/section_6/worker_notification_screen.dart';
import 'controller/lang_controller.dart';
import 'controller/login_controller.dart';
import 'controller/profile_controller.dart';
import 'controller/signup_controller.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import '../../../l10n/app_localizations.dart';

// ✅ Override SSL for development
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

// ✅ Background handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("🔔 Background message: ${message.messageId}");
}

// 🔔 Local notifications plugin
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

// 🔔 Store notifications (replace with Provider later)
final List<RemoteMessage> notificationMessages = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initSettings = InitializationSettings(android: androidSettings);
  await flutterLocalNotificationsPlugin.initialize(initSettings);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: themeProvider),
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => SignUpController()),
        ChangeNotifierProvider(create: (_) => AuthenticationService()),
        ChangeNotifierProvider(create: (_) => LangController()),
        ChangeNotifierProvider(create: (_) => ProfileController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _initFirebaseMessaging();
  }

  void _initFirebaseMessaging() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print("📲 Firebase Token: $token");

    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    print('🔐 Permission granted: ${settings.authorizationStatus}');

    // ✅ Handle cold start (terminated)
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      notificationMessages.add(initialMessage);
      _navigateToNotificationScreen();
    }

    // ✅ Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      notificationMessages.add(message);
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              'servana_channel',
              'Servana Notifications',
              importance: Importance.max,
              priority: Priority.high,
              showWhen: true,
              icon: '@mipmap/ic_launcher',
            ),
          ),
        );
      }
    });

    // ✅ Background → resume
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      notificationMessages.add(message);
      _navigateToNotificationScreen();
    });
  }
//do it tommorrowowoowowowowoowowooototottootto -_-
  void _navigateToNotificationScreen() {
    bool isWorker = true; // Replace with actual logic
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => isWorker
            ? WorkerNotificationScreen(fcmMessages: notificationMessages)
            : ClientNotificationScreen(fcmMessages: notificationMessages),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<LangController, ThemeProvider>(
      builder: (context, langController, themeProvider, child) {
        return MaterialApp(
          title: 'Servana',
          debugShowCheckedModeBanner: false,
          locale: langController.locale,
          supportedLocales: const [Locale('en'), Locale('ar')],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          home:  SplashScreen(),
        );
      },
    );
  }
}
