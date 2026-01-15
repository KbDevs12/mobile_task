import 'package:flutter/material.dart';
import 'package:tugas_mobile/screen/detail_profil_adit.dart';
import 'package:tugas_mobile/screen/detail_profil_dimas.dart';
import 'package:tugas_mobile/widgets/gradient_app_bar.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(title: 'Profil Developer'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DetailProfilAdit(),
            const SizedBox(height: 24),
            DetailProfilDimas(),
          ],
        ),
      ),
    );
  }
}
