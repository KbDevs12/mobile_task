import 'package:flutter/material.dart';

class DetailProfilFajri extends StatelessWidget {
  const DetailProfilFajri({super.key});

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
              child: Icon(Icons.person, size: 60, color: Colors.white),
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
          ],
        ),
      ),
    );
  }
}
