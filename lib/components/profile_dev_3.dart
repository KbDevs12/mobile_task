import 'package:flutter/material.dart';

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
