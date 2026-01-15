import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugas_mobile/screen/splash_adit.dart';

import 'firebase_options.dart';

const Color primaryBlue = Color(0xFF2563EB);
const Color primaryCyan = Color(0xFF06B6D4);
const Color secondaryWhite = Color(0xFFFFFFFF);
const Color softGrey = Color(0xFFF3F4F6);
const Color darkGreyText = Color(0xFF111827);

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
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
    _initFCM();
    _listenTokenRefresh();
    _setupFCMListeners();
  }

  Future<void> _initFCM() async {
    final messaging = FirebaseMessaging.instance;

    final settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      final token = await messaging.getToken();
      debugPrint('✅ FCM Token: $token');

      if (token != null) {
        await _saveTokenToFirestore(token);
      }
    }
  }

  Future<void> _saveTokenToFirestore(String token) async {
    await FirebaseFirestore.instance.collection('fcm_tokens').doc(token).set({
      'token': token,
      'platform': Platform.isAndroid ? 'android' : 'ios',
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  void _listenTokenRefresh() {
    FirebaseMessaging.instance.onTokenRefresh.listen((token) async {
      await _saveTokenToFirestore(token);
    });
  }

  void _setupFCMListeners() {
    FirebaseMessaging.onMessage.listen((message) {
      debugPrint(
        '📩 Foreground notification: '
        '${message.notification?.title}',
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      navigatorKey.currentState?.pushNamed('/main');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Atlet Manager',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryBlue),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),

      initialRoute: '/splash',
      routes: {'/splash': (_) => const SplashAdit()},
    );
  }
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  debugPrint('🔕 Background message: ${message.messageId}');
}
