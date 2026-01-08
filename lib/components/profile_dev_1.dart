import 'package:flutter/material.dart';

class ProfileDev1 extends StatelessWidget {
  const ProfileDev1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Developer')),
      body: SingleChildScrollView(
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
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Bertanggung jawab atas perancangan sistem, '
                  'koordinasi tim, serta pengambilan keputusan teknis '
                  'pada aplikasi Atlet Manager.',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
