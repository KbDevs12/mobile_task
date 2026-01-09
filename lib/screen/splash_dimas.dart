import 'package:flutter/material.dart';
import 'package:tugas_mobile/screen/login_page.dart';

import 'package:flutter/material.dart';

class SplashDimas extends StatefulWidget {
  const SplashDimas({super.key});

  @override
  State<SplashDimas> createState() => _SplashDimasState();
}

class _SplashDimasState extends State<SplashDimas> with SingleTickerProviderStateMixin 
{
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard"), actions: const []),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: []),
      ),
    );
  }
}
