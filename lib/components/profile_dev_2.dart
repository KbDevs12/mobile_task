import 'package:flutter/material.dart';
import '../screen/detail_profil_fajri.dart';

class ProfileDev2 extends StatelessWidget {
  const ProfileDev2({super.key});

  @override
  Widget build(BuildContext context) {
    return _ProfileLayout(
      context,
      name: 'Fajri Khaerullah',
      role: 'Backend & Firebase Developer',
      email: 'fajrisantuy23@gmail.com',
      phone: '0855-4527-3945',
      imagePath: 'assets/images/fajri.png',
      description:
          'Bertanggung jawab atas integrasi Firebase, autentikasi pengguna, '
          'serta pengelolaan database Firestore.',
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
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DetailProfilFajri(),
              ),
            ),
          },
        ),
      ],
    ),
  );
}
