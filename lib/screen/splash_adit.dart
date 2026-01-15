import 'dart:async';
import 'package:flutter/material.dart';
import './splash_dimas.dart';

class SplashAdit extends StatefulWidget {
  const SplashAdit({super.key});

  @override
  State<SplashAdit> createState() => _SplashAditState();
}

class _SplashAditState extends State<SplashAdit>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scale = CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);

    _controller.forward();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SplashDimas()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    )
  }
}
