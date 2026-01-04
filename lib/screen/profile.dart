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
        ],
      ),
    );
  }
}
