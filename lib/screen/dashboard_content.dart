import 'package:flutter/material.dart';
import 'package:tugas_mobile/models/atlet.dart'; // Import Atlet model
import 'package:tugas_mobile/models/cabang_olahraga.dart'; // Import CabangOlahraga model
import 'package:tugas_mobile/models/pelatih.dart'; // Import Pelatih model
import 'package:tugas_mobile/services/atlet_service.dart'; // Import AtletService
import 'package:tugas_mobile/services/cabang_olahraga.dart'; // Import CabangOlahragaService
import 'package:tugas_mobile/services/pelatih_service.dart'; // Import PelatihService
import 'package:tugas_mobile/views/atlet_by_cabang_screen.dart'; // Import AtletByCabangScreen
import 'package:tugas_mobile/views/pelatih_detail_screen.dart'; // Import PelatihDetailScreen
import '../widgets/info_card.dart';
import '../widgets/sport_tile.dart';

class DashboardContent extends StatefulWidget {
  const DashboardContent({super.key});

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
  String? expandedSportId; // Changed to store ID
  final AtletService _atletService = AtletService();
  final PelatihService _pelatihService = PelatihService();
  final CabangOlahragaService _cabangOlahragaService = CabangOlahragaService();

  Widget _buildExpandedCard(CabangOlahraga cabangOlahraga) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (cabangOlahraga.pelatihId != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PelatihDetailScreen(pelatihId: cabangOlahraga.pelatihId!),
                  ),
                );
              }
            },
            child: InfoCard(
              title: 'Pelatih',
              value: cabangOlahraga.pelatihNama, // Display pelatih name
              icon: Icons.person,
              color: Colors.blue,
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AtletByCabangScreen(
                    cabangOlahragaId: cabangOlahraga.id!,
                    cabangOlahragaNama: cabangOlahraga.namaCabang,
                  ),
                ),
              );
            },
            child: StreamBuilder<int>(
              stream: _atletService.getAtletCountByCabangOlahraga(cabangOlahraga.id!),
              builder: (context, snapshot) {
                final count = snapshot.data ?? 0;
                return InfoCard(
                  title: 'Atlet',
                  value: count.toString(),
                  icon: Icons.people,
                  color: Colors.green,
                );
              },
            ),
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
                StreamBuilder<List<Atlet>>(
                  stream: _atletService.getAtletStream(),
                  builder: (context, snapshot) {
                    final count = snapshot.data?.length ?? 0;
                    return InfoCard(
                      title: 'Total Atlet',
                      value: count.toString(),
                      icon: Icons.people,
                      color: Colors.green,
                    );
                  },
                ),
                SizedBox(width: 12),
                StreamBuilder<List<Pelatih>>(
                  stream: _pelatihService.getPelatih(),
                  builder: (context, snapshot) {
                    final count = snapshot.data?.length ?? 0;
                    return InfoCard(
                      title: 'Total Pelatih',
                      value: count.toString(),
                      icon: Icons.person,
                      color: Colors.blue,
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Cabang Olahraga',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            StreamBuilder<List<CabangOlahraga>>(
              stream: _cabangOlahragaService.getCabang(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('Tidak ada cabang olahraga.');
                }

                final cabangOlahragaList = snapshot.data!;

                return ListView.builder(
                  shrinkWrap: true, // Important for nested ListView
                  physics: const NeverScrollableScrollPhysics(), // Important for nested ListView
                  itemCount: cabangOlahragaList.length,
                  itemBuilder: (context, index) {
                    final cabangOlahraga = cabangOlahragaList[index];
                    return Column(
                      children: [
                        SportTile(
                          name: cabangOlahraga.namaCabang,
                          icon: Icons.fitness_center, // Generic icon for now
                          onTap: () {
                            setState(() {
                              expandedSportId = expandedSportId == cabangOlahraga.id
                                  ? null
                                  : cabangOlahraga.id;
                            });
                          },
                        ),
                        if (expandedSportId == cabangOlahraga.id)
                          _buildExpandedCard(cabangOlahraga),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
