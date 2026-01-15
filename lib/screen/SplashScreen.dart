import 'package:flutter/material.dart';
import 'package:tugas_mobile/screen/dashboard.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff991B1B), Color(0xff020617)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(34),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.35),
                    blurRadius: 30,
                    offset: const Offset(0, 16),
                  ),
                ],
              ),
              child: Icon(
                Icons.emoji_events_rounded,
                size: 90,
                color: Color(0xff991B1B),
              ),
            ),
            SizedBox(height: 36),
            Text(
              'SPORT APP',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: 3,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Manage Athletes & Sports Data',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white60,
                letterSpacing: 1,
              ),
            ),
            SizedBox(height: 70),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 10,
                    shadowColor: Colors.black.withOpacity(0.3),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Dashboard(),
                      ),
                    );
                  },
                  child: Text(
                    'GET STARTED',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
