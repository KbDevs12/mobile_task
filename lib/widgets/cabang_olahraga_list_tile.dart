import 'package:flutter/material.dart';
import 'package:tugas_mobile/models/cabang_olahraga.dart';
import 'package:tugas_mobile/services/atlet_service.dart'; // Import AtletService
import 'package:tugas_mobile/services/cabang_olahraga.dart';
import 'package:tugas_mobile/utils/notifikasi.dart';
import 'package:tugas_mobile/views/add_edit_cabang_olahraga_screen.dart';

class CabangOlahragaListTile extends StatelessWidget {
  final CabangOlahraga cabangOlahraga;
  final CabangOlahragaService cabangOlahragaService;
  final AtletService atletService; // Receive AtletService

  const CabangOlahragaListTile({
    super.key,
    required this.cabangOlahraga,
    required this.cabangOlahragaService,
    required this.atletService, // Add to constructor
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: ListTile(
        title: Text(cabangOlahraga.namaCabang, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pelatih: ${cabangOlahraga.pelatihNama}'), // Display pelatihNama
            StreamBuilder<int>(
              stream: atletService.getAtletCountByCabangOlahraga(cabangOlahraga.id!), // Get dynamic count
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text('Jumlah Atlet: Menghitung...');
                }
                if (snapshot.hasError) {
                  return const Text('Jumlah Atlet: Error');
                }
                final count = snapshot.data ?? 0;
                return Text('Jumlah Atlet: $count');
              },
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddEditCabangOlahragaScreen(
                      cabangOlahraga: cabangOlahraga,
                      cabangOlahragaService: cabangOlahragaService,
                    ),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Konfirmasi Hapus'),
                    content: Text('Apakah Anda yakin ingin menghapus cabang olahraga ${cabangOlahraga.namaCabang}?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Batal'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Hapus'),
                      ),
                    ],
                  ),
                );

                if (confirm == true) {
                  try {
                    await cabangOlahragaService.deleteCabang(cabangOlahraga.id!);
                    if (context.mounted) {
                      Notifikasi.show(context, 'Cabang olahraga berhasil dihapus.');
                    }
                  } catch (e) {
                    if (context.mounted) {
                      Notifikasi.show(context, 'Gagal menghapus data: $e', isSuccess: false);
                    }
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
