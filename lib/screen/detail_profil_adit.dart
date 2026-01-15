import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tugas_mobile/screen/login_page.dart';

class DetailProfilAdit extends StatelessWidget {
  const DetailProfilAdit({super.key});

  void logout(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2193b0), Color(0xFF6dd5ed)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 🔙 BACK BUTTON
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              const SizedBox(height: 10),

              const CircleAvatar(
                radius: 55,
                backgroundImage: AssetImage('assets/images/image3.png'),
              ),
              const SizedBox(height: 12),
              const Text(
                'Aditya Putra Perdana',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Lead Developer & Project Manager',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 16),

              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'About',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text("NIM: 1123150159"),
                      const SizedBox(height: 10),
                      const Text("Kelas: TI SE 23 P 2"),
                      const SizedBox(height: 10),
                      const Text(
                        'Responsible for application UI consistency, '
                        'user experience, and design implementation '
                        'using Flutter best practices.',
                      ),
                      const SizedBox(height: 20),
                      const ListTile(
                        leading: Icon(Icons.palette),
                        title: Text('Speciality'),
                        subtitle: Text('Backend, API'),
                      ),
                      const ListTile(
                        leading: Icon(Icons.code),
                        title: Text('Tech Stack'),
                        subtitle: Text('Flutter, Dart, Firebase'),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          logout(context);
                        },
                        child: const Text('Logout'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
