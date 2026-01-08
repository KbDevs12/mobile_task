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
      // Card styling from main.dart CardTheme
      child: Padding(
        padding: const EdgeInsets.all(12.0), // Consistent padding
        child: Row(
          children: [
            // Sport Icon
            CircleAvatar(
              radius: 28,
              backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              child: Icon(Icons.sports_tennis, size: 30, color: Theme.of(context).colorScheme.primary), // Generic sport icon
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cabangOlahraga.namaCabang,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Pelatih: ${cabangOlahraga.pelatihNama}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
                  ),
                  StreamBuilder<int>(
                    stream: atletService.getAtletCountByCabangOlahraga(cabangOlahraga.id!), // Get dynamic count
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text('Jumlah Atlet: Menghitung...', style: TextStyle(fontSize: 12));
                      }
                      if (snapshot.hasError) {
                        return const Text('Jumlah Atlet: Error', style: TextStyle(fontSize: 12));
                      }
                      final count = snapshot.data ?? 0;
                      return Text('Jumlah Atlet: $count', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)));
                    },
                  ),
                ],
              ),
            ),
            // Action Buttons
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.primary),
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
                  icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
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
          ],
        ),
      ),
    );
  }
}
