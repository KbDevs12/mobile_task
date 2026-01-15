import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import './login_page.dart';
import "./dashboard.dart";

class SplashScreens extends StatefulWidget {
  const SplashScreens({super.key});

  @override
  State<SplashScreens> createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {
  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  void _checkLogin() async {
    await Future.delayed(const Duration(seconds: 2));
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.pushReplacement(
        mounted ? context : throw Exception("Context is not mounted"),
        MaterialPageRoute(builder: (_) => const Dashboard()),
      );
    } else {
      Navigator.pushReplacement(
        mounted ? context : throw Exception("Context is not mounted"),
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage("assets/logo.png"),
              width: 150,
              height: 150,
            ),
            SizedBox(height: 16),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
