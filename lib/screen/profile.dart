import 'package:flutter/material.dart';
import 'biodata_dava.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Anggota Kelompok')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _MemberCard(
            name: 'Dava Ananda',
            nim: '1123150164',
            role: 'Anggota 1',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BiodataDava()),
              );
            },
          ),
          const _MemberCard(
            name: 'Fajri Khaerullah',
            nim: '1123150166',
            role: 'Anggota 2',
          ),
          const _MemberCard(name: 'Adit', nim: '1123150167', role: 'Anggota 3'),
          const _MemberCard(
            name: 'Dimas',
            nim: '1123150168',
            role: 'Anggota 4',
          ),
        ],
      ),
    );
  }
}

class _MemberCard extends StatelessWidget {
  final String name;
  final String nim;
  final String role;
  final VoidCallback? onTap;

  const _MemberCard({
    required this.name,
    required this.nim,
    required this.role,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: Colors.teal.shade100,
          child: const Icon(Icons.person, color: Colors.teal),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('NIM: $nim\n$role'),
        trailing: onTap != null
            ? const Icon(Icons.arrow_forward_ios, size: 16)
            : null,
      ),
    );
  }
}
