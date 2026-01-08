import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryBlue = Color(0xFF2563EB);
const Color primaryCyan = Color(0xFF06B6D4);
const Color secondaryWhite = Color(0xFFFFFFFF);
const Color softGrey = Color(0xFFF3F4F6);
const Color darkGreyText = Color(0xFF111827);

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  ThemeData _buildLightTheme(BuildContext context) {
    final base = ThemeData.light();
    return base.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryBlue,
        primary: primaryBlue,
        secondary: primaryCyan,
        background: softGrey,
        onBackground: darkGreyText,
        surface: secondaryWhite,
        onSurface: darkGreyText,
      ),
      scaffoldBackgroundColor: softGrey,
      appBarTheme: AppBarTheme(
        // AppBar will use a custom gradient, so background color here is just fallback
        backgroundColor: primaryBlue,
        foregroundColor: secondaryWhite,
        elevation: 0, // Gradient will provide depth
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: secondaryWhite,
            fontSize: 20,
            fontWeight: FontWeight.bold, // Heading: SemiBold – Bold
          ),
        ),
      ),
      textTheme: GoogleFonts.poppinsTextTheme(base.textTheme).copyWith(
        // Heading: SemiBold – Bold (already set in appBarTheme for title)
        // Body: Regular – Medium
        bodyLarge: GoogleFonts.poppins(
          textStyle: const TextStyle(color: darkGreyText, fontSize: 16),
        ),
        bodyMedium: GoogleFonts.poppins(
          textStyle: const TextStyle(color: darkGreyText, fontSize: 14),
        ),
        bodySmall: GoogleFonts.poppins(
          textStyle: const TextStyle(color: darkGreyText, fontSize: 12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: secondaryWhite,
          backgroundColor:
              primaryBlue, // Default, will be overridden by gradient
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Rounded input/button
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          elevation: 4, // Subtle shadow for buttons
        ),
      ),
      cardTheme: CardThemeData(
        color: secondaryWhite,
        elevation: 4, // Subtle shadow (3D depth)
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Rounded corners for cards
        ),
        margin: const EdgeInsets.all(8), // Consistent padding
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: secondaryWhite,
        selectedLabelStyle: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        elevation: 8, // Material 3 style elevation
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: softGrey.withOpacity(0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none, // No border for clean look
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: primaryBlue,
            width: 2,
          ), // Highlight focused input
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        labelStyle: GoogleFonts.poppins(color: darkGreyText.withOpacity(0.7)),
        hintStyle: GoogleFonts.poppins(color: darkGreyText.withOpacity(0.5)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    );
  }

  ThemeData _buildDarkTheme(BuildContext context) {
    final base = ThemeData.dark();
    return base.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryBlue,
        primary: primaryCyan, // Use Cyan as primary for dark mode
        secondary: primaryBlue,
        background: const Color(0xFF121212), // Dark background
        onBackground: secondaryWhite,
        surface: const Color(0xFF1E1E1E), // Dark surface
        onSurface: secondaryWhite,
      ),
      scaffoldBackgroundColor: const Color(0xFF121212),
      appBarTheme: base.appBarTheme.copyWith(
        backgroundColor: const Color(0xFF1E1E1E),
        foregroundColor: secondaryWhite,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: secondaryWhite,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      textTheme: GoogleFonts.poppinsTextTheme(base.textTheme).copyWith(
        bodyLarge: GoogleFonts.poppins(
          textStyle: const TextStyle(color: secondaryWhite, fontSize: 16),
        ),
        bodyMedium: GoogleFonts.poppins(
          textStyle: const TextStyle(color: secondaryWhite, fontSize: 14),
        ),
        bodySmall: GoogleFonts.poppins(
          textStyle: const TextStyle(color: secondaryWhite, fontSize: 12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor:
              primaryBlue, // Use primary Blue for text on dark buttons
          backgroundColor:
              primaryCyan, // Use Cyan as background for dark buttons
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          elevation: 4,
        ),
      ),
      cardTheme: base.cardTheme.copyWith(
        color: const Color(0xFF1E1E1E),
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.all(8),
      ),
      bottomNavigationBarTheme: base.bottomNavigationBarTheme.copyWith(
        backgroundColor: const Color(0xFF1E1E1E),
        selectedItemColor: primaryCyan, // Highlight with Cyan
        unselectedItemColor: secondaryWhite.withOpacity(0.6),
        selectedLabelStyle: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        elevation: 8,
      ),
      inputDecorationTheme: base.inputDecorationTheme.copyWith(
        filled: true,
        fillColor: const Color(0xFF2C2C2C),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryCyan, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        labelStyle: GoogleFonts.poppins(color: secondaryWhite.withOpacity(0.7)),
        hintStyle: GoogleFonts.poppins(color: secondaryWhite.withOpacity(0.5)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    );
  }

  @override
  void initState() {
    _initFCM();
    _listenTokenRefresh();
    _setupFCMListeners();
  }

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

  void _listenTokenRefresh() {
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      debugPrint('🔄 FCM Token refreshed: $newToken');
      await _saveTokenToFirestore(newToken);
    });
  }

  void _setupFCMListeners() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Foreground message');
      debugPrint('Title: ${message.notification?.title}');
      debugPrint('Body: ${message.notification?.body}');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('👉 Notification clicked');
      navigatorKey.currentState?.pushNamed('/main');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Atlet Manager',
      theme: _buildLightTheme(context),
      darkTheme: _buildDarkTheme(context),
      themeMode: ThemeMode.system,
      initialRoute: '/splash',
    );
  }
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  debugPrint('Handling a background message: ${message.messageId}');
}
