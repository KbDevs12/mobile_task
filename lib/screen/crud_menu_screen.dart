import 'package:flutter/material.dart';
import 'package:tugas_mobile/services/atlet_service.dart';
import 'package:tugas_mobile/services/cabang_olahraga.dart';
import 'package:tugas_mobile/services/pelatih_service.dart';
import 'package:tugas_mobile/views/atlet_list_screen.dart';
import 'package:tugas_mobile/views/cabang_olahraga_list_screen.dart';
import 'package:tugas_mobile/views/pelatih_list_screen.dart';

class CrudMenuScreen extends StatelessWidget {
  const CrudMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Instantiate services here to pass them down
    final AtletService atletService = AtletService();
    final CabangOlahragaService cabangOlahragaService = CabangOlahragaService();
    final PelatihService pelatihService = PelatihService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Data CRUD'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CabangOlahragaListScreen(),
                  ),
                );
              },
              child: const Text('Kelola Cabang Olahraga'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PelatihListScreen(),
                  ),
                );
              },
              child: const Text('Kelola Pelatih'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AtletListScreen(),
                  ),
                );
              },
              child: const Text('Kelola Atlet'),
            ),
          ],
        ),
      ),
    );
  }
}
