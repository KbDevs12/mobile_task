import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Atlet'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ringkasan Olahraga',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildInfoCard(
                  title: 'Atlet',
                  value: '120',
                  icon: Icons.people,
                  color: Colors.blue,
                ),
                const SizedBox(width: 12),
                _buildInfoCard(
                  title: 'Cabang',
                  value: '8',
                  icon: Icons.sports,
                  color: Colors.orange,
                ),
              ],
            ),
            const SizedBox(height: 20),

            const Text(
              'Cabang Olahraga',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            const Text(
              'Cabang Olahraga',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView(
                children: const [
                  SportTile(name: 'Sepak Bola', icon: Icons.sports_soccer),
                  SportTile(name: 'Bulu Tangkis', icon: Icons.sports_tennis),
                  SportTile(name: 'Basket', icon: Icons.sports_basketball),
                  SportTile(name: 'Renang', icon: Icons.pool),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget Info Card (ShortCard)
Widget _buildInfoCard({
  required String title,
  required String value,
  required IconData icon,
  required Color color,
}) {
  return Expanded(
    child: Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 36, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(title),
          ],
        ),
      ),
    ),
  );
}

class SportTile extends StatelessWidget {
  final String name;
  final IconData icon;

  const SportTile({super.key, required this.name, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.green),
        title: Text(name),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // nanti arahkan ke list atlet per cabang
        },
      ),
    );
  }
}
