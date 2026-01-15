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
      backgroundColor: const Color(0xFF3CB371),
      body: Center(
        child: ScaleTransition(
          scale: _scale,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.sports, size: 100, color: Colors.white),
              const SizedBox(height: 20),
              const Text(
                "Manajement Atlet",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Kelola atlet Anda dengan mudah",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
