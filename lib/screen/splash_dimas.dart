import 'package:flutter/material.dart';
import 'package:tugas_mobile/screen/login_page.dart';

import 'package:flutter/material.dart';

class SplashDimas extends StatefulWidget {
  const SplashDimas({super.key});

  @override
  State SplashDimas> createState() =>  SplashDimasState();
}

class  SplashDimasState extends State SplashDimas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
            children: [],
        ),
      ),
    );
  }
}