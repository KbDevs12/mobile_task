import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'providers/atlet_provider.dart';
import 'providers/pelatih_provider.dart';
import 'providers/cabang_olahraga_provider.dart'; // Import CabangOlahragaProvider
import 'screen/login_page.dart';
import 'screen/main_screen.dart';
import 'screen/profile.dart';
import 'screen/splash_screen.dart';
import 'views/add_edit_atlet_screen.dart';
import 'views/atlet_list_screen.dart';
import 'views/cabang_olahraga_list_screen.dart';
import 'views/pelatih_list_screen.dart';
import 'views/add_edit_pelatih_screen.dart';
import 'views/add_edit_cabang_olahraga_screen.dart'; // Import AddEditCabangOlahragaScreen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<void> _initFCM() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission for notifications');

      String? token = await messaging.getToken();
      debugPrint('FCM Token: $token');

      if (token != null) {
        await _saveTokenToFirestore(token);
      }

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        debugPrint('Received a message while in the foreground!');
        debugPrint('Message data: ${message.data}');

        if (message.notification != null) {
          debugPrint(
            'Message also contained a notification: ${message.notification}',
          );
        }
      });
    } else {
      debugPrint(
        'User declined or has not accepted permission for notifications',
      );
    }
  }

  Future<void> _saveTokenToFirestore(String token) async {
    final firestore = FirebaseFirestore.instance;

    await firestore.collection('fcm_tokens').doc(token).set({
      'token': token,
      'platform': Platform.isAndroid ? 'android' : 'ios',
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    debugPrint('FCM Token saved to Firestore');
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AtletProvider()),
        ChangeNotifierProvider(create: (context) => PelatihProvider()),
        ChangeNotifierProvider(
          create: (context) => CabangOlahragaProvider(),
        ), // Add CabangOlahragaProvider
      ],
      child: MaterialApp(
        title: 'Sistem Informasi Atlet',
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: GoogleFonts.poppins().fontFamily,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF3CB371),
            brightness: Brightness.light,
            primary: const Color(0xFF3CB371),
            surface: Colors.grey[50],
            onSurface: Colors.grey[800],
          ),
          scaffoldBackgroundColor: Colors.grey[50],
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: Colors.black87,
            surfaceTintColor: Colors.transparent,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            selectedItemColor: const Color(0xFF3CB371),
            unselectedItemColor: Colors.grey[500],
            elevation: 10,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
          ),
          cardTheme: CardThemeData(
            elevation: 8,
            shadowColor: Colors.black.withOpacity(0.08),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          ),
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
            },
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/login': (context) => const LoginPage(),
          '/main': (context) => const MainScreen(),
          '/atlet-list': (context) => const AtletListScreen(),
          '/pelatih-list': (context) => const PelatihListScreen(),
          '/cabang-olahraga-list': (context) =>
              const CabangOlahragaListScreen(),
          '/add-atlet': (context) => const AddEditAtletScreen(),
          '/add-pelatih': (context) => const AddEditPelatihScreen(),
          '/add-cabang-olahraga': (context) =>
              const AddEditCabangOlahragaScreen(), // New route for adding/editing Cabang Olahraga
          '/profile': (context) => const Profile(),
        },
      ),
    );
  }
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  debugPrint('Handling a background message: ${message.messageId}');
}
