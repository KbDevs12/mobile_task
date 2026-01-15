import 'package:flutter/material.dart';
import 'package:tugas_mobile/components/profile_dev_1.dart';
import 'package:tugas_mobile/components/profile_dev_2.dart';
import 'package:tugas_mobile/components/profile_dev_3.dart';
import 'package:tugas_mobile/components/profile_dev_4.dart';

import 'package:tugas_mobile/widgets/gradient_app_bar.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(title: 'Profil Developer'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ProfileDev1(),
          SizedBox(height: 24),
          ProfileDev2(),
          SizedBox(height: 24),
          ProfileDev3(),
          SizedBox(height: 24),
          ProfileDev4(),
        ],
      ),
    );
  }
}
