import 'package:flutter/material.dart';

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
      imagePath: 'assets/images/fajri.jpg',
      description:
          'Bertanggung jawab atas integrasi Firebase, autentikasi pengguna, '
          'serta pengelolaan database Firestore.',
    );
  }
}