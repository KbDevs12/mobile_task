import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.teal.shade100,
            child: const Icon(Icons.person, size: 60, color: Colors.teal),
          ),
          SizedBox(height: 12),
          Text(
            'Dava Ananda',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text('Admin Atlet', style: TextStyle(color: Colors.grey[600])),
          SizedBox(height: 20),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.email),
                  title: Text('Email'),
                  subtitle: Text('dava@email.com'),
                ),
                Divider(height: 0),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('No. HP'),
                  subtitle: Text('0812-3456-7890'),
                ),
                Divider(height: 0),
                ListTile(
                  leading: Icon(Icons.badge),
                  title: Text('Role'),
                  subtitle: Text('Administrator'),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logout berhasil')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
