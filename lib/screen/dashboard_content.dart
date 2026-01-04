import 'package:flutter/material.dart';
import '../widgets/info_card.dart';
import '../widgets/sport_tile.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InfoCard(
                  title: 'Total Atlet',
                  value: totalAtlet.toString(),
                  icon: Icons.people,
                  color: Colors.green,
                ),
                const SizedBox(width: 12),
                InfoCard(
                  title: 'Total Pelatih',
                  value: totalPelatih.toString(),
                  icon: Icons.person,
                  color: Colors.blue,
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Cabang Olahraga',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
