import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'package:servana/view/screens/section_5/payment_screen.dart';


import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

import 'controller/lang_controller.dart';
import 'controller/login_controller.dart';
import 'controller/profile_controller.dart';
import 'controller/signup_controller.dart';
import 'controller/notification_controller.dart';
import 'service/auth/authentication_service.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';

import 'view/screens/section_1/splash_screen.dart';
import 'view/screens/section_5/client_notification_screen.dart';
import 'view/screens/section_6/worker_notification_screen.dart';
import 'view/screens/section_5/start_work_screen.dart';

import '../l10n/app_localizations.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("🔔 Background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
  const initSettings = InitializationSettings(android: androidSettings);
  await flutterLocalNotificationsPlugin.initialize(initSettings);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: themeProvider),
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => SignUpController()),
        ChangeNotifierProvider(create: (_) => AuthenticationService()),
        ChangeNotifierProvider(create: (_) => LangController()),
        ChangeNotifierProvider(create: (_) => ProfileController()),
        ChangeNotifierProvider(create: (_) => NotificationController()),
      ],
      child: MyApp(isFirstTime: isFirstTime),
    ),
  );
}

class MyApp extends StatefulWidget {
  final bool isFirstTime;
  const MyApp({super.key, required this.isFirstTime});

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

    await FirebaseMessaging.instance.requestPermission(alert: true, badge: true, sound: true);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("📩 Foreground: ${message.data}");
      _handleIncomingMessage(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("🔁 OpenedApp: ${message.data}");
      _handleIncomingMessage(message, openScreen: true);
    });

    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      print("🟢 Initial Message: ${initialMessage.data}");
      _handleIncomingMessage(initialMessage, openScreen: true);
    }
  }

  void _handleIncomingMessage(RemoteMessage message, {bool openScreen = false}) {
    final notificationController = Provider.of<NotificationController>(context, listen: false);
    notificationController.addMessage(message);

    final notification = message.notification;
    final android = message.notification?.android;

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

    if (openScreen) {
      _navigateToNotificationScreen();
    }
  }

  void _navigateToNotificationScreen() {
    bool isWorker = false; // 🔄 بدّلها حسب نوع المستخدم من SharedPreferences أو Provider
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => isWorker
            ? const WorkerNotificationScreen()
            : const ClientNotificationScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<LangController, ThemeProvider>(
      builder: (context, langController, themeProvider, _) {
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

     //    home: PaymentScreen(),


          home: const SplashScreen(), // 🔁 Splash أولاً دائماً
        );
      },
    );
  }
}
