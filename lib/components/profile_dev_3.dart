import 'package:flutter/material.dart';
import 'package:tugas_mobile/screen/biodata_dava.dart';

class ProfileDev3 extends StatelessWidget {
  const ProfileDev3({super.key});

  @override
  Widget build(BuildContext context) {
    return _ProfileLayout(
      context,
      name: 'Dava Ananda',
      role: 'UI/UX & Frontend Developer',
      email: 'dava@email.com',
      phone: '0812-3333-4444',
      imagePath: 'assets/images/dava.jpg',
      description:
          'Mengembangkan antarmuka aplikasi Flutter, memastikan tampilan '
          'responsif, konsisten, dan mudah digunakan.',
    );
  }
}

Widget _ProfileLayout(
  BuildContext context, {
  required String name,
  required String role,
  required String email,
  required String phone,
  required String imagePath,
  required String description,
}) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        CircleAvatar(radius: 55, backgroundImage: AssetImage(imagePath)),
        const SizedBox(height: 12),
        Text(
          name,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          role,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
        ),
        const SizedBox(height: 16),
        Text(description, textAlign: TextAlign.center),
        const SizedBox(height: 20),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BiodataDava()),
            );
          },
          child: Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.email),
                  title: const Text('Email'),
                  subtitle: Text(email),
                ),
                const Divider(height: 0),
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: const Text('No. HP'),
                  subtitle: Text(phone),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
