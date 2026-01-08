import 'package:flutter/material.dart';
import 'package:tugas_mobile/models/cabang_olahraga.dart';
import 'package:tugas_mobile/services/atlet_service.dart'; // Import AtletService
import 'package:tugas_mobile/services/cabang_olahraga.dart';
import 'package:tugas_mobile/views/add_edit_cabang_olahraga_screen.dart';
import 'package:tugas_mobile/widgets/cabang_olahraga_list_tile.dart';

class CabangOlahragaListScreen extends StatefulWidget {
  const CabangOlahragaListScreen({super.key});

  @override
  State<CabangOlahragaListScreen> createState() => _CabangOlahragaListScreenState();
}

class _CabangOlahragaListScreenState extends State<CabangOlahragaListScreen> {
  final CabangOlahragaService _cabangOlahragaService = CabangOlahragaService();
  final AtletService _atletService = AtletService(); // Instantiate AtletService

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Cabang Olahraga'),
      ),
      body: StreamBuilder<List<CabangOlahraga>>(
        stream: _cabangOlahragaService.getCabang(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Belum ada data cabang olahraga.'));
          }
          if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
          }

          final cabangOlahragaList = snapshot.data!;

          return ListView.builder(
            itemCount: cabangOlahragaList.length,
            itemBuilder: (context, index) {
              final cabangOlahraga = cabangOlahragaList[index];
              return CabangOlahragaListTile(
                cabangOlahraga: cabangOlahraga,
                cabangOlahragaService: _cabangOlahragaService,
                atletService: _atletService, // Pass AtletService
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
              builder: (context) => AddEditCabangOlahragaScreen(
                cabangOlahragaService: _cabangOlahragaService,
              ),
            ),
          );
        },
        tooltip: 'Tambah Cabang Olahraga',
        child: const Icon(Icons.add),
      ),
    );
  }
}
