import 'package:flutter/material.dart';
import '../widgets/info_card.dart';
import '../widgets/sport_tile.dart';

class DashboardContent extends StatefulWidget {
  const DashboardContent({super.key});

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
  String? expandedSport;

  final Map<String, Map<String, String>> sportData = {
    'Sepak Bola': {'atlet': '22', 'pelatih': '4'},
    'Basket': {'atlet': '15', 'pelatih': '2'},
    'Bulu Tangkis': {'atlet': '10', 'pelatih': '3'},
    'Dayung': {'atlet': '12', 'pelatih': '2'},
  };

  int get totalAtlet =>
      sportData.values.fold(0, (sum, e) => sum + int.parse(e['atlet']!));

  int get totalPelatih =>
      sportData.values.fold(0, (sum, e) => sum + int.parse(e['pelatih']!));

  Widget _buildExpandedCard(String sport) {
    final data = sportData[sport]!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          InfoCard(
            title: 'Atlet',
            value: data['atlet']!,
            icon: Icons.people,
            color: Colors.green,
          ),
          const SizedBox(width: 12),

          InfoCard(
            title: 'Pelatih',
            value: data['pelatih']!,
            icon: Icons.person,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }

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
                SizedBox(width: 12),
                InfoCard(
                  title: 'Total Pelatih',
                  value: totalPelatih.toString(),
                  icon: Icons.person,
                  color: Colors.blue,
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Cabang Olahraga',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SportTile(
              name: 'Sepak Bola',
              icon: Icons.sports_soccer,
              onTap: () {
                setState(() {
                  expandedSport = expandedSport == 'Sepak Bola'
                      ? null
                      : 'Sepak Bola';
                });
              },
            ),
            if (expandedSport == 'Sepak Bola') _buildExpandedCard('Sepak Bola'),

            SportTile(
              name: 'Basket',
              icon: Icons.sports_basketball,
              onTap: () {
                setState(() {
                  expandedSport = expandedSport == 'Basket' ? null : 'Basket';
                });
              },
            ),
            if (expandedSport == 'Basket') _buildExpandedCard('Basket'),

            SportTile(
              name: 'Bulu Tangkis',
              icon: Icons.sports_tennis,
              onTap: () {
                setState(() {
                  expandedSport = expandedSport == 'Bulu Tangkis'
                      ? null
                      : 'Bulu Tangkis';
                });
              },
            ),
            if (expandedSport == 'Bulu Tangkis')
              _buildExpandedCard('Bulu Tangkis'),

            SportTile(
              name: 'Dayung',
              icon: Icons.rowing, // icon dayung
              onTap: () {
                setState(() {
                  expandedSport = expandedSport == 'Dayung' ? null : 'Dayung';
                });
              },
            ),
            if (expandedSport == 'Dayung') _buildExpandedCard('Dayung'),
          ],
        ),
      ),
    );
  }
}
