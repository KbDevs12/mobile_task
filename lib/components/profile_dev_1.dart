import 'package:flutter/material.dart';
import 'package:atlet_manager/screen/detail_profil_adit.dart';

class ProfileDev1 extends StatelessWidget {
  const ProfileDev1({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage('assets/images/image3.png'),
          ),
          const SizedBox(height: 16),
          Text(
            'Aditya Putra Perdana',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            'Lead Developer & Project Manager',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          InkWell(
            child: Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: const Text('Email'),
                    subtitle: Text('1123150159@gmail.com'),
                  ),
                  const Divider(height: 0),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: const Text('No. HP'),
                    subtitle: Text('0857-1234-5678'),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DetailProfilAdit(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
