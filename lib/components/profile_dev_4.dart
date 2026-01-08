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
