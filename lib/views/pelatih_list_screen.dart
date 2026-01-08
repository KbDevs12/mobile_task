import 'package:flutter/material.dart';
import 'package:tugas_mobile/models/pelatih.dart';
import 'package:tugas_mobile/services/pelatih_service.dart';
import 'package:tugas_mobile/views/add_edit_pelatih_screen.dart'; // Will create this later
import 'package:tugas_mobile/widgets/pelatih_list_tile.dart'; // Will create this later
import 'package:tugas_mobile/widgets/gradient_app_bar.dart'; // Import GradientAppBar

class PelatihListScreen extends StatefulWidget {
  const PelatihListScreen({super.key});

  @override
  State<PelatihListScreen> createState() => _PelatihListScreenState();
}

class _PelatihListScreenState extends State<PelatihListScreen> {
  final PelatihService _pelatihService = PelatihService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(title: 'Daftar Pelatih'),
      body: StreamBuilder<List<Pelatih>>(
        stream: _pelatihService.getPelatih(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Belum ada data pelatih.'));
          }
          if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
          }

          final pelatihList = snapshot.data!;

          return ListView.builder(
            itemCount: pelatihList.length,
            itemBuilder: (context, index) {
              final pelatih = pelatihList[index];
              return PelatihListTile(
                pelatih: pelatih,
                pelatihService: _pelatihService,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditPelatihScreen(
                pelatihService: _pelatihService,
              ),
            ),
          );
        },
        tooltip: 'Tambah Pelatih',
        child: const Icon(Icons.add),
      ),
    );
  }
}
