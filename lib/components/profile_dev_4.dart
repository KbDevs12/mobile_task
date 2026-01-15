import 'package:flutter/material.dart';

class ProfileDev4 extends StatelessWidget {
  const ProfileDev4({super.key});

  @override
  Widget build(BuildContext context) {
    return _ProfileLayout(
      context,
      name: 'Dimas Prasetyo',
      role: 'Project Manager & System Analyst',
      email: 'dimas@email.com',
      phone: '0812-5555-6666',
      imagePath: 'assets/images/dimas.jpg',
      description:
          'Mengatur alur pengembangan aplikasi, menganalisis kebutuhan sistem, '
          'dan memastikan project berjalan sesuai rencana.',
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
        Card(
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
      ],
    ),
  );
}
