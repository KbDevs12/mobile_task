import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:atlet_manager/screen/login_page.dart';

class DetailProfilFajri extends StatelessWidget {
  const DetailProfilFajri({super.key});

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
      appBar: AppBar(
        title: const Text('Profil Developer'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.teal,
              child: Image(image: AssetImage('assets/images/fajri.png')),
            ),
            const SizedBox(height: 16),
            const Text(
              'Fajri Khaerullah',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              'Backend & Firebase Engineer',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: const [
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text('Email'),
                    subtitle: Text('fajrikhaerullah22@gmail.com'),
                  ),
                  Divider(height: 0),
                  ListTile(
                    leading: Icon(Icons.storage),
                    title: Text('Expertise'),
                    subtitle: Text('Firebase, REST API, Auth'),
                  ),
                  Divider(height: 0),
                  ListTile(
                    leading: Icon(Icons.security),
                    title: Text('Role'),
                    subtitle: Text('Backend & Firebase Engineer'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                logout(context);
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
